import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusNewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "New",
        style: GoogleFonts.kanit(
            color: Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusCompletedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF1F1F1),
      ),
      child: Text(
        "Completed",
        style: TextStyle(
            color: Color(0xff656565),
            fontSize: 17,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

class StatusMaintenanceButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF1F1F1),
      ),
      child: Text(
        "Maintenance",
        style: TextStyle(
            color: Color(0xff656565),
            fontSize: 17,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
