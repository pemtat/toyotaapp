import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class ShowCustomerScoreWidget extends StatelessWidget {
  final String customerChecking;
  final String customerScore;
  final String customerDescription;
  const ShowCustomerScoreWidget(
      {super.key,
      required this.customerChecking,
      required this.customerScore,
      required this.customerDescription});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr('customer_checking'),
            style: TextStyleList.text15
                .copyWith(decoration: TextDecoration.underline)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
              activeColor: Colors.red,
              value: 1,
              groupValue: int.parse(customerChecking),
              onChanged: (value) {},
            ),
            Text(context.tr('checking_done')),
            Radio(
              activeColor: Colors.red,
              value: 2,
              groupValue: int.parse(customerChecking),
              onChanged: (value) {},
            ),
            Text(context.tr('checking_not_done')),
          ],
        ),
        10.kH,
        Text(context.tr('customer_score'),
            style: TextStyleList.text15
                .copyWith(decoration: TextDecoration.underline)),
        Wrap(
          children: List.generate(5, (index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  splashRadius: 0,
                  activeColor: Colors.red,
                  value: index + 1,
                  groupValue: int.parse(customerScore),
                  onChanged: (value) {},
                ),
                Text([
                  context.tr('very_satisfied'),
                  context.tr('satisfied'),
                  context.tr('neutral'),
                  context.tr('dissatisfied'),
                  context.tr('need_improvement'),
                ][index]),
              ],
            );
          }),
        ),
        10.kH,
        Text(context.tr('customer_description'),
            style: TextStyleList.text15
                .copyWith(decoration: TextDecoration.underline)),
        10.kH,
        ShowTextFieldWidget(
            text: context.tr('description'), hintText: customerDescription),
      ],
    );
  }
}
