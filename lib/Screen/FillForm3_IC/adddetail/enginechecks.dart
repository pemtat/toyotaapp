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

class EngineChecks extends GetxController {
  int space = 24;
  int space2 = 8;

  void checkModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget2(
      title: context.tr('engine_checks'),
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

  var selectionsChoose = List<String>.filled(6, '').obs;
  var remarksChoose = List<String>.filled(6, '').obs;

  var selections = List<String>.filled(6, '').obs;
  var remarks = List<String>.filled(6, '').obs;
  var additional = List<String>.filled(6, '').obs;
  var isAllFieldsFilled = false.obs;

  List<String> ListData = [
    'เครื่องยนต์ (การทำงาน, เสียงผิดปกติ, การสตาร์ท, ยางรองแท่นเครื่อง, ควันไอเสีย)',
    'กรองอากาศและท่อ (สกปรก, อุดตัน, ความเสียหายต่างๆ)',
    'น้ำมันเครื่องและกรองน้ำมันเครื่อง (สภาพน้ำมัน, ระดับน้ำมัน, การรั่วซึมตามจุดต่างๆ)',
    'เชื้อเพลิงและกรองเชื้อเพลิง/LPG (การรั่วซึม, สภาพอุปกรณ์, การติดตั้ง, น้ำมันดิน)',
    'ระบบระบายความร้อน (รังผึ้งอุดตัน, การรั่วซึม, ระดับน้ำหล่อเย็น, สายพานพัดลม, ท่อ)',
    'แบตเตอรี่ (สภาพแบตเตอรี่, สภาพการชาร์จ, ระดับน้ำกลั่น, ขั้วแบตเตอรี่สกปรก,หลวม)',
  ];

  Map<String, String> choiceMap = {
    '1': '✓',
    '2': 'X',
    '3': '—',
    '4': 'O',
    '5': 'Ø',
  };
  List<String> typeData = [
    'B1',
    'B2',
    'B3',
    'B4',
    'B5',
    'B6',
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
