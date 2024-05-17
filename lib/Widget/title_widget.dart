import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';

class TitleApp extends StatelessWidget {
  final String text;

  const TitleApp({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyleList.title,
    );
  }
}

class TitleWithButton extends StatelessWidget {
  final String titleText;
  final Widget button;

  const TitleWithButton({
    required this.titleText,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleApp(text: titleText),
        button,
      ],
    );
  }
}
