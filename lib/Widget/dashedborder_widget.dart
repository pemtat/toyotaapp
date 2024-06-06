import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';

class DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double gap;

  DashedBorderPainter({
    this.strokeWidth = 2,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = white2
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    _drawDashedLine(canvas, const Offset(0, 0), Offset(size.width, 0), paint);
    _drawDashedLine(
        canvas, Offset(size.width, 0), Offset(size.width, size.height), paint);
    _drawDashedLine(
        canvas, Offset(size.width, size.height), Offset(0, size.height), paint);
    _drawDashedLine(canvas, Offset(0, size.height), const Offset(0, 0), paint);
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    double distance = (end - start).distance;
    double dashLength = 5.0;
    double dashSpace = gap;
    double startX = start.dx;
    double startY = start.dy;
    double endX = end.dx;
    double endY = end.dy;

    for (double i = 0; i < distance; i += dashLength + dashSpace) {
      final x = startX + (endX - startX) * (i / distance);
      final y = startY + (endY - startY) * (i / distance);
      final x1 = startX + (endX - startX) * ((i + dashLength) / distance);
      final y1 = startY + (endY - startY) * ((i + dashLength) / distance);
      canvas.drawLine(Offset(x, y), Offset(x1, y1), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
