import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Styles/color.dart';

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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white9),
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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white9),
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
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white9),
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

class StatusFeedBackButton extends StatelessWidget {
  const StatusFeedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "Feedback",
        style: GoogleFonts.kanit(
            color: const Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusResolved extends StatelessWidget {
  const StatusResolved({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "Resolved",
        style: GoogleFonts.kanit(
            color: const Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusAcknowledged extends StatelessWidget {
  const StatusAcknowledged({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "Acknowledged",
        style: GoogleFonts.kanit(
            color: const Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusPendingButton extends StatelessWidget {
  const StatusPendingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "Pending",
        style: GoogleFonts.kanit(
            color: const Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusOnprocessButton extends StatelessWidget {
  const StatusOnprocessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: green2),
      child: Text(
        "On process",
        style: GoogleFonts.kanit(
            color: green3, fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusConfirmedButton extends StatelessWidget {
  const StatusConfirmedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: green2),
      child: Text(
        "Confirmed",
        style: GoogleFonts.kanit(
            color: green3, fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusPlanningButton extends StatelessWidget {
  const StatusPlanningButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white9),
      child: Text(
        "Planning",
        style: GoogleFonts.kanit(
            color: const Color(0xff656565),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class StatusOngoingButton extends StatelessWidget {
  const StatusOngoingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: green2),
      child: Text(
        "Ongoing",
        style: GoogleFonts.kanit(
            color: green3, fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}
