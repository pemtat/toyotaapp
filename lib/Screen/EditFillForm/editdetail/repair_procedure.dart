import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/repair_procedure.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';

class RepairProcedure extends GetxController {
  int space = 24;

  void rPModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Repair Procedure",
              style: TextStyleList.subheading,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        20.kH,
        TextFieldType(
          hintText: 'Repair Procedure',
          textSet: repairProcedure.value,
        ),
        20.kH,
        TextFieldType(
          hintText: 'Cause of the problem',
          textSet: causeProblem.value,
        ),
        20.kH,
        EndButton(
            onPressed: () {
              rPWrite();
              rPClear();
              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  void rPEditModal(BuildContext context, RepairProcedureModel part) {
    rPRead(part);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Spare part list",
              style: TextStyleList.subheading,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Repair Procedure',
          textSet: repairProcedure.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Cause of the problem',
          textSet: causeProblem.value,
        ),
        space.kH,
        EndButton(
            onPressed: () {
              rPUpdate(part);
              repairProcedureList.refresh();
              rPClear();
              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  var repairProcedureList = <RepairProcedureModel>[].obs;
  final repairProcedure = TextEditingController().obs;
  final causeProblem = TextEditingController().obs;

  void rPWrite() {
    String repairProcedureValue =
        repairProcedure.value.text != '' ? repairProcedure.value.text : '-';
    String causeProblemValue =
        causeProblem.value.text != '' ? causeProblem.value.text : '-';
    repairProcedureList.add(RepairProcedureModel(
      repairProcedure: repairProcedureValue,
      causeProblem: causeProblemValue,
    ));
  }

  void rPRead(RepairProcedureModel part) {
    repairProcedure.value.text = part.repairProcedure;
    causeProblem.value.text = part.causeProblem;
  }

  void rPClear() {
    repairProcedure.value.clear();
    causeProblem.value.clear();
  }

  void rPUpdate(RepairProcedureModel part) {
    String repairProcedureValue =
        repairProcedure.value.text != '' ? repairProcedure.value.text : '-';
    String causeProblemValue =
        causeProblem.value.text != '' ? causeProblem.value.text : '-';
    part.repairProcedure = repairProcedureValue;
    part.causeProblem = causeProblemValue;
  }
}
