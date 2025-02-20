import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/showdialogsave.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/Notification/notification_controller.dart';
import 'package:toyotamobile/Screen/ReturnSparePartShow/return_sparepart_show_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/ReturnSparepart_widget/return_sparepart_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class ReturnSparepartShow extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final HomeController jobController = Get.put(HomeController());
  final ReturnSparepartController returnSparepartController =
      Get.put(ReturnSparepartController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  final SubJobSparePart subJobSparePart;
  final bool? edit;
  ReturnSparepartShow({super.key, required this.subJobSparePart, this.edit});

  @override
  Widget build(BuildContext context) {
    returnSparepartController.selectedSpareParts.clear();
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
                  context.tr('return_spare_part_action'),
                  style: TextStyleList.detail2,
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
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
                        subJobSparePart: subJobSparePart,
                        edit: edit,
                      ))),
                  16.kH,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 100,
                            child: ButtonRed(
                                title: 'ขออนุมัติ',
                                onTap: () {
                                  showApproveSparePart(
                                      context,
                                      context.tr('request_message'),
                                      context.tr('no'),
                                      context.tr('yes'), () async {
                                    if (returnSparepartController
                                        .selectedSpareParts.isNotEmpty) {
                                      Navigator.pop(context);
                                      edit == true
                                          ? await returnSparepartController
                                              .updateQuotation(
                                                  context,
                                                  subJobSparePart.bugId ?? '0',
                                                  subJobSparePart.id ?? '0',
                                                  subJobSparePart.handlerId ??
                                                      '0',
                                                  subJobSparePart.projectId ??
                                                      '1',
                                                  subJobSparePart.returnId ??
                                                      '0',
                                                  subJobSparePart.refId ?? '0')
                                          : await returnSparepartController
                                              .createQuotation(
                                                  context,
                                                  subJobSparePart.bugId ?? '0',
                                                  subJobSparePart.id ?? '0',
                                                  subJobSparePart.handlerId ??
                                                      '0',
                                                  subJobSparePart.projectId ??
                                                      '1');
                                      await returnSparepartController
                                          .saveSparePart(
                                              context,
                                              subJobSparePart.bugId ?? '0',
                                              subJobSparePart.id ?? '0',
                                              subJobSparePart.handlerId ?? '0',
                                              subJobSparePart.projectId ?? '1');
                                      edit == true
                                          ? createQuotationReturnHistory(
                                              subJobSparePart.id ?? '0',
                                              'tech',
                                              subJobSparePart.bugId ?? '0',
                                              subJobSparePart.handlerId ?? '0',
                                              '1',
                                              subJobSparePart.refId ?? '1')
                                          : createQuotationReturnHistory(
                                              subJobSparePart.id ?? '0',
                                              'tech',
                                              subJobSparePart.bugId ?? '0',
                                              subJobSparePart.handlerId ?? '0',
                                              '1',
                                              'none');
                                      await notificationController
                                          .fetchNotifySubJobSparePartReturnId(
                                              subJobSparePart.id ?? '0',
                                              subJobSparePart.bugId ?? '0',
                                              subJobSparePart.projectId ?? '0');
                                      subJobSparePart.projectId == '1'
                                          ? createHistoryJobs(
                                              subJobSparePart.handlerId ?? '0',
                                              '0',
                                              'Job ID : ${subJobSparePart.id.toString().padLeft(7, '0')}',
                                              'มีรายการใบคืน Spare Part รออนุมัติใหม่',
                                              'admin',
                                              subJobSparePart.bugId ?? '0',
                                              subJobSparePart.id ?? '0',
                                              'QTR',
                                              'tech',
                                              '0',
                                              'group')
                                          : createHistoryJobs(
                                              subJobSparePart.handlerId ?? '0',
                                              '0',
                                              'PM ID : ${subJobSparePart.bugId.toString().padLeft(7, '0')}',
                                              'มีรายการใบคืน Spare Part รออนุมัติใหม่',
                                              'admin',
                                              subJobSparePart.bugId ?? '0',
                                              subJobSparePart.id ?? '0',
                                              'QTR',
                                              'tech',
                                              '0',
                                              'group');
                                      showMessage('ดำเนินการสำเร็จ');
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialogCustom(
                                                message: context.tr(
                                                    'warning_require_sparepart'));
                                          });
                                    }
                                  }, red1);
                                })),
                        8.wH,
                        SizedBox(
                            width: 70,
                            child: ButtonRed(
                                title: 'ปิด',
                                onTap: () {
                                  Navigator.pop(context);
                                })),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
