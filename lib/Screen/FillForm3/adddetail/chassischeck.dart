import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Styles/inputdecoraton.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class ChassisChecks extends GetxController {
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
              "Chassis Checks",
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
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(ListData.length, (index) {
            return Obx(() {
              final TextEditingController controller =
                  TextEditingController(text: remarksChoose[index]);
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              final TextEditingController additionalController =
                  TextEditingController(text: additionalChoose[index]);
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
                      if (index == 2 || index == 4)
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: additionalController,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration1(text: 'mm'),
                            onChanged: (value) {
                              updateSelection(index, value, additionalChoose);
                            },
                          ),
                        ),
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
                  return AlertDialog1();
                },
              );
            }
          },
          text: 'Confirm',
        ),
      ],
    ).showModal(context);
  }

  var selectionsChoose = List<String>.filled(5, '').obs;
  var remarksChoose = List<String>.filled(5, '').obs;
  var additionalChoose = List<String>.filled(5, '').obs;

  var selections = List<String>.filled(5, '').obs;
  var remarks = List<String>.filled(5, '').obs;
  var additional = List<String>.filled(5, '').obs;

  var isAllFieldsFilled = false.obs;

  List<String> ListData = [
    'ตรวจเช็คสกรู,นอต, ยึด, Cover เเละชุดล้อ พร้อมหล่อลื่น',
    'สภาพตัวรถ(บุบ,ฉึก,ถลอก)',
    'สภาพล้อขับ/ความหนาเเก้มยาง',
    'ความหนาแน่นนอตยึดล้อทุกล้อ',
    "สภาพ/ความหนาล้อปลายงา",
  ];
  List<String> typeData = ['I,L', 'I', 'M', 'T', 'M'];
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
