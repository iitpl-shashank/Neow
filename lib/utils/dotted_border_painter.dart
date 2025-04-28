import 'common_colors.dart';
import 'package:flutter/material.dart';


class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CommonColors.primaryColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 5;
    double startY = 0;

    // Top border
    while (startY < size.width) {
      canvas.drawLine(Offset(startY, 0), Offset(startY + dashWidth, 0), paint);
      startY += dashWidth + dashSpace;
    }

    startY = 0;

    // Right border
    while (startY < size.height) {
      canvas.drawLine(
          Offset(size.width, startY), Offset(size.width, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    startY = 0;

    // Bottom border
    while (startY < size.width) {
      canvas.drawLine(
          Offset(startY, size.height), Offset(startY + dashWidth, size.height), paint);
      startY += dashWidth + dashSpace;
    }

    startY = 0;

    // Left border
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
