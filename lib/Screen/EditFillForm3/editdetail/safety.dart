import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class Safety extends GetxController {
  int space = 24;
  int space2 = 8;

  void checkModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr('safety_maintenance'),
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
        8.kH,
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(ListData.length, (index) {
            return Obx(() {
              final TextEditingController controller =
                  TextEditingController(text: remarksChoose[index]);
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '(${typeData[index]}) ${ListData[index]}',
                    style: TextStyleList.subtitle3,
                  ),
                  10.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CheckBoxList(
                          selectionsChoose: selectionsChoose,
                          index: index,
                          text: 'ผ่าน'),
                      3.wH,
                      CheckBoxList(
                          selectionsChoose: selectionsChoose,
                          index: index,
                          text: 'ไม่ผ่าน'),
                    ],
                  ),
                  20.kH,
                ],
              );
            });
          }),
        ),
        space.kH,
        EndButton(
          onPressed: () {
            if (checkAllFieldsFilled()) {
              listClear();
              descriptionAdd();
              listAdd();
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog1();
                },
              );
            }
          },
          text: context.tr('save'),
        ),
      ],
    ).showModal(context);
  }

  var selectionsChoose = List<String>.filled(3, '').obs;
  var remarksChoose = List<String>.filled(3, '').obs;

  var selections = List<String>.filled(3, '').obs;
  var remarks = List<String>.filled(3, '').obs;

  var isAllFieldsFilled = false.obs;

  List<String> ListData = [
    'Travel Alarm',
    'กระจกมองหลัง/ข้าง',
    'เข็ฒขัดนิรภัย',
  ];
  List<String> typeData = ['1', '2', '3'];
  bool checkAllFieldsFilled() {
    for (int i = 0; i < selectionsChoose.length; i++) {
      if (selectionsChoose[i] != '' || remarksChoose[i] != '') {
        isAllFieldsFilled.value = true;
        break;
      }
    }

    return isAllFieldsFilled.value;
  }

  void chooseAdd() {
    selectionsChoose.addAll(selections);
    remarksChoose.assignAll(remarks);
  }

  void chooseClear() {
    selectionsChoose.clear();
  }

  void descriptionAdd() {
    remarks.assignAll(remarksChoose);
  }

  void descriptionClear() {
    remarks.clear();
  }

  void listAdd() {
    selections.assignAll(selectionsChoose);
  }

  void listClear() {
    selections.clear();
  }
}
