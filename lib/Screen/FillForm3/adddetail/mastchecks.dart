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

class MastChecks extends GetxController {
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
              "Mast Checks",
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
              final TextEditingController additionalController =
                  additionalControllers[index];
              final TextEditingController subController1 =
                  subControllers1.length > index
                      ? subControllers1[index]
                      : TextEditingController();
              if (subControllers1.length <= index) {
                subControllers1.add(subController1);
              }

              final TextEditingController subController2 =
                  subControllers2.length > index
                      ? subControllers2[index]
                      : TextEditingController();
              if (subControllers2.length <= index) {
                subControllers2.add(subController2);
              }

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
                                controller: subController1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration1(text: unitList[0]),
                                onChanged: (value) {
                                  updateSelectionSub(
                                      index, value, additionalChoose2, 0);
                                },
                              ),
                              6.kH,
                              TextField(
                                controller: subController2,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration1(text: unitList[1]),
                                onChanged: (value) {
                                  updateSelectionSub(
                                      index, value, additionalChoose2, 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      if (index == 2)
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              TextField(
                                controller: additionalController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration1(text: 'mm'),
                                onChanged: (value) {
                                  updateSelection(
                                      index, value, additionalChoose);
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
          text: 'Save',
        ),
      ],
    ).showModal(context);
  }

  var selectionsChoose = List<String>.filled(3, '').obs;
  var remarksChoose = List<String>.filled(3, '').obs;
  var additionalChoose = List<String>.filled(3, '').obs;
  var additionalChoose2 =
      List<List<String>>.generate(6, (_) => List.filled(2, '')).obs;
  var selections = List<String>.filled(3, '').obs;
  var remarks = List<String>.filled(3, '').obs;
  var additional = List<String>.filled(3, '').obs;
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
  List<String> unitList = [
    '% Free lift',
    '% Main lift',
  ];
  List<String> ListData = [
    'การยึดของโซ่ ระยะโซ่ยึดที่วัดได้',
    'เช็คตัวยึดโซ่ทั้งสองด้าน ทุกเส้น เเละทำความสะอาดโซ่ทุกเส้น',
    'ตรวจเช็ค สภาพ/ความหนาที่โคนงา',
  ];
  List<String> typeData = ['M', 'I,W', 'I,M'];
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
    remarksChoose.assignAll(remarks);
    additionalChoose.assignAll(additional);
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
