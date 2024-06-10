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
        return const StatusAssignedButton();
      case 'closed':
        return const StatusCompletedButton();
      case 'confirmed':
        return const StatusOnprocessButton();
      case 'feedback':
        return const StatusFeedBackButton();
      case 'pending':
        return const StatusPendingButton();
      case 'ongoing':
        return const StatusOngoingButton();
      default:
        return const SizedBox();
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
      case 'confirmed':
        return green3;
      case 'feedback':
        return orange1;
      case 'pending':
        return orange1;
      case 'ongoing':
        return green3;
      default:
        return orange1;
    }
  }
}
