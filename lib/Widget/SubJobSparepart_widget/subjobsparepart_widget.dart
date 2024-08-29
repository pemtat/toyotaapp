import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/showdialogsave.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/sparepart_widget.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';

class SubJobSparePartWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final SubJobSparePart subJobSparePart;
  final Rx<String>? expandedTicketId;
  final Rx<bool>? expandedIndex;
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());

  SubJobSparePartWidget(
      {super.key,
      required this.subJobSparePart,
      this.expandedTicketId,
      this.expandedIndex});

  @override
  Widget build(BuildContext context) {
    final rejectNote = TextEditingController().obs;
    return Column(
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
                'Sparepart Request Status',
                style: TextStyleList.subtitle1,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ticket : ${subJobSparePart.bugId}',
                      style: TextStyleList.title1,
                    ),
                    Row(
                      children: [
                        Text(
                          'Tech Manager :',
                          style: TextStyleList.subtitle1,
                        ),
                        4.wH,
                        StatusButton2(
                            status:
                                subJobSparePart.techManagerStatus.toString()),
                      ],
                    ),
                  ],
                ),
                8.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BB no. : ${subJobSparePart.referenceCode ?? ''}',
                      style: TextStyleList.title1,
                    ),
                    Row(
                      children: [
                        Text(
                          'Sales',
                          style: TextStyleList.subtitle1,
                        ),
                        Text(
                          ' :',
                          style: TextStyleList.title1,
                        ),
                        4.wH,
                        StatusButton2(
                            status: subJobSparePart.salesStatus.toString()),
                      ],
                    )
                  ],
                ),
                6.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warranty : ',
                      style: TextStyleList.text1,
                    ),
                    CheckStatus(status: subJobSparePart.warrantyStatus ?? '')
                  ],
                ),
                4.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Manager Remark : ${subJobSparePart.techManagerRemark == '' || subJobSparePart.techManagerRemark == null ? '-' : subJobSparePart.techManagerRemark}',
                      style: TextStyleList.text1,
                    ),
                  ],
                ),
                4.kH,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Issue Remark : ${subJobSparePart.description ?? ''}',
                      style: TextStyleList.text1,
                    ),
                    if (expandedIndex != null && expandedTicketId != null)
                      Obx(() => InkWell(
                            onTap: () {
                              if (expandedTicketId!.value ==
                                  subJobSparePart.id) {
                                expandedIndex!.value = !expandedIndex!.value;
                              } else {
                                expandedTicketId!.value =
                                    subJobSparePart.id ?? '';
                                expandedIndex!.value = true;
                              }
                            },
                            child: expandedIndex!.value &&
                                    expandedTicketId!.value ==
                                        subJobSparePart.id
                                ? const ArrowUp(
                                    width: 30,
                                    height: 30,
                                  )
                                : const ArrowDown(
                                    width: 30,
                                    height: 30,
                                  ),
                          )),
                  ],
                ),
                expandedIndex != null && expandedTicketId != null
                    ? Obx(() => (expandedIndex!.value &&
                            expandedTicketId!.value == subJobSparePart.id)
                        ? SparePartDetail(
                            additionalSparepart:
                                subJobSparePart.additionalSparepart ?? [],
                            sparepart: subJobSparePart.sparepart ?? [],
                            jobId: subJobSparePart.id ?? '',
                            techLevel: jobController.techLevel.value,
                            techManagerStatus:
                                subJobSparePart.techManagerStatus ?? '',
                          )
                        : Container())
                    : SparePartDetail(
                        additionalSparepart:
                            subJobSparePart.additionalSparepart ?? [],
                        sparepart: subJobSparePart.sparepart ?? [],
                        jobId: subJobSparePart.id ?? '',
                        techLevel: jobController.techLevel.value,
                        techManagerStatus:
                            subJobSparePart.techManagerStatus ?? '',
                      ),
                6.kH,
                jobController.techLevel.value == '1'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (expandedIndex == null)
                            SizedBox(
                                width: 120,
                                child: ButtonRed(
                                    title: 'ปิด',
                                    onTap: () {
                                      Navigator.pop(context);
                                    })),
                          6.wH,
                          subJobSparePart.bugStatus != '90' &&
                                  (subJobSparePart.techManagerStatus == '0' ||
                                      subJobSparePart.techManagerStatus == '4')
                              ? SizedBox(
                                  width: 120,
                                  child: ButtonRed(
                                      title: 'ขออนุมัติ',
                                      onTap: () {
                                        showApproveSparePart(
                                            context,
                                            'Are you sure to request?',
                                            'No',
                                            'Yes', () async {
                                          await updateJobSparePart(
                                              subJobSparePart.id ?? '',
                                              1,
                                              jobController.techManageId.value,
                                              jobController.techLevel.value,
                                              jobController.handlerIdTech.value,
                                              '');
                                          await jobDetailController
                                              .fetchSubJobSparePartId();
                                        }, red1);
                                      }))
                              : Container(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          subJobSparePart.techManagerStatus == '0' ||
                                  subJobSparePart.techManagerStatus == '1' ||
                                  subJobSparePart.techManagerStatus == '3'
                              ? Container()
                              : subJobSparePart.techManagerStatus == '2'
                                  ? Row(
                                      children: [
                                        SizedBox(
                                            width: 120,
                                            child: ButtonRed(
                                                color: blue1,
                                                title: 'Approve',
                                                onTap: () {
                                                  showApproveSparePart(
                                                      context,
                                                      'Are you sure to approve?',
                                                      'No',
                                                      'Yes', () {
                                                    updateJobSparePart(
                                                        subJobSparePart.id ??
                                                            '',
                                                        3,
                                                        jobController
                                                            .techManageId.value,
                                                        jobController
                                                            .techLevel.value,
                                                        jobController
                                                            .handlerIdTech
                                                            .value,
                                                        '-');
                                                  }, blue1);
                                                })),
                                        6.wH,
                                        SizedBox(
                                          width: 120,
                                          child: ButtonRed(
                                            title: 'Not Approve',
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor: white4,
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        10.kH,
                                                        TextFieldType(
                                                          hintText: 'Remark',
                                                          textSet:
                                                              rejectNote.value,
                                                          maxLine: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: TextStyleList
                                                              .text1,
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await updateJobSparePart(
                                                              subJobSparePart.id ??
                                                                  '',
                                                              4,
                                                              jobController
                                                                  .techManageId
                                                                  .value,
                                                              jobController
                                                                  .techLevel
                                                                  .value,
                                                              jobController
                                                                  .handlerIdTech
                                                                  .value,
                                                              rejectNote
                                                                  .value.text);

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Yes',
                                                          style: TextStyleList
                                                              .text1,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container()
                        ],
                      )
              ],
            )),
      ],
    );
  }
}
