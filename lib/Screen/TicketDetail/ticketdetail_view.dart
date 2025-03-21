import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/EditFillForm/editfillform_view.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editfillform2_view.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showbatteryreport_widget.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showreport_widget.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/customerinfo_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/moredetail.widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

// ignore: use_key_in_widget_constructors
class TicketDetailView extends StatelessWidget {
  final String ticketId;
  final String jobId;
  final TicketDetailController ticketController =
      Get.put(TicketDetailController());

  TicketDetailView({super.key, required this.ticketId, required this.jobId}) {
    ticketController.fetchData(ticketId, jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize - 2.5),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: white3,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr('view_detail'), style: TextStyleList.title1),
                ],
              ),
              leading: const BackIcon(),
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          if (ticketController.issueData.isEmpty) {
            return const Center(child: CircleLoading());
          } else {
            var file = ticketController.attatchments.isNotEmpty
                ? ticketController.attatchments
                : null;
            var filePdf = ticketController.pdfList.isNotEmpty
                ? ticketController.pdfList
                : null;
            var issue = ticketController.issueData.first;
            var subJob = ticketController.subJobs.isNotEmpty
                ? ticketController.subJobs.first
                : null;
            var subJobSparePart = ticketController.subJobSparePart.isNotEmpty
                ? ticketController.subJobSparePart.first
                : null;
            if (subJobSparePart != null) {
              if (subJobSparePart.estimateStatus == '1' ||
                  subJobSparePart.estimateStatus == '2') {
                ticketController.canEdit.value = false;
              }
            }
            // var customerInfo = ticketController.customerInfo.isNotEmpty
            //     ? ticketController.customerInfo.first
            //     : null;
            // var userData = ticketController.userData.isNotEmpty
            //     ? ticketController.userData.first.users!.first
            //     : null;
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
                                  ticketController.moreTicketDetail.value =
                                      !ticketController.moreTicketDetail.value;
                                },
                                child: BoxContainer(children: [
                                  TicketInfoStatus(
                                    ticketId: issue.id,
                                    companyName: subJob != null
                                        ? subJob.companyName ?? ''
                                        : '',
                                    dateTime:
                                        formatDateTime(issue.createdAt, ''),
                                    reporter: issue.reporter.realName,
                                    status: issue.status.name,
                                    more:
                                        ticketController.moreTicketDetail.value,
                                  ),
                                ]),
                              ),

                              // 8.kH,
                              // BoxContainer(
                              //   children: [
                              //     const TitleApp(text: 'Job Progress'),
                              //     8.kH,
                              //     Column(
                              //       children: List.generate(
                              //           ticketController
                              //               .jobTimeLineItems.length, (index) {
                              //         return Column(
                              //           children: [
                              //             TimeLineItem(
                              //               imagePath: ticketController
                              //                   .jobTimeLineItems[index]
                              //                   .imagePath,
                              //               jobid: ticketController
                              //                   .jobTimeLineItems[index].jobid,
                              //               description: ticketController
                              //                   .jobTimeLineItems[index]
                              //                   .description,
                              //               dateTime: ticketController
                              //                   .jobTimeLineItems[index]
                              //                   .datetime,
                              //               status: ticketController
                              //                   .jobTimeLineItems[index].status,
                              //               isLast: index ==
                              //                   ticketController
                              //                           .jobTimeLineItems
                              //                           .length -
                              //                       1,
                              //             ),
                              //           ],
                              //         );
                              //       }),
                              //     ),
                              //   ],
                              // ),

                              Obx(
                                () => ticketController.moreTicketDetail.value
                                    ? Column(
                                        children: [
                                          8.kH,
                                          MoreDetail(
                                            file: file,
                                            description: issue.description,
                                            moreDetail:
                                                ticketController.moreDetail,
                                            ediefile: false,
                                            summary: issue.summary,
                                            category: issue.category.name,
                                            relations: '-',
                                            severity: issue.severity.name,
                                            errorCode: issue.errorCode,
                                          ),
                                          MoreDetailArrow(
                                              moreDetail:
                                                  ticketController.moreDetail),
                                          8.kH,
                                          subJob == null
                                              ? Center(
                                                  child: WarrantyBox(
                                                      model: '-',
                                                      serial: '-',
                                                      status: 0,
                                                      filePdf: filePdf))
                                              : WarrantyBox(
                                                  model: subJob.model ?? '',
                                                  serial: subJob.serialNo ?? '',
                                                  status:
                                                      subJob.warrantyStatus ==
                                                              '1'
                                                          ? 1
                                                          : 0,
                                                  filePdf: filePdf),
                                          8.kH,
                                          if (subJob != null)
                                            CustomerInformation(
                                                context: context,
                                                contactName:
                                                    subJob.realName ?? '',
                                                email: subJob.email ?? '',
                                                phoneNumber:
                                                    subJob.phoneNumber ?? '',
                                                location: subJob.address ?? '',
                                                companyName:
                                                    subJob.companyName ?? '',
                                                onTap: () {}),
                                          // if (ticketController
                                          //     .notesFiles.isNotEmpty)
                                          //   8.kH,
                                          // if (ticketController
                                          //     .notesFiles.isNotEmpty)
                                          //   BoxContainer(
                                          //     children: [
                                          //       8.kH,
                                          //       Column(
                                          //         crossAxisAlignment:
                                          //             CrossAxisAlignment.start,
                                          //         children: [
                                          //           const TitleApp(
                                          //               text: 'Notes'),
                                          //           8.kH,
                                          //           ListView.builder(
                                          //             physics:
                                          //                 const NeverScrollableScrollPhysics(),
                                          //             shrinkWrap: true,
                                          //             itemCount:
                                          //                 ticketController
                                          //                     .notesFiles
                                          //                     .length,
                                          //             itemBuilder:
                                          //                 (context, index) {
                                          //               final note =
                                          //                   ticketController
                                          //                           .notesFiles[
                                          //                       index];
                                          //               return NoteItem(
                                          //                   note: note);
                                          //             },
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ],
                                          //   ),
                                        ],
                                      )
                                    : Container(),
                              ),
                              8.kH,
                              BoxContainer(
                                children: [
                                  JobInfo(
                                    jobId: 0,
                                    jobIdString: subJob!.id,
                                    dateTime:
                                        subJob.dueDate ?? 'ยังไม่มีกำหนดการ',
                                    reporter: issue.reporter.realName ?? '',
                                    summary: subJob.summary ?? '',
                                    description: subJob.description ?? '',
                                    status: stringToStatus(subJob.status ?? ''),
                                  )
                                ],
                              ),
                              8.kH,
                              BoxContainer(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.access_time),
                                      4.wH,
                                      Text(
                                        "${context.tr('start_time')} : ${formatDateTimeCut(subJob.timeStart ?? '- ')}",
                                        style: TextStyleList.text6,
                                      ),
                                    ],
                                  ),
                                  12.kH,
                                  if (ticketController.imagesBefore.isNotEmpty)
                                    AttachmentsListWidget(
                                      attachments:
                                          ticketController.imagesBefore,
                                      edit: false,
                                      jobid: jobId,
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
                                            "${context.tr('end_time')} : ${formatDateTimeCut(subJob.timeEnd ?? '-')}",
                                            style: TextStyleList.text6,
                                          ),
                                        ],
                                      ),
                                      12.kH,
                                      if (ticketController
                                          .imagesBefore.isNotEmpty)
                                        AttachmentsListWidget(
                                          attachments:
                                              ticketController.imagesAfter,
                                          edit: false,
                                          jobid: jobId,
                                          option: 'after',
                                        ),
                                      12.kH,
                                      Container(
                                        height: 0.5,
                                        color: const Color.fromARGB(
                                            255, 224, 222, 222),
                                      ),
                                      12.kH,
                                      ShowTextFieldType(
                                          hintText: subJob.comment == ''
                                              ? '-'
                                              : subJob.comment ?? '-'),
                                    ],
                                  )
                                ],
                              ),
                              10.kH,
                              BoxContainer(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleApp(
                                          text: context
                                              .tr('field_service_report')),
                                      subJob.status != '90' &&
                                              issue.status.id != 90 &&
                                              ticketController.canEdit.value &&
                                              ticketController
                                                  .reportList.isNotEmpty
                                          ? EditButton(
                                              onTap: () {
                                                Get.to(() => EditFillFormView(
                                                      readOnly: 'yes',
                                                      reportId: jobId,
                                                      ticketId: ticketId,
                                                      jobId: jobId.toString(),
                                                    ));
                                              },
                                            )
                                          : Container()
                                    ],
                                  ),
                                  Obx(() => ticketController
                                              .reportList.isNotEmpty ||
                                          ticketController
                                              .additionalReportList.isNotEmpty
                                      ? Column(
                                          children: [
                                            ShowRepairReport(
                                              reportData:
                                                  ticketController.reportList,
                                              additionalReportData:
                                                  ticketController
                                                      .additionalReportList,
                                              jobId: jobId.toString(),
                                              timeStart: ticketController
                                                  .savedDateStartTime,
                                              timeEnd: ticketController
                                                  .savedDateEndTime,
                                            ),
                                            Obx(() => (ticketController
                                                        .subJobSparePart
                                                        .isNotEmpty &&
                                                    ticketController.reportList
                                                            .first.signature !=
                                                        '' &&
                                                    ticketController
                                                            .reportList
                                                            .first
                                                            .signaturePadUrl !=
                                                        null &&
                                                    ticketController
                                                            .reportList
                                                            .first
                                                            .signaturePadUrl !=
                                                        '')
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ButtonColor(
                                                        backgroundColor: red4,
                                                        title: context.tr(
                                                            'view_part_detail'),
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  Obx(() =>
                                                                      Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            SubJobSparePartWidget(
                                                                          subJobSparePart: ticketController
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
                                        )
                                      : Container())
                                ],
                              ),
                              10.kH,
                              BoxContainer(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleApp(
                                          text: context.tr(
                                              'battery_maintenance_report')),
                                      issue.status.id != 90 &&
                                              ticketController.canEdit.value &&
                                              ticketController
                                                  .reportBatteryList.isNotEmpty
                                          ? EditButton(
                                              onTap: () {
                                                Get.to(() => EditFillFormView2(
                                                    jobId: ticketId,
                                                    jobIssueId: jobId,
                                                    readOnly: 'yes'));
                                              },
                                            )
                                          : Container()
                                    ],
                                  ),
                                  Obx(() => ticketController
                                          .reportBatteryList.isNotEmpty
                                      ? ShowBatteryReportWidget(
                                          reportData: ticketController
                                              .reportBatteryList,
                                          bugId: jobId,
                                          pdfOption: 'fieldreport_btr',
                                          timeStart: ticketController
                                              .savedDateStartTime,
                                          timeEnd:
                                              ticketController.savedDateEndTime,
                                        )
                                      : Container()),
                                  Obx(() => (ticketController
                                              .subJobSparePart.isNotEmpty &&
                                          ticketController
                                              .reportBatteryList.isNotEmpty &&
                                          ticketController
                                                  .reportBatteryList
                                                  .first
                                                  .btrMaintenance!
                                                  .signature !=
                                              null &&
                                          ticketController
                                                  .reportBatteryList
                                                  .first
                                                  .btrMaintenance!
                                                  .signaturePadUrl !=
                                              null)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ButtonColor(
                                              backgroundColor: red4,
                                              title: context
                                                  .tr('view_part_detail'),
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
                                                                    ticketController
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
