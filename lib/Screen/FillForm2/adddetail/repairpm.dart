import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class RepairPM extends GetxController {
  int space = 24;
  void repairPMModal(BuildContext context) {
    repairPmChoose.clear();
    repairPmChoose.addAll(repairPm);

    otherChoose.value.text = other2.text;
    otherCellChoose.value.text = otherCell2.text;
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr('repair_pm_battery'),
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
        16.kH,
        ListView.builder(
          shrinkWrap: true,
          itemCount: repairPmList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CheckBoxWidget(
                  option: 'yes',
                  other: otherChoose,
                  other2: otherCellChoose,
                  text: repairPmList[index],
                  listItem: repairPmChoose,
                  itemSet: repairPmChoose,
                ));
          },
        ),
        Obx(() {
          if (repairPmChoose.contains('Other')) {
            return Column(
              children: [
                6.kH,
                TextFieldEditWidget(
                  text: context.tr('other'),
                  textSet: otherChoose.value,
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
        Obx(() {
          if (repairPmChoose.contains('Replace new cell battery')) {
            return Column(
              children: [
                6.kH,
                TextFieldEditWidget(
                  text: context.tr('cell_battery'),
                  textSet: otherCellChoose.value,
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
        space.kH,
        EndButton(
          onPressed: () {
            repairPm.clear();
            other.value = otherChoose.value;
            other2.text = otherChoose.value.text;
            otherCell.value = otherCellChoose.value;
            otherCell2.text = otherCellChoose.value.text;
            repairPm.addAll(repairPmChoose);
            Navigator.pop(context);
          },
          text: context.tr('save'),
        ),
      ],
    ).showModal(context);
  }

  var repairPm = <String>[].obs;
  var repairPmChoose = <String>[].obs;
  final other = TextEditingController().obs;
  final other2 = TextEditingController();
  final otherChoose = TextEditingController().obs;
  final otherCell = TextEditingController().obs;
  final otherCell2 = TextEditingController();
  final otherCellChoose = TextEditingController().obs;
  List<String> repairPmList = [
    'Sp.Gr. Adjustment done',
    'Clean battery',
    'Rell distilled water',
    'Replace new cell battery',
    'Replace new components',
    'Equalizing charge',
    'Other',
  ];
}
