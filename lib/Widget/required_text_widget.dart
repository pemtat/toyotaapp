import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class RequiredText extends StatelessWidget {
  final MainAxisAlignment? mainAxisAlignment;
  final String? type;
  const RequiredText({super.key, this.mainAxisAlignment, this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          '*',
          style: TextStyleList.text8,
        ),
      ],
    );
  }
}

class RequiredTextLong extends StatelessWidget {
  final MainAxisAlignment? mainAxisAlignment;
  final String? type;
  const RequiredTextLong({super.key, this.mainAxisAlignment, this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Text(
          '(${context.tr('require_field')})',
          style: TextStyleList.detailtext4,
        ),
      ],
    );
  }
}
