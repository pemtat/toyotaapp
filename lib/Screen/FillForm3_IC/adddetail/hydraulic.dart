import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Styles/inputdecoraton.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class HydraulicChecks extends GetxController {
  int space = 24;
  int space2 = 8;

  void checkModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget2(
      title: context.tr('hydraulic_system'),
      children: [
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
                  CheckBoxListInBox(
                      choiceMap: choiceMap,
                      selectionsChoose: selectionsChoose,
                      index: index),
                  8.kH,
                  TextField(
                    controller: controller,
                    decoration: InputDecoration1(text: context.tr('remark')),
                    onChanged: (value) {
                      updateSelection(index, value, remarksChoose);
                    },
                  ),
                  20.kH,
                ],
              );
            });
          }),
        ),
        space.kH,
      ],
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
    ).showModal(context);
  }

  var selectionsChoose = List<String>.filled(9, '').obs;
  var remarksChoose = List<String>.filled(9, '').obs;

  var selections = List<String>.filled(9, '').obs;
  var remarks = List<String>.filled(9, '').obs;
  var additional = List<String>.filled(9, '').obs;
  var isAllFieldsFilled = false.obs;

  List<String> ListData = [
    'งา (รอยแตกร้าว, สภาพ, ความหนา, สภาพสลักล็อกงา)',
    'เสา, แผงงา (การทำงาน, หลวมคลอน, การหล่อลื่นจาระบี)',
    'โซ่ (การยึด, การหล่อลื่น)',
    'อุปกรณ์เสริม (สภาพการติดตั้ง, การทำงาน, เสียงดังผิดปกติ, การรั่วซึม, การหล่อลื่น)',
    'ถังน้ำมันไฮดรอลิก (น้ำมันรั่วซึม, ระดับน้ำมันและกรองน้ำมันไฮดรอลิก)',
    'ท่อต่างๆ (น้ำมันรั่วซึม, ระดับน้ำมันและกรองน้ำมันไฮดรอลิก)',
    'ปั๊มไฮดรอลิก (น้ำมันรั่วซึม, เสียงดังผิดปกติ)',
    'กระบอกไฮดรอลิก (น้ำมันรั่วซึม, การทำงาน, สภาพแกน, การยึดแน่น, การอัดจาระบี)',
    'คอนโทรลวาลว์ (น้ำมันรั่วซึม, คันโยกหลวมคลอน, การยึดแน่น)',
  ];

  Map<String, String> choiceMap = {
    '1': '✓',
    '2': 'X',
    '3': '—',
    '4': 'O',
    '5': 'Ø',
  };
  List<String> typeData = [
    'F1',
    'F2',
    'F3',
    'F4',
    'F5',
    'F6',
    'F7',
    'F8',
    'F9',
  ];
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
