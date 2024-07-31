import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';

class TitleApp extends StatelessWidget {
  final String text;

  const TitleApp({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyleList.subtitle1,
    );
  }
}

class TitleApp2 extends StatelessWidget {
  final String text;
  final String? moreText;

  const TitleApp2({super.key, required this.text, this.moreText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyleList.subtitle1,
          ),
        ),
        if (moreText != null)
          Text(
            moreText ?? '',
            style: TextStyleList.text10,
          ),
      ],
    );
  }
}

class TitleWithButton extends StatelessWidget {
  final String titleText;
  final Widget button;
  final bool? space;

  const TitleWithButton({
    super.key,
    this.space,
    required this.titleText,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return space == null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: TitleApp(text: titleText)),
              button,
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleApp(text: titleText),
              button,
            ],
          );
  }
}

class TitleWithButton2 extends StatelessWidget {
  final String titleText;
  final VoidCallback onTap;
  final bool button;
  final TextStyle? font;

  const TitleWithButton2({
    super.key,
    required this.titleText,
    required this.button,
    required this.onTap,
    this.font,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            titleText,
            style: font ?? TextStyleList.text9,
          ),
          button ? Image.asset('assets/arrowright.png') : const SizedBox()
        ]));
  }
}
