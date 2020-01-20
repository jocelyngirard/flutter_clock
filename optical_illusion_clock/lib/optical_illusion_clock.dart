// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/widget/clock_digits.dart';
import 'package:digital_clock/widget/clock_gradient.dart';
import 'package:digital_clock/widget/clock_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

import 'extension/weathercondition_extensions.dart';
import 'widget/clock_number.dart';

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

  @override
  Widget build(BuildContext context) {
    final clockTheme = ClockTheme.of(context).getTheme(context);
    final toto = Theme.of(context).brightness == Brightness.light;

    final time = DateFormat("${widget.model.is24HourFormat ? 'HH' : 'hh'}mm").format(_dateTime);
    final date = DateFormat.MMMEd().format(_dateTime);
    final ampm = DateFormat('a').format(_dateTime);

    final location = widget.model.location.toString();

    final contentSize = MediaQuery.of(context).size.width / 24;

    final textStyle = TextStyle(fontFamily: 'techno', fontSize: contentSize, color: clockTheme.textColor);
    final titleStyle = TextStyle(fontFamily: 'techno', fontSize: contentSize * 1.8, color: clockTheme.textColor);

    return ClockDigits(
      child: Container(
        padding: EdgeInsets.all(16),
        color: clockTheme.backgroundColor,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 28 / 9,
                  child: ClockGradient(gradientColors: clockTheme.gradientColors),
                ),
                Row(children: time.runes.map((rune) => ClockNumber(rune.toInt() - 48)).toList())
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
                    child: Text(date, style: titleStyle),
                  ),
                  widget.model.is24HourFormat == false
                      ? Align(
                          alignment: Alignment.topRight,
                          child: RichText(
                            text: TextSpan(style: textStyle, children: <TextSpan>[
                              TextSpan(
                                text: "AM",
                                style: TextStyle(
                                  fontFamily: 'techno',
                                  fontSize: contentSize,
                                  color: ampm == "AM" ? clockTheme.textColor : clockTheme.disabledTextColor,
                                ),
                              ),
                              TextSpan(
                                text: " | ",
                                style: TextStyle(
                                  fontFamily: 'techno',
                                  fontSize: contentSize,
                                  color: clockTheme.disabledTextColor,
                                ),
                              ),
                              TextSpan(
                                text: "PM",
                                style: TextStyle(
                                  fontFamily: 'techno',
                                  fontSize: contentSize,
                                  color: ampm == "PM" ? clockTheme.textColor : clockTheme.disabledTextColor,
                                ),
                              ),
                            ]),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            location,
                            style: textStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "${widget.model.weatherCondition.toEmoji()} ${widget.model.temperatureString}",
                          style: titleStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
}
