import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editfillform2_view.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editfillform3_view.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showbatteryreport_widget.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showpreventive_widget.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

// ignore: use_key_in_widget_constructors
class TicketPMDetailView extends StatelessWidget {
  final String ticketId;
  final String? status;
  final TicketPmDetailController jobController =
      Get.put(TicketPmDetailController());

  final UserController userController = Get.put(UserController());

  TicketPMDetailView({super.key, required this.ticketId, this.status}) {
    jobController.fetchData(ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white7,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight((preferredSize - 2.5)),
        child: Column(
          children: [
            Stack(
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: white3,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('View Detail', style: TextStyleList.title1),
                    ],
                  ),
                  leading: const BackIcon(),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          if (jobController.issueData.isEmpty) {
            return const Center(child: CircleLoading());
          } else {
            var filePdf = jobController.addAttatchments.isNotEmpty
                ? jobController.addAttatchments
                : null;
            var issue = jobController.issueData.first;
            var pmData = jobController.pmInfo.first;
            var pmJobs = jobController.pmJobs.isNotEmpty
                ? jobController.pmJobs.first
                : null;
            var subJobSparePart = jobController.subJobSparePart.isNotEmpty
                ? jobController.subJobSparePart.first
                : null;
            if (subJobSparePart != null) {
              if (subJobSparePart.estimateStatus == '1' ||
                  subJobSparePart.estimateStatus == '2') {
                jobController.canEdit.value = false;
              }
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: white4,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  jobController.moreTicketDetail.value =
                                      !jobController.moreTicketDetail.value;
                                },
                                child: Obx(() => jobController
                                            .issueData.isNotEmpty &&
                                        pmJobs != null
                                    ? BoxContainer(
                                        children: [
                                          PMJobInfo(
                                              ticketId: issue.id,
                                              dateTime: issue.dueDate ??
                                                  getFormattedDate(
                                                      DateTime.now()),
                                              reporter: '',
                                              summary:
                                                  pmJobs.customerName ?? '',
                                              description:
                                                  'Service Zone :  ${pmJobs.serviceZoneCode ?? ''} ',
                                              detail: issue.description,
                                              status: stringToStatus(
                                                  issue.status.id.toString()),
                                              location: pmJobs.address ?? '',
                                              contact: pmJobs.phoneNo ?? '')
                                        ],
                                      )
                                    : Container()),
                              ),
                              Column(
                                children: [
                                  8.kH,
                                  pmJobs == null
                                      ? Center(
                                          child: WarrantyBox(
                                              model: '-',
                                              serial: '-',
                                              status: 0,
                                              filePdf: filePdf))
                                      : WarrantyBox(
                                          model: pmJobs.tModel ?? '-',
                                          serial: pmJobs.serialNo ?? '-',
                                          status:
                                              pmJobs.tWarranty == '1' ? 1 : 0,
                                          filePdf: filePdf),
                                ],
                              ),
                              10.kH,
                              BoxContainer(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.access_time),
                                      4.wH,
                                      Text(
                                        "Start Time : ${formatDateTimeCut(pmData.tStart ?? '- ')}",
                                        style: TextStyleList.text6,
                                      ),
                                    ],
                                  ),
                                  10.kH,
                                  if (jobController.imagesBefore.isNotEmpty)
                                    AttachmentsListWidget(
                                      attachments: jobController.imagesBefore,
                                      edit: false,
                                      jobid: ticketId,
                                      option: 'before',
                                    ),
                                  12.kH,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.access_time),
                                          4.wH,
                                          Text(
                                            "End Time : ${formatDateTimeCut(pmData.tEnd ?? '- ')}",
                                            style: TextStyleList.text6,
                                          ),
                                        ],
                                      ),
                                      10.kH,
                                      if (jobController.imagesBefore.isNotEmpty)
                                        AttachmentsListWidget(
                                          attachments:
                                              jobController.imagesAfter,
                                          edit: false,
                                          jobid: ticketId,
                                          option: 'after',
                                        ),
                                      14.kH,
                                      Container(
                                        height: 0.5,
                                        color: const Color.fromARGB(
                                            255, 224, 222, 222),
                                      ),
                                      14.kH,
                                      ShowTextFieldType(
                                          hintText: pmData.comment == ''
                                              ? '-'
                                              : pmData.comment ?? '-'),
                                    ],
                                  )
                                ],
                              ),
                              8.kH,
                              BoxContainer(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TitleApp(
                                          text: 'Battery Maintenance Report'),
                                      stringToStatus(issue.status.id
                                                      .toString()) !=
                                                  'closed' &&
                                              jobController
                                                  .reportList.isNotEmpty &&
                                              jobController.canEdit.value
                                          ? EditButton(
                                              onTap: () {
                                                Get.to(() => EditFillFormView2(
                                                    jobId: ticketId,
                                                    readOnly: 'yes'));
                                              },
                                            )
                                          : Container()
                                    ],
                                  ),
                                  Obx(() => jobController.reportList.isNotEmpty
                                      ? ShowBatteryReportWidget(
                                          reportData: jobController.reportList,
                                          bugId: ticketId.toString(),
                                          pdfOption: 'btr',
                                          timeStart:
                                              jobController.savedDateStartTime,
                                          timeEnd:
                                              jobController.savedDateEndTime,
                                        )
                                      : Container()),
                                  Obx(() =>
                                      (jobController.reportList.isNotEmpty &&
                                              jobController
                                                  .subJobSparePart.isNotEmpty &&
                                              (jobController
                                                          .reportList
                                                          .first
                                                          .btrMaintenance!
                                                          .signature !=
                                                      null &&
                                                  jobController
                                                          .reportList
                                                          .first
                                                          .btrMaintenance!
                                                          .signaturePad !=
                                                      null))
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ButtonColor(
                                                  backgroundColor: red4,
                                                  title: 'View Part Detail',
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            Obx(() => Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      SubJobSparePartWidget(
                                                                    subJobSparePart:
                                                                        jobController
                                                                            .subJobSparePart
                                                                            .first,
                                                                  ),
                                                                )));
                                                  },
                                                ),
                                              ],
                                            )
                                          : Container()),
                                ],
                              ),
                              8.kH,
                              BoxContainer(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TitleApp(
                                          text: 'Periodic Maintenance Report'),
                                      stringToStatus(issue.status.id
                                                      .toString()) !=
                                                  'closed' &&
                                              jobController.reportPreventiveList
                                                  .isNotEmpty &&
                                              jobController.reportPreventiveList
                                                      .first.pvtMaintenance !=
                                                  null &&
                                              jobController.canEdit.value
                                          ? EditButton(
                                              onTap: () {
                                                Get.to(() => EditFillFormView3(
                                                    jobId: ticketId,
                                                    readOnly: 'yes'));
                                              },
                                            )
                                          : Container()
                                    ],
                                  ),
                                  Obx(() => jobController.reportPreventiveList
                                              .isNotEmpty &&
                                          jobController.reportPreventiveList
                                                  .first.pvtMaintenance !=
                                              null
                                      ? ShowPreventiveReportWidget(
                                          reportData: jobController
                                              .reportPreventiveList,
                                          bugId: ticketId.toString(),
                                          timeStart:
                                              jobController.savedDateStartTime,
                                          timeEnd:
                                              jobController.savedDateEndTime,
                                        )
                                      : Container()),
                                  Obx(() => ((jobController.reportPreventiveList
                                                  .isNotEmpty &&
                                              jobController.reportPreventiveList
                                                      .first.pvtMaintenance !=
                                                  null) &&
                                          jobController
                                              .subJobSparePart.isNotEmpty &&
                                          (jobController
                                                      .reportPreventiveList
                                                      .first
                                                      .pvtMaintenance!
                                                      .signature !=
                                                  null &&
                                              jobController
                                                      .reportPreventiveList
                                                      .first
                                                      .pvtMaintenance!
                                                      .signaturePad !=
                                                  null))
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ButtonColor(
                                              backgroundColor: red4,
                                              title: 'View Part Detail',
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Obx(() => Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child:
                                                                  SubJobSparePartWidget(
                                                                subJobSparePart:
                                                                    jobController
                                                                        .subJobSparePart
                                                                        .first,
                                                              ),
                                                            )));
                                              },
                                            ),
                                          ],
                                        )
                                      : Container()),
                                ],
                              ),
                              8.kH,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
