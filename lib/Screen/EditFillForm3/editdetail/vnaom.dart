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

class VnaOm extends GetxController {
  int space = 24;
  int space2 = 8;

  void checkModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget2(
      title: context.tr('vna_om_checks'),
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(ListData.length, (index) {
            additionalControllers[index].text = additional[index];

            return Obx(() {
              final TextEditingController controller =
                  TextEditingController(text: remarksChoose[index]);
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              final TextEditingController additionalController =
                  additionalControllers[index];
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
                      if (index == 1)
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

  var selectionsChoose = List<String>.filled(4, '').obs;
  var remarksChoose = List<String>.filled(4, '').obs;
  var additionalChoose = List<String>.filled(4, '').obs;

  var selections = List<String>.filled(4, '').obs;
  var remarks = List<String>.filled(4, '').obs;
  var additional = List<String>.filled(4, '').obs;

  var isAllFieldsFilled = false.obs;
  final List<TextEditingController> additionalControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  List<String> ListData = [
    'การทำงาน Rall/Wire-guided, แม่เหล็กและระบบ Optipace',
    'สภาพ/ความหนาล้อประคอง (Roller)',
    'ตรวจเช็คสภาพ/ความตึง สายพาน, Roller พร้อมปรับตั้ง',
    'สังเกต/ทดสอบ การทำงานชุด Cabin (เสียง,ความราบเรียบ)',
  ];
  List<String> typeData = [
    'I',
    'M',
    'I',
    'I,H',
  ];
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
    remarksChoose.assignAll(remarks);
    additionalChoose.assignAll(additional);
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
