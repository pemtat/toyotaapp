import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Styles/margin.dart';

class JobTitle extends StatelessWidget {
  final String headerText;
  final String buttonText;
  final Function()? buttonOnPressed;

  const JobTitle({
    Key? key,
    required this.headerText,
    required this.buttonText,
    this.buttonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: PaddingApp, right: PaddingApp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerText,
            style: GoogleFonts.kanit(
              color: Color(0xFF272727),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: buttonOnPressed,
            child: Text(
              buttonText,
              style: GoogleFonts.kanit(
                color: Color(0xFF5A5A5A),
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
