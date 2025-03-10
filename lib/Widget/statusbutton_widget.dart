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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusCloseButton extends StatelessWidget {
  const StatusCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white9),
      child: Text(
        "Closed",
        style: GoogleFonts.kanit(
            color: const Color(0xff656565),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusWaitForApprove extends StatelessWidget {
  const StatusWaitForApprove({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "Wait for Approve",
        style: GoogleFonts.kanit(
            color: const Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusWaitForConfirm extends StatelessWidget {
  const StatusWaitForConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "Wait for Confirm",
        style: GoogleFonts.kanit(
            color: const Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusWaitForPending extends StatelessWidget {
  const StatusWaitForPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white9),
      child: Text(
        "Pending",
        style: GoogleFonts.kanit(
            color: const Color(0xff656565),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusApproved extends StatelessWidget {
  const StatusApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: green2),
      child: Text(
        "Approved",
        style: GoogleFonts.kanit(
            color: green3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusNotApproved extends StatelessWidget {
  const StatusNotApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: green2),
      child: Text(
        "Not Approved",
        style: GoogleFonts.kanit(
            color: green3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusDone extends StatelessWidget {
  const StatusDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: green2),
      child: Text(
        "Done",
        style: GoogleFonts.kanit(
            color: green3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusConfirmed extends StatelessWidget {
  const StatusConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: green2),
      child: Text(
        "Confirmed",
        style: GoogleFonts.kanit(
            color: green3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusReject extends StatelessWidget {
  const StatusReject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 247, 79, 67)),
      child: Text(
        "Reject",
        style: GoogleFonts.kanit(
            color: white3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            color: green3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            color: green3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
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
            color: green3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}

class StatusNotConfirmButton extends StatelessWidget {
  const StatusNotConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 231, 217),
      ),
      child: Text(
        "Not Confirm",
        style: GoogleFonts.kanit(
            color: const Color(0xffF55C02),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none),
      ),
    );
  }
}
