import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Styles/inputdecoraton.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class MeterialHandling extends GetxController {
  int space = 24;
  int space2 = 8;

  void checkModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget2(
      title: 'Meterial Handling System Checks',
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(ListData.length, (index) {
            return Obx(() {
              final TextEditingController controller =
                  TextEditingController(text: remarksChoose[index]);
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '(${typeData[index]}) ${ListData[index]}',
                                style: TextStyleList.subtitle3,
                              ),
                            ]),
                      ),
                      6.wH,
                    ],
                  ),
                  5.kH,
                  CheckBoxList(
                      selectionsChoose: selectionsChoose,
                      index: index,
                      text: 'Ok'),
                  CheckBoxList(
                      selectionsChoose: selectionsChoose,
                      index: index,
                      text: 'Poor'),
                  8.kH,
                  TextField(
                    controller: controller,
                    decoration: InputDecoration1(text: 'Remark'),
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
          text: 'Confirm',
        ),
      ],
    ).showModal(context);
  }

  var selectionsChoose = List<String>.filled(6, '').obs;
  var remarksChoose = List<String>.filled(6, '').obs;
  var additionalChoose = List<String>.filled(6, '').obs;

  var selections = List<String>.filled(6, '').obs;
  var remarks = List<String>.filled(6, '').obs;
  var additional = List<String>.filled(6, '').obs;

  var isAllFieldsFilled = false.obs;

  List<String> ListData = [
    'เป่่าฝุ่น  ตรวจเช็ค นอตยึด ชุดเสา/กระบอก พร้อมหล่อลื่นจุดหมุนต่างๆ',
    'ตรวจเช็คสภาพขอว ตัวกระบอก, แกนกระบอก, รางเสา, เสียงการทำงาน',
    'อัดจารบีตามจุดที่ระบุในคู่มือซ่อม',
    'ตรวจเช็ค โซ่, Roller, สายไฮดรอลิค เเละ ท่อไฮดรอลิค พร้อมปรับตั้ง',
    "ทำความสะอาด Main Valve, ตรวจสอบจุดเชื่อมต่อวาล์ว ข้อต่อ",
    "ตรวจเช็ค ถังไฮดรอลิค, ถัง Accumulator เเละ ระดับน้ำมัน",
  ];
  List<String> typeData = ['I,T,L', 'I,H', 'L', 'I', 'I,W', 'I,M'];
  bool checkAllFieldsFilled() {
    for (int i = 0; i < selectionsChoose.length; i++) {
      if (selectionsChoose[i] != '' ||
          remarksChoose[i] != '' ||
          additionalChoose[i] != '') {
        isAllFieldsFilled.value = true;
        break;
      }
    }

    return isAllFieldsFilled.value;
  }

  void chooseAdd() {
    selectionsChoose.addAll(selections);
  }

  void chooseClear() {
    selectionsChoose.clear();
  }

  void descriptionAdd() {
    remarks.assignAll(remarksChoose);
    additional.assignAll(additionalChoose);
  }

  void descriptionClear() {
    remarks.clear();
    additional.clear();
  }

  void listAdd() {
    selections.assignAll(selectionsChoose);
  }

  void listClear() {
    selections.clear();
  }
}
