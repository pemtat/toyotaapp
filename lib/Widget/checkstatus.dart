import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class CheckStatus extends StatelessWidget {
  final String status;

  const CheckStatus({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return status == '1'
        ? Row(
            children: [
              Image.asset(
                'assets/pass.png',
                width: 20.0,
                height: 20.0,
                fit: BoxFit.cover,
              ),
              5.wH,
              Text(
                'Active',
                style: GoogleFonts.kanit(
                    fontSize: 14,
                    color: green1,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ],
          )
        : Row(
            children: [
              Image.asset(
                'assets/notpass.png',
                width: 20.0,
                height: 20.0,
                fit: BoxFit.cover,
              ),
              5.wH,
              Text(
                'InActive',
                style: GoogleFonts.kanit(
                    fontSize: 14,
                    color: red2,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ],
          );
  }
}
