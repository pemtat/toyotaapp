import 'package:flutter/material.dart';

class CustomBorderBox extends StatelessWidget {
  final bool hasGreyBorder;
  final Color fillColor;

  const CustomBorderBox({
    super.key,
    required this.hasGreyBorder,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BorderPainter(hasGreyBorder: hasGreyBorder),
      child: Container(
        width: 35,
        height: 30,
        color: fillColor,
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final bool hasGreyBorder;

  BorderPainter({required this.hasGreyBorder});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(6, 0)
      ..lineTo(size.width - 6, 0)
      ..arcToPoint(
        Offset(size.width, 6),
        radius: const Radius.circular(6),
        clockwise: false,
      )
      ..lineTo(size.width, size.height - 6)
      ..arcToPoint(
        Offset(size.width - 6, size.height),
        radius: const Radius.circular(6),
        clockwise: false,
      )
      ..lineTo(6, size.height)
      ..arcToPoint(
        Offset(0, size.height - 6),
        radius: const Radius.circular(6),
        clockwise: false,
      )
      ..lineTo(0, 6)
      ..arcToPoint(
        const Offset(6, 0),
        radius: const Radius.circular(6),
        clockwise: false,
      );

    paint.color = hasGreyBorder ? Colors.grey : Colors.transparent;
    canvas.drawPath(path, paint);

    if (!hasGreyBorder) {
      paint.color = Colors.red;
      canvas.drawLine(
          const Offset(6, 0), Offset(size.width - 6, 0), paint); // Top border
      canvas.drawLine(Offset(6, size.height),
          Offset(size.width - 6, size.height), paint); // Bottom border
      canvas.drawLine(Offset(size.width, 6),
          Offset(size.width, size.height - 6), paint); // Right border
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
