import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class AddEditBox extends StatelessWidget {
  final String titleText;
  final RxList<String> list;
  final VoidCallback onTap;
  final String? readOnly;
  final String moreText;
  final Rx<TextEditingController>? other;

  const AddEditBox({
    super.key,
    required this.titleText,
    required this.list,
    required this.onTap,
    required this.moreText,
    this.readOnly,
    this.other,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithButton(
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
                    list.contains('H') ||
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
                if (list.contains('H') && other != null)
                  Text(
                    'H : ${other!.value.text}',
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
