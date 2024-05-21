import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';

class RepairProcedure extends GetxController {
  var rP = <String>[].obs;
  var rPChoose = <String>[].obs;
  final repairProcedure = TextEditingController().obs;
  final causeProblem = TextEditingController().obs;

  void rPModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Repair Procedure",
              style: TextStyleList.headmodal,
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
              rP.clear();
              rP.addAll(rPChoose);

              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  String getDisplayString() {
    int displayCount = 3;
    if (rP.length <= displayCount) {
      return rP.join(', ');
    } else {
      String displayedItems = rP.sublist(0, displayCount).join(', ');
      int remainingCount = rP.length - displayCount;
      return '$displayedItems +$remainingCount more';
    }
  }

  void rPs(String label) {
    if (rPChoose.contains(label)) {
      rPChoose.remove(label);
    } else {
      rPChoose.add(label);
    }
  }
}
