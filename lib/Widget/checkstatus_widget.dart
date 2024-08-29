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
        return const StatusWaitForConfirm();
      case '2':
        return const StatusWaitForApprove();
      case '3':
        return const StatusApproved();
      case '4':
        return const StatusReject();
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
