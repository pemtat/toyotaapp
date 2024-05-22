import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';

class WarrantyInfo extends StatelessWidget {
  final String title;
  final String value;
  final Widget? trailing;

  const WarrantyInfo({
    super.key,
    required this.title,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyleList.warrantytitle,
        ),
        trailing ??
            Text(
              value,
              style: TextStyleList.warrantytitle2,
            ),
      ],
    );
  }
}
