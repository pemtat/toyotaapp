import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class CheckStatus extends StatelessWidget {
  final String imagePath;
  final String text;
  final Color textColor;

  const CheckStatus({
    super.key,
    required this.imagePath,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 20.0,
          height: 20.0,
          fit: BoxFit.cover,
        ),
        5.wH,
        Text(
          text,
          style: GoogleFonts.kanit(
            fontSize: 14,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
