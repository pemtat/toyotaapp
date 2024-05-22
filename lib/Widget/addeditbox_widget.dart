import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class AddEditBox extends StatelessWidget {
  final String titleText;
  final RxList<String> list;
  final VoidCallback onTap;
  final String moreText;

  const AddEditBox({
    super.key,
    required this.titleText,
    required this.list,
    required this.onTap,
    required this.moreText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => TitleWithButton(
            titleText: titleText,
            button: list.isEmpty
                ? AddButton(
                    onTap: onTap,
                  )
                : EditButton(onTap: onTap),
          ),
        ),
        Obx(() {
          if (list.isNotEmpty) {
            return Text(
              moreText,
              style: TextStyleList.buttontext,
            );
          } else {
            return const SizedBox();
          }
        })
      ],
    );
  }
}
