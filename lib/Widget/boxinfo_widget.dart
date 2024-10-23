import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';

class BoxInfo extends StatelessWidget {
  final String title;
  final String value;
  final Widget? trailing;
  final String? more;

  const BoxInfo(
      {super.key,
      required this.title,
      required this.value,
      this.trailing,
      this.more});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            title,
            style: TextStyleList.text3,
          ),
        ),
        Row(
          children: [
            trailing ??
                Text(
                  value,
                  style: TextStyleList.text2,
                ),
            if (more != null)
              if (more != '')
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    '(${more ?? '-'})',
                    style: TextStyleList.text9,
                  ),
                ),
          ],
        ),
      ],
    );
  }
}

class BoxInfo2 extends StatelessWidget {
  final String title;
  final String value;
  final bool? space;
  final Widget? trailing;

  const BoxInfo2({
    super.key,
    required this.title,
    required this.value,
    this.trailing,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return space == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyleList.text15,
                ),
              ),
              trailing ??
                  Flexible(
                    child: Text(
                      value,
                      style: TextStyleList.text11,
                    ),
                  ),
            ],
          );
  }
}

class BoxInfo3 extends StatelessWidget {
  final String title;
  final String value;
  final bool? space;
  final Widget? trailing;

  const BoxInfo3({
    super.key,
    required this.title,
    required this.value,
    this.trailing,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return space == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyleList.subtitle1,
              ),
              trailing ??
                  Text(
                    value,
                    style: TextStyleList.text16,
                  ),
            ],
          );
  }
}
