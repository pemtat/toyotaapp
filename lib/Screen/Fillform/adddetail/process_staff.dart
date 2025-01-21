import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class ProcessStaff extends GetxController {
  void repairStaffModal(BuildContext context) {
    repairStaffChoose.clear();
    repairStaffChoose.addAll(repairStaff);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr('process_staff'),
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
                  option: 'true',
                  text: repairStaffList[index],
                  listItem: repairStaffChoose,
                  itemSet: repairStaffChoose),
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
            text: 'Save')
      ],
    ).showModal(context);
  }

  var repairStaff = <String>[].obs;
  var repairStaffChoose = <String>[].obs;
  List<String> repairStaffList = [
    'Quotation',
    'Claim',
    'Close Job',
    'Repair',
    'Follow',
  ];
}
