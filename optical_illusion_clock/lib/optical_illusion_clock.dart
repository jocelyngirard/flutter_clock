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
  textDisabled,
  shadow,
}

final _lightTheme = {_Element.background: Colors.white, _Element.text: Colors.black, _Element.textDisabled: Colors.grey};

final _darkTheme = {_Element.background: Colors.black, _Element.text: Colors.white, _Element.textDisabled: Colors.grey};

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
    final date = DateFormat.MMMEd().format(_dateTime);
    final ampm = DateFormat('a').format(_dateTime);

    final location = widget.model.location.toString();

    final contentSize = MediaQuery.of(context).size.width / 24;

    var textStyle = TextStyle(fontFamily: 'techno', fontSize: contentSize, color: colors[_Element.text]);

    return OpticalIllusionDigits(
      child: Container(
        padding: EdgeInsets.all(16),
        color: colors[_Element.background],
        child: Column(
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
            Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      date,
                      style: textStyle,
                    ),
                  ),
                  widget.model.is24HourFormat == false
                      ? Align(
                          alignment: Alignment.topRight,
                          child: RichText(
                            text: TextSpan(style: textStyle, children: <TextSpan>[
                              TextSpan(
                                text: "AM",
                                style:
                                    TextStyle(fontFamily: 'techno', fontSize: contentSize, color: colors[ampm == "AM" ? _Element.text : _Element.textDisabled]),
                              ),
                              TextSpan(
                                text: " | ",
                                style: TextStyle(fontFamily: 'techno', fontSize: contentSize, color: colors[_Element.textDisabled]),
                              ),
                              TextSpan(
                                text: "PM",
                                style:
                                    TextStyle(fontFamily: 'techno', fontSize: contentSize, color: colors[ampm == "PM" ? _Element.text : _Element.textDisabled]),
                              ),
                            ]),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      location,
                      style: textStyle,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${widget.model.temperatureString} ${widget.model.weatherCondition}",
                      style: textStyle,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
