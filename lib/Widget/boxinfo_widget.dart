import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';

class BoxInfo extends StatelessWidget {
  final String title;
  final String value;
  final Widget? trailing;

  const BoxInfo({
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
        Flexible(
          child: Text(
            title,
            style: TextStyleList.text3,
          ),
        ),
        trailing ??
            Text(
              value,
              style: TextStyleList.text2,
            ),
      ],
    );
  }
}

class BoxInfo2 extends StatelessWidget {
  final String title;
  final String value;
  final Widget? trailing;

  const BoxInfo2({
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
          style: TextStyleList.text15,
        ),
        trailing ??
            Text(
              value,
              style: TextStyleList.text11,
            ),
      ],
    );
  }
}
