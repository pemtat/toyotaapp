import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class RepairStaff extends GetxController {
  var repairStaff = <String>[].obs;
  var repairStaffChoose = <String>[].obs;
  List<String> repairStaffList = [
    'Quotation',
    'Claim',
    'Close Job',
    'Repair',
    'Follow',
  ];

  void repairStaffModal(BuildContext context) {
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Process",
              style: TextStyleList.subheading,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        8.kH,
        ListView.builder(
          shrinkWrap: true,
          itemCount: repairStaffList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CheckBoxWidget(
                  text: repairStaffList[index],
                  listItem: repairStaffChoose,
                  itemSet: repairStaffs),
            );
          },
        ),
        8.kH,
        EndButton(
            onPressed: () {
              repairStaff.clear();
              repairStaff.addAll(repairStaffChoose);

              Navigator.pop(context);
            },
            text: 'Confirm')
      ],
    ).showModal(context);
  }

  String getDisplayString() {
    int displayCount = 3;
    if (repairStaff.length <= displayCount) {
      return repairStaff.join(', ');
    } else {
      String displayedItems = repairStaff.sublist(0, displayCount).join(', ');
      int remainingCount = repairStaff.length - displayCount;
      return '$displayedItems +$remainingCount more';
    }
  }

  void repairStaffs(String label) {
    if (repairStaffChoose.contains(label)) {
      repairStaffChoose.remove(label);
    } else {
      repairStaffChoose.add(label);
    }
  }
}
