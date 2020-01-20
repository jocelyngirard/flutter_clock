import 'dart:math';

import 'package:flutter/material.dart';

class ClockTilePainter extends CustomPainter {
  final bool isActive;
  final Color backgroundColor;

  ClockTilePainter({this.isActive = false, this.backgroundColor = Colors.white});

  @override
  bool shouldRepaint(ClockTilePainter oldDelegate) {
    return oldDelegate.isActive != isActive;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var quarter = sqrt(pow(size.width, 2) + pow(size.height, 2)) / 4;
    var outsideOffset = quarter / 2;

    canvas.clipRect(Rect.fromPoints(Offset(-.3, -.3), Offset(size.width + .3, size.height + .3)));

    if (isActive) {
      canvas.save();
      canvas.translate(size.width, 0);
      canvas.rotate(90 * pi / 180);
    }

    var paint = Paint()
      ..color = backgroundColor
      ..isAntiAlias = true
      ..strokeWidth = quarter;

    var x1 = Offset(0 - outsideOffset, size.height / 2 - outsideOffset);
    var y1 = Offset(size.width / 2 + outsideOffset, size.height + outsideOffset);
    canvas.drawLine(x1, y1, paint);

    var x2 = Offset(size.width / 2 - outsideOffset, 0 - outsideOffset);
    var y2 = Offset(size.width + outsideOffset, size.height / 2 + outsideOffset);
    canvas.drawLine(x2, y2, paint);

    if (isActive) {
      canvas.restore();
    }
  }
}
