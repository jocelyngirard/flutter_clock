import 'package:flutter/material.dart';

import 'clock_tile.dart';

class ClockNumber extends StatefulWidget {
  @override
  _ClockNumberState createState() => _ClockNumberState();
}

class _ClockNumberState extends State<ClockNumber> {





  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 7,
        children: List.generate(63, (index) {
          return CustomPaint(painter: ClockTilePainter(), child: Container());
        }),
      ),
    );
  }
}
