import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/required_text_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class TitleApp extends StatelessWidget {
  final String text;
  final String? required;

  const TitleApp({super.key, required this.text, this.required});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyleList.subtitle1,
        ),
        if (required != null)
          Row(
            children: [
              4.wH,
              const Center(child: RequiredText()),
            ],
          ),
      ],
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
  final String? required;
  final bool? space;

  const TitleWithButton({
    super.key,
    this.space,
    this.required,
    required this.titleText,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return space == null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: TitleApp(
                text: titleText,
                required: required,
              )),
              button,
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleApp(text: titleText, required: required),
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
