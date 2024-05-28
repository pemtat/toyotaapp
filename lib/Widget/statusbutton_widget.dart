import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusNewButton extends StatelessWidget {
  const StatusNewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "New",
        style: GoogleFonts.kanit(
            color: const Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusCompletedButton extends StatelessWidget {
  const StatusCompletedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF1F1F1),
      ),
      child: Text(
        "Completed",
        style: GoogleFonts.kanit(
            color: const Color(0xff656565),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusMaintenanceButton extends StatelessWidget {
  const StatusMaintenanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF1F1F1),
      ),
      child: Text(
        "Maintenance",
        style: GoogleFonts.kanit(
            color: const Color(0xff656565),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusAssignedButton extends StatelessWidget {
  const StatusAssignedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF1F1F1),
      ),
      child: Text(
        "Assigned",
        style: GoogleFonts.kanit(
            color: const Color(0xff656565),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
