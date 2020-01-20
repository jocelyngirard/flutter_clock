// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

import 'clock_number.dart';
import 'optical_illusion_digits.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Colors.white,
  _Element.text: Colors.white,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
};

class OpticalIllusionClock extends StatefulWidget {
  const OpticalIllusionClock(this.model);

  final ClockModel model;

  @override
  _OpticalIllusionClockState createState() => _OpticalIllusionClockState();
}

class _OpticalIllusionClockState extends State<OpticalIllusionClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(OpticalIllusionClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) - Duration(seconds: _dateTime.second) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light ? _lightTheme : _darkTheme;
    final time = DateFormat("${widget.model.is24HourFormat ? 'HH' : 'hh'}mm").format(_dateTime);

    return OpticalIllusionDigits(
      child: Container(
        padding: EdgeInsets.all(16),
        color: colors[_Element.background],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 28 / 9,
                  child: AnimatedBackground(),
                ),
                Row(
                  children: time.runes.map((rune) => ClockNumber(rune.toInt() - 48)).toList(),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.model.location,
                  style: TextStyle(fontFamily: 'square-deal', fontSize: MediaQuery.of(context).size.width / 16),
                ),
                Text(
                  widget.model.temperatureString,
                  style: TextStyle(fontFamily: 'square-deal', fontSize: MediaQuery.of(context).size.width / 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
