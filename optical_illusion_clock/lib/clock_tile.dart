import 'dart:math';

import 'package:flutter/material.dart';

class ClockTilePainter extends CustomPainter {
  final bool isActive;

  ClockTilePainter({this.isActive = false});

  @override
  bool shouldRepaint(ClockTilePainter oldDelegate) {
    return oldDelegate.isActive != isActive;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var quarter = sqrt(pow(size.width, 2) + pow(size.height, 2)) / 4;
    var outsideOffset = quarter / 2;

    canvas.clipRect(Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)));

    if (isActive) {
      canvas.save();
      canvas.translate(size.width, 0);
      canvas.rotate(90 * pi / 180);
    }

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = quarter;

    canvas.drawLine(
      Offset(0 - outsideOffset, size.height / 2 - outsideOffset),
      Offset(size.width / 2 + outsideOffset, size.height + outsideOffset),
      paint,
    );
    canvas.drawLine(
      Offset(size.width / 2 - outsideOffset, 0 - outsideOffset),
      Offset(size.width + outsideOffset, size.height / 2 + outsideOffset),
      paint,
    );

    if (isActive) {
      canvas.restore();
    }
  }
}
