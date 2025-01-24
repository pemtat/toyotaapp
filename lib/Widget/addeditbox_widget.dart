import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class AddEditBox extends StatelessWidget {
  final String titleText;
  final RxList<String> list;
  final VoidCallback onTap;
  final String? readOnly;
  final String moreText;
  final String? required;
  final Rx<TextEditingController>? other;
  final Rx<TextEditingController>? other2;

  const AddEditBox(
      {super.key,
      required this.titleText,
      required this.list,
      required this.onTap,
      required this.moreText,
      this.readOnly,
      this.other,
      this.other2,
      this.required});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithButton(
          required: required,
          titleText: titleText,
          button: readOnly == null
              ? list.isEmpty
                  ? AddButton(
                      onTap: onTap,
                    )
                  : EditButton(onTap: onTap)
              : Container(),
        ),
        Obx(() {
          if (list.isNotEmpty) {
            bool hasOtherOnly = list.length == 1 &&
                (list.contains('Other') ||
                    list.contains('Replace new cell battery') ||
                    list.contains('M'));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!hasOtherOnly)
                  Text(
                    moreText,
                    style: TextStyleList.text12,
                  ),
                if (list.contains('Other') && other != null)
                  Text(
                    'Other : ${other!.value.text}',
                    style: TextStyleList.text12,
                  ),
                if (list.contains('Other') && other == null && list.length == 1)
                  Text(
                    'Other',
                    style: TextStyleList.text12,
                  ),
                if (list.contains('Replace new cell battery') && other2 != null)
                  Text(
                    'Replace new cell battery : ${other2!.value.text}',
                    style: TextStyleList.text12,
                  ),
                if (list.contains('M') && other != null)
                  Text(
                    'M : ${other!.value.text}',
                    style: TextStyleList.text12,
                  ),
              ],
            );
          } else {
            return const SizedBox();
          }
        })
      ],
    );
  }
}
