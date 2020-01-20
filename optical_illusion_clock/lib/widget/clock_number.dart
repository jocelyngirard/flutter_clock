import 'package:flutter/material.dart';

import '../painter/clock_tile_painter.dart';
import 'clock_digits.dart';

class ClockNumber extends StatefulWidget {
  final int number;

  const ClockNumber(this.number, {Key key}) : super(key: key);

  @override
  _ClockNumberState createState() => _ClockNumberState();
}

class _ClockNumberState extends State<ClockNumber> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: ClockDigits.of(context)
            .digits[widget.number]
            .split("\n")
            .map(
              (line) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.from(
                  line.runes.map(
                    (rune) => Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CustomPaint(
                          painter: ClockTilePainter(isActive: rune.toString() == "49"),
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
