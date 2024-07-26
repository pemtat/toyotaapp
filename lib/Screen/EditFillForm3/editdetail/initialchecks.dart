import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Styles/inputdecoraton.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class InitialChecks extends GetxController {
  int space = 24;
  int space2 = 8;

  void checkModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget2(
      title: "Initial Checks",
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
                    '(${typeData[0]}) ${ListData[index]}',
                    style: TextStyleList.subtitle3,
                  ),
                  10.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CheckBoxList(
                          selectionsChoose: selectionsChoose,
                          index: index,
                          text: 'Good'),
                      CheckBoxList(
                          selectionsChoose: selectionsChoose,
                          index: index,
                          text: 'Poor'),
                    ],
                  ),
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
    'การทำงานระบบแตร, และระบบพัดลมระบายอากาศ',
    'ป้ายเเละสติ๊กเกอร์ อุปกรณ์เซฟตี้(ไฟ Warning, Head เเละ Safety Belt',
    'การบังคับเลี้ยว, พวงมาลัยเเละขับเคลื่อนหลัก',
    'ปุ่ม Emergency เบรก/ประสิทธิภาพเบรก',
    "แป้นเหยียบเซฟตี้/ เบรกมือ/ Dead man's handle",
    'ฟังชั่นระบบไฮดรอลิค,ยก,สไลด์,กระดก,เลื่อนงานซ้าย-ขวา,หมุนงา(Mini mast)',
    'ทดสอบ ระบบ Parking brake',
    'เช็คสภาพไฟ, Cover',
    'สภาพเเละความสะอาดโดยทั่วไปรอบตัวรถ',
  ];
  List<String> typeData = ['I'];
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
