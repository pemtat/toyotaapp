import 'package:flutter/material.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

void showApproveSparePart(BuildContext context, String title, String left,
    String right, VoidCallback onTap, Color rightColor) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DialogAlert(
          rightColor: rightColor,
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: onTap);
    },
  );
}
