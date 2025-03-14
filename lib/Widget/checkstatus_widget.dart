import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/statusbutton_widget.dart';

class StatusButton extends StatelessWidget {
  final String status;

  const StatusButton({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 'new':
        return const StatusNewButton();
      case 'assigned':
        return const StatusPendingButton();
      case 'closed':
        return const StatusCloseButton();
      case 'completed':
        return const StatusCompletedButton();
      case 'confirmed':
        return const StatusOnprocessButton();
      case 'onprocess':
        return const StatusOnprocessButton();
      case 'feedback':
        return const StatusFeedBackButton();
      case 'acknowledged':
        return const StatusAcknowledged();
      case 'resolved':
        return const StatusResolved();
      case 'pending':
        return const StatusPendingButton();
      case 'ongoing':
        return const StatusOngoingButton();
      case 'notconfirm':
        return const StatusNotConfirmButton();
      case 'planning':
        return const StatusPlanningButton();
      default:
        return const StatusPendingButton();
    }
  }
}

class StatusButton2 extends StatelessWidget {
  final String status;

  const StatusButton2({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case '1':
        return const StatusConfirmed();
      case '2':
        return const StatusReject();
      default:
        return const StatusWaitForPending();
    }
  }
}

class StatusButton3 extends StatelessWidget {
  final String status;

  const StatusButton3({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case '0':
        return const StatusWaitForPending();
      case '1':
        return const StatusOnprocessButton();
      case '2':
        return const StatusApproved();
      case '3':
        return const StatusNotApproved();
      default:
        return const StatusWaitForPending();
    }
  }
}

class StatusButton4 extends StatelessWidget {
  final String status;

  const StatusButton4({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case '0':
        return const StatusNewButton();
      case '1':
        return const StatusNewButton();
      case '2':
        return const StatusOnprocessButton();
      case '3':
        return const StatusDone();
      default:
        return const StatusWaitForPending();
    }
  }
}

class SidebarColor {
  static Color getColor(String status) {
    switch (status) {
      case 'new':
        return orange1;
      case 'assigned':
        return black6;
      case 'closed':
        return black6;
      case 'completed':
        return black6;
      case 'confirmed':
        return green3;
      case 'feedback':
        return orange1;
      case 'notconfirm':
        return orange1;
      case 'pending':
        return orange1;
      case 'ongoing':
        return green3;
      case 'planning':
        return black6;
      default:
        return orange1;
    }
  }
}
