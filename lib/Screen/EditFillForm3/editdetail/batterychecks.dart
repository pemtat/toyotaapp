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

class BatteryChecks extends GetxController {
  int space = 24;
  int space2 = 8;

  void checkModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget2(
      title: 'Battery Checks',
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

              final TextEditingController additionalController =
                  additionalControllers[index];
              final TextEditingController subController1 =
                  index == 1 ? subControllers1[index] : TextEditingController();
              final TextEditingController subController2 =
                  index == 1 ? subControllers2[index] : TextEditingController();
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
                      if (index == 0)
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              TextField(
                                controller: additionalController,
                                decoration: InputDecoration1(text: 's.g.'),
                                onChanged: (value) {
                                  updateSelection(
                                      index, value, additionalChoose);
                                },
                              ),
                            ],
                          ),
                        ),
                      if (index == 1)
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              TextField(
                                controller: subController1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration1(text: 'v. Unload'),
                                onChanged: (value) {
                                  updateSelectionSub(
                                      index, value, additionalChoose2, 0);
                                },
                              ),
                              6.kH,
                              TextField(
                                controller: subController2,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration1(text: 'v. Load'),
                                onChanged: (value) {
                                  updateSelectionSub(
                                      index, value, additionalChoose2, 1);
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
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

  var selectionsChoose = List<String>.filled(6, '').obs;
  var remarksChoose = List<String>.filled(6, '').obs;
  var additionalChoose = List<String>.filled(6, '').obs;
  var additionalChoose2 =
      List<List<String>>.generate(6, (_) => List.filled(2, '')).obs;

  var selections = List<String>.filled(6, '').obs;
  var remarks = List<String>.filled(6, '').obs;
  var additional = List<String>.filled(6, '').obs;
  var additional2 =
      List<List<String>>.generate(6, (_) => List.filled(2, '')).obs;

  var isAllFieldsFilled = false.obs;
  final List<TextEditingController> subControllers1 = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<TextEditingController> subControllers2 = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<TextEditingController> additionalControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  List<String> ListData = [
    'ตรวจเช็คระดับ น้ำกลั่น ค่า ถ.พ,',
    'โวลต์รวม',
    'ตรวจเช็ค "การโยก" ของรางแบตฯ(ต้องไม่มีโอกาสหนีบสายแบตฯ)',
    'ปลั๊กแบตฯ (บุบ,ฉีก,แตก) หริอไม่',
    "สภาพสายเคเบิ้ล, ทำความสะอาด ขั้วเเละถังแบตฯ",
    "ตรวจเช็คสภาพตัวล็อกแบตฯ",
  ];
  List<String> unitList = [
    'v. Unload',
    'v. Load',
  ];

  List<String> typeData = ['I,M', 'M', 'I', 'I', 'I,W', 'I'];
  bool checkAllFieldsFilled() {
    for (int i = 0; i < selectionsChoose.length; i++) {
      if (selectionsChoose[i] != '' ||
          remarksChoose[i] != '' ||
          additionalChoose[i] != '' ||
          additionalChoose2[i][0] != '' ||
          additionalChoose2[i][1] != '') {
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
    additional2.assignAll(additionalChoose2);
  }

  void descriptionClear() {
    remarks.clear();
    additional.clear();
    additional2.clear();
  }

  void listAdd() {
    selections.assignAll(selectionsChoose);
  }

  void listClear() {
    selections.clear();
  }
}
