import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class CorrectiveAction extends GetxController {
  int space = 24;
  void correctiveActionModal(BuildContext context) {
    correctiveActionChoose.clear();
    correctiveActionChoose.addAll(correctiveAction);
    otherChoose.value.text = other2.text;

    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr('corrective_action'),
              style: TextStyleList.subheading,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset("assets/x.png"),
            ),
          ],
        ),
        16.kH,
        ListView.builder(
          shrinkWrap: true,
          itemCount: correctiveActionList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckBoxWidget(
                  option: 'yes',
                  other: otherChoose,
                  text: correctiveActionList[index],
                  listItem: correctiveActionChoose,
                  itemSet: correctiveActionChoose,
                ));
          },
        ),
        Obx(() {
          if (correctiveActionChoose.contains('Other')) {
            return Column(
              children: [
                6.kH,
                TextFieldEditWidget(
                  text: context.tr('other'),
                  textSet: otherChoose.value,
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
        space.kH,
        EndButton(
          onPressed: () {
            correctiveAction.clear();
            other.value = otherChoose.value;
            other2.text = otherChoose.value.text;
            correctiveAction.addAll(correctiveActionChoose);
            Navigator.pop(context);
          },
          text: context.tr('save'),
        ),
      ],
    ).showModal(context);
  }

  var correctiveAction = <String>[].obs;
  var correctiveActionChoose = <String>[].obs;
  final other = TextEditingController().obs;
  final other2 = TextEditingController();
  final otherChoose = TextEditingController().obs;

  List<String> correctiveActionList = [
    'New battery set',
    'New battery cell',
    'New components',
    'Equalizing charge',
    'Sp.Gr.Adjustment',
    'เกิดอุบัติเหตุ(เสนอราคา)',
    'Other',
  ];
}
