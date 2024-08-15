import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class RepairResult extends GetxController {
  void repairResultModal(BuildContext context) {
    otherChoose.value.text = other2.text;
    repairResultChoose.clear();
    repairResultChoose.addAll(repairResult);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Result",
              style: TextStyleList.subheading,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        8.kH,
        ListView.builder(
          shrinkWrap: true,
          itemCount: repairResultList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CheckBoxWidget(
                  other: otherChoose,
                  option: 'true',
                  text: repairResultList[index],
                  listItem: repairResultChoose,
                  itemSet: repairResultChoose),
            );
          },
        ),
        Obx(() {
          if (repairResultChoose.contains('HR')) {
            return Column(
              children: [
                TextFieldEditWidget(
                  text: 'HR',
                  textSet: otherChoose.value,
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
        Obx(() {
          if (repairResultChoose.contains('M')) {
            return Column(
              children: [
                TextFieldEditWidget(
                  text: 'M',
                  textSet: otherChoose.value,
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
        16.kH,
        EndButton(
            onPressed: () {
              repairResult.clear();
              repairResult.addAll(repairResultChoose);
              other.value = otherChoose.value;
              other2.text = otherChoose.value.text;
              Navigator.pop(context);
            },
            text: 'Save')
      ],
    ).showModal(context);
  }

  final other = TextEditingController().obs;
  final otherChoose = TextEditingController().obs;
  final other2 = TextEditingController();
  var repairResult = <String>[].obs;
  var repairResultChoose = <String>[].obs;
  List<String> repairResultList = [
    'Run',
    'Temporary',
    'Stop',
    'HR',
    'M',
  ];
}
