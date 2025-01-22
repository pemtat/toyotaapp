import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/ReturnSparePart/return_sparepart_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/ReturnSparepart_widget/return_sparepart_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class ReturnSparepartView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final HomeController jobController = Get.put(HomeController());
  final ReturnSparepartController returnSparepartController =
      Get.put(ReturnSparepartController());

  final SubJobSparePart subJobSparePart;

  ReturnSparepartView({
    super.key,
    required this.subJobSparePart,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
              color: white1,
            ),
            child: Row(
              children: [
                Text(
                  'Return Spare Part',
                  style: TextStyleList.detail2,
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: Decoration3(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => (ReturnSparePartDetail(
                        additionalSparepart:
                            subJobSparePart.additionalSparepart ?? [],
                        sparepart: subJobSparePart.sparepart ?? [],
                        btrSparepart: subJobSparePart.btrSparepart ?? [],
                        pvtSparepart: subJobSparePart.pvtSparepart ?? [],
                        pvtSparepartIc: subJobSparePart.pvtSparepartIc ?? [],
                        jobId: subJobSparePart.id ?? '',
                        bugId: subJobSparePart.bugId ?? '',
                        projectId: subJobSparePart.projectId ?? '',
                        techLevel: jobController.techLevel.value,
                        techManagerStatus:
                            subJobSparePart.techManagerStatus ?? '',
                        estimateStatus: subJobSparePart.estimateStatus ?? '',
                      ))),
                  16.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 100,
                          child: ButtonRed(title: 'ขออนุมัติ', onTap: () {})),
                      8.wH,
                      SizedBox(
                          width: 70,
                          child: ButtonRed(
                              title: 'ปิด',
                              onTap: () {
                                Navigator.pop(context);
                              })),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
