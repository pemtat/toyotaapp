import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/openmap.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/Notification/notification_controller.dart';
import 'package:toyotamobile/Screen/ReturnSparePartShow/return_sparepart_show.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/sparepart_widget.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/pdfviewer_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class SubJobSparePartReturnWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final SubJobSparePart subJobSparePart;
  final Rx<String>? expandedTicketId;
  final Rx<bool>? expandedIndex;
  final JobDetailController jobDetailController =
      Get.put(JobDetailController());
  final JobDetailControllerPM jobDetailControllerPM =
      Get.put(JobDetailControllerPM());

  final TicketDetailController ticketDetailController =
      Get.put(TicketDetailController());
  final TicketPmDetailController ticketPmDetailController =
      Get.put(TicketPmDetailController());
  final NotificationController notificationController =
      Get.put(NotificationController());

  SubJobSparePartReturnWidget(
      {super.key,
      required this.subJobSparePart,
      this.expandedTicketId,
      this.expandedIndex});

  @override
  Widget build(BuildContext context) {
    RxList<TextEditingController> remarkControllers =
        <TextEditingController>[].obs;

    void addRemark() {
      remarkControllers.add(TextEditingController());
    }

    void removeRemark(int index) {
      if (remarkControllers.isNotEmpty) {
        remarkControllers.removeAt(index);
      }
    }

    List<String> getAllRemarks() {
      return remarkControllers.map((controller) => controller.text).toList();
    }

    String summarySparePartTotal(String option) {
      int summary = 0;

      void addToSummary(List<dynamic>? items) {
        if (items != null && items.isNotEmpty) {
          for (var item in items) {
            int quantity = int.parse(item.quantity ?? '0');
            if (quantity != 0) {
              int itemSummary = double.parse(item.summary ?? '0').toInt();
              summary += itemSummary;
            }
          }
        }
      }

      addToSummary(subJobSparePart.sparepart);
      addToSummary(subJobSparePart.additionalSparepart);
      addToSummary(subJobSparePart.btrSparepart);
      addToSummary(subJobSparePart.pvtSparepart);
      addToSummary(subJobSparePart.pvtSparepartIc);

      if (option == 'discount') {
        final formatter = NumberFormat("#,###");
        return formatter.format(summary);
      } else {
        String summaryCheck = summary > 100000 ? '1' : '0';
        return summaryCheck;
      }
    }

    final rejectNote = TextEditingController().obs;

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
                  context.tr('return_spare_part_status'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subJobSparePart.projectId == '1'
                          ? Text(
                              'Job ID : ${subJobSparePart.id}',
                              style: TextStyleList.subtitle9,
                            )
                          : Text(
                              'PM ID : ${subJobSparePart.bugId}',
                              style: TextStyleList.subtitle9,
                            ),
                      Row(
                        children: [
                          Text(
                            '${context.tr('status')} :',
                            style: TextStyleList.detail2,
                          ),
                          4.wH,
                          StatusButton3(
                              status:
                                  subJobSparePart.estimateStatus.toString()),
                        ],
                      ),
                    ],
                  ),
                  6.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subJobSparePart.projectId == '1'
                          ? Text(
                              'Ticket : ${subJobSparePart.bugId}',
                              style: TextStyleList.subtitle9,
                            )
                          : Container(),
                      Row(
                        children: [
                          Text(
                            'Admin Status :',
                            style: TextStyleList.detail2,
                          ),
                          4.wH,
                          StatusButton2(
                              status: subJobSparePart.adminStatus.toString()),
                        ],
                      )
                    ],
                  ),
                  8.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subJobSparePart.projectId == '1'
                          ? Text(
                              'BB no. : ${subJobSparePart.referenceCode ?? ''}',
                              style: TextStyleList.subtitle9,
                            )
                          : Container(),
                      if (jobController.techLevel.value == '1')
                        Row(
                          children: [
                            Text(
                              'Tech Manager \nStatus :',
                              style: TextStyleList.detail2,
                            ),
                            4.wH,
                            StatusButton2(
                                status: subJobSparePart.techManagerStatus
                                    .toString()),
                          ],
                        )
                    ],
                  ),
                  6.kH,
                  if (subJobSparePart.documentNo != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'OJ no. : ${subJobSparePart.documentNo ?? ''}',
                          style: TextStyleList.subtitle9,
                        ),
                      ],
                    ),
                  8.kH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Document Ref. : ${subJobSparePart.refId ?? '1'}',
                        style: TextStyleList.subtitle9,
                      ),
                    ],
                  ),
                  8.kH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Warranty : ',
                            style: TextStyleList.text1,
                          ),
                          CheckStatus(
                              status: subJobSparePart.warrantyStatus ?? '')
                        ],
                      ),
                      if (jobController.techLevel.value == '1')
                        if (subJobSparePart.tiNoUrl != null &&
                            subJobSparePart.tiNoUrl != '')
                          InkWell(
                            onTap: () {
                              showImageDialogUrlCode(
                                  context, subJobSparePart.tiNoUrl ?? '');
                            },
                            child: Text(
                              subJobSparePart.tiNo ?? '',
                              style:
                                  TextStyleList.subtext9.copyWith(fontSize: 15),
                            ),
                          ),
                      if (jobController.techLevel.value == '2')
                        InkWell(
                          onTap: () async {
                            RxString pdfReport = ''.obs;
                            String? token = await getToken();
                            showDialog(
                                context: context,
                                barrierColor: const Color.fromARGB(59, 0, 0, 0),
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                      child: DataCircleLoading());
                                });
                            if (subJobSparePart.projectId == '1') {
                              await fetchPdfReport(subJobSparePart.id ?? '',
                                  token ?? '', pdfReport, 'estimate');
                            } else {
                              await fetchPdfReport(subJobSparePart.bugId ?? '',
                                  token ?? '', pdfReport, 'estimate_pm');
                            }
                            Navigator.pop(context);
                            if (pdfReport.value != '') {
                              Get.to(() => PdfBase64View(
                                  name: context.tr('estimate_report'),
                                  path: pdfReport.value));
                            }
                          },
                          child: Text(
                            context.tr('view_pdf'),
                            style: TextStyleList.subtext9,
                          ),
                        ),
                    ],
                  ),
                  4.kH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${context.tr('summary_issue')} : ${subJobSparePart.description ?? ''}',
                          style: TextStyleList.text1,
                        ),
                      ),
                      GoogleMapButton(
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: DataCircleLoading(),
                              );
                            },
                          );

                          try {
                            await openGoogleMaps(
                                subJobSparePart.destinationAddress ?? '');
                          } catch (e) {
                            print(e);
                          } finally {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  ),
                  4.kH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${context.tr('remark')} : ${subJobSparePart.remark == '' || subJobSparePart.remark == null ? '-' : subJobSparePart.remark}',
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
                              returnStatus: 'yes',
                              additionalSparepart:
                                  subJobSparePart.additionalSparepart ?? [],
                              sparepart: subJobSparePart.sparepart ?? [],
                              btrSparepart: subJobSparePart.btrSparepart ?? [],
                              pvtSparepart: subJobSparePart.pvtSparepart ?? [],
                              pvtSparepartIc:
                                  subJobSparePart.pvtSparepartIc ?? [],
                              jobId: subJobSparePart.id ?? '',
                              bugId: subJobSparePart.bugId ?? '',
                              projectId: subJobSparePart.projectId ?? '',
                              techLevel: jobController.techLevel.value,
                              techManagerStatus:
                                  subJobSparePart.techManagerStatus ?? '',
                              estimateStatus:
                                  subJobSparePart.estimateStatus ?? '',
                            )
                          : Container())
                      : SparePartDetail(
                          returnStatus: 'yes',
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
                        ),
                  6.kH,
                  if (subJobSparePart.techManagerStatus == '0' &&
                      jobController.techLevel.value == '2')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 120,
                            child: ButtonRed(
                                color: blue1,
                                title: context.tr('approve'),
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DialogAlert(
                                        title: context.tr('approve_message'),
                                        leftButton: context.tr('no'),
                                        rightButton: context.tr('yes'),
                                        rightColor: red1,
                                        onRightButtonPressed: () async {
                                          await updateJobSparePartReturn(
                                              subJobSparePart.id ?? '',
                                              jobController.techLevel.value,
                                              jobController.handlerIdTech.value,
                                              '',
                                              'approve',
                                              subJobSparePart.bugId ?? '',
                                              subJobSparePart.handlerId ?? '',
                                              subJobSparePart.reportjobId ?? '',
                                              subJobSparePart.projectId ?? '',
                                              subJobSparePart.adminId ?? '0',
                                              subJobSparePart.returnId ?? '0',
                                              subJobSparePart.refId ?? '0');

                                          await notificationController
                                              .fetchNotifySubJobSparePartReturnId(
                                                  subJobSparePart.id ?? '0',
                                                  subJobSparePart.bugId ?? '0',
                                                  subJobSparePart.projectId ??
                                                      '0');

                                          showMessage('ดำเนินการสำเร็จ');
                                        },
                                      );
                                    },
                                  );
                                })),
                        6.wH,
                        SizedBox(
                          width: 120,
                          child: ButtonRed(
                            title: context.tr('not_approve'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: white4,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        10.kH,
                                        TextFieldType(
                                          hintText: context.tr('remark'),
                                          textSet: rejectNote.value,
                                          maxLine: 5,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          context.tr('no'),
                                          style: TextStyleList.text1,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await updateJobSparePartReturn(
                                              subJobSparePart.id ?? '',
                                              jobController.techLevel.value,
                                              jobController.handlerIdTech.value,
                                              rejectNote.value.text,
                                              'reject',
                                              subJobSparePart.bugId ?? '',
                                              subJobSparePart.handlerId ?? '',
                                              subJobSparePart.reportjobId ?? '',
                                              subJobSparePart.projectId ?? '',
                                              subJobSparePart.adminId ?? '0',
                                              subJobSparePart.returnId ?? '0',
                                              subJobSparePart.refId ?? '0');
                                          await notificationController
                                              .fetchNotifySubJobSparePartReturnId(
                                                  subJobSparePart.id ?? '0',
                                                  subJobSparePart.bugId ?? '0',
                                                  subJobSparePart.projectId ??
                                                      '0');

                                          Navigator.pop(context);
                                          showMessage('ดำเนินการสำเร็จ');
                                        },
                                        child: Text(
                                          context.tr('yes'),
                                          style: TextStyleList.text1,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        6.wH,
                        if (expandedIndex == null)
                          SizedBox(
                              width: 70,
                              child: ButtonRed(
                                  title: context.tr('close'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  })),
                      ],
                    ),
                  6.wH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // if (expandedIndex == null)
                      //   SizedBox(
                      //       width: 70,
                      //       child: ButtonRed(
                      //           title: context.tr('close'),
                      //           onTap: () {
                      //             Navigator.pop(context);
                      //           })),

                      if ((subJobSparePart.adminStatus == '2' ||
                              subJobSparePart.techManagerStatus == '2') &&
                          jobController.techLevel.value == '1')
                        SizedBox(
                            width: 100,
                            child: ButtonCustom(
                              title: context.tr('edit_part'),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        Obx(() => Material(
                                              color: Colors.transparent,
                                              child: ReturnSparepartShow(
                                                subJobSparePart:
                                                    subJobSparePart,
                                                edit: true,
                                              ),
                                            )));
                              },
                              style: TextStyleList.text7
                                  .copyWith(color: Colors.white, fontSize: 13),
                            )),
                      if (expandedIndex == null)
                        SizedBox(
                            width: 70,
                            child: ButtonRed(
                                title: context.tr('close'),
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
