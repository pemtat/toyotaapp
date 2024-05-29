import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class TimeLineItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String dateTime;
  final String description;
  final bool? isLast;
  final String status;

  const TimeLineItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.status,
    this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Image.asset(
              imagePath,
              width: 16.0,
              height: 16.0,
            ),
            if (isLast != true)
              CustomPaint(
                size: Size(2, 50),
                painter: DashedLinePainter(),
              ),
          ],
        ),
        16.wH,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title, style: TextStyleList.subtext5),
                  3.wH,
                  Text(
                    dateTime,
                    style: TextStyleList.subtext4,
                  ),
                  Spacer(),
                  if (status == 'pending') ...[
                    Text(
                      'Pending',
                      style: TextStyleList.subtext6,
                    )
                  ] else if (status == 'done') ...[
                    Text('Done', style: TextStyleList.subtext4)
                  ],
                ],
              ),
              Text(
                description,
                style: TextStyleList.text10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1;

    const dashWidth = 5;
    const dashSpace = 5;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
