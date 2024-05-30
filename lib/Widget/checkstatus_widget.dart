import 'package:flutter/material.dart';
import 'package:toyotamobile/Widget/statusbutton_widget.dart';

class StatusButton extends StatelessWidget {
  final String status;

  const StatusButton({Key? key, required this.status}) : super(key: key);

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
      default:
        return const SizedBox();
    }
  }
}
