import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Styles/margin.dart';

class JobTitle extends StatelessWidget {
  final String headerText;
  final String buttonText;
  final Function()? buttonOnPressed;

  const JobTitle({
    super.key,
    required this.headerText,
    required this.buttonText,
    this.buttonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: paddingApp, right: paddingApp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerText,
            style: GoogleFonts.kanit(
              color: const Color(0xFF272727),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: buttonOnPressed,
            child: Text(
              buttonText,
              style: GoogleFonts.kanit(
                color: const Color(0xFF5A5A5A),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
