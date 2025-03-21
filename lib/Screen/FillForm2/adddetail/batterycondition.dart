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

class BatteryCondition extends GetxController {
  int space = 24;
  int space2 = 8;

  void checkModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget2(
      title: context.tr('battery_condition'),
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
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ListData[index],
                                style: TextStyleList.subtitle3,
                              ),
                            ]),
                      ),
                      if (index == 2)
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              CheckBoxList(
                                  selectionsChoose: additionalChoose,
                                  index: index,
                                  text: 'Auto Filter'),
                              CheckBoxList(
                                  selectionsChoose: additionalChoose,
                                  index: index,
                                  text: 'Manual'),
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
                    decoration:
                        InputDecoration1(text: context.tr('description')),
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

  var selectionsChoose = List<String>.filled(12, '').obs;
  var remarksChoose = List<String>.filled(12, '').obs;
  var additionalChoose = List<String>.filled(12, '').obs;

  var selections = List<String>.filled(12, '').obs;
  var remarks = List<String>.filled(12, '').obs;
  var additional = List<String>.filled(12, '').obs;

  var isAllFieldsFilled = false.obs;

  List<String> ListData = [
    'Tray',
    'Container',
    'Vent Plug',
    'Connector',
    'Cover',
    'Terminal',
    'Cable+Plug',
    'Voltage',
    'Sp.Gr.',
    'Temperature',
    'Acid',
    'Plates',
  ];
  List<String> typeData = [''];
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
    additionalChoose.assignAll(additional);
    remarksChoose.assignAll(remarks);
  }

  void chooseClear() {
    selectionsChoose.clear();
    additionalChoose.clear();
  }

  void descriptionAdd() {
    remarks.assignAll(remarksChoose);
  }

  void descriptionClear() {
    remarks.clear();
  }

  void listAdd() {
    selections.assignAll(selectionsChoose);
    additional.assignAll(additionalChoose);
  }

  void listClear() {
    selections.clear();
    additional.clear();
  }
}
