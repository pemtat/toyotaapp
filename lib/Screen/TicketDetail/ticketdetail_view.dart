import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showreport_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/customerinfo_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/moredetail.widget.dart';
import 'package:toyotamobile/Widget/noteItem_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

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
                  Text('View Detail', style: TextStyleList.title1),
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
            return const Center(child: CircularProgressIndicator());
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
            var userData = ticketController.userData.first.users!.isNotEmpty
                ? ticketController.userData.first.users!.first
                : null;
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
                                    dateTime: '2024-06-07',
                                    reporter: issue.reporter.name,
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
                                              severity: issue.severity.name),
                                          MoreDetailArrow(
                                              moreDetail:
                                                  ticketController.moreDetail),
                                          8.kH,
                                          Obx(
                                            () {
                                              if (ticketController
                                                  .warrantyInfoList.isEmpty) {
                                                return const Center(
                                                  child: Text('No Data'),
                                                );
                                              } else {
                                                var warrantyInfo =
                                                    ticketController
                                                        .warrantyInfoList.first;
                                                return WarrantyBox(
                                                    model: warrantyInfo.model,
                                                    serial: warrantyInfo.serial,
                                                    status: warrantyInfo
                                                        .warrantyStatus,
                                                    filePdf: filePdf);
                                              }
                                            },
                                          ),
                                          8.kH,
                                          CustomerInformation(
                                              contactName: issue.reporter.name,
                                              email: '-',
                                              phoneNumber: '-',
                                              location:
                                                  'Onnut, Bangkok, Thailand',
                                              onTap: () {}),
                                          8.kH,
                                          BoxContainer(
                                            children: [
                                              Obx(() {
                                                if (ticketController
                                                    .notesFiles.isEmpty) {
                                                  return Center(
                                                      child: Container());
                                                } else {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const TitleApp(
                                                          text: 'Notes'),
                                                      8.kH,
                                                      ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            ticketController
                                                                .notesFiles
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final note =
                                                              ticketController
                                                                      .notesFiles[
                                                                  index];
                                                          return NoteItem(
                                                              note: note);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                }
                                              }),
                                            ],
                                          ),
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
                                    reporter: issue.reporter.name ?? '',
                                    summary: subJob.summary ?? '',
                                    description: subJob.description ?? '',
                                    status: stringToStatus(subJob.status ?? ''),
                                  )
                                ],
                              ),
                              8.kH,
                              BoxContainer(
                                children: [
                                  Text(
                                    "Start Time : ${subJob.timeStart == null ? '- ' : subJob.timeStart}",
                                    style: TextStyleList.text6,
                                  ),
                                  8.kH,
                                  if (ticketController.imagesBefore.isNotEmpty)
                                    AttachmentsListWidget(
                                      attachments:
                                          ticketController.imagesBefore,
                                      edit: false,
                                      jobid: jobId,
                                      option: 'before',
                                    ),
                                  10.kH,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "End Time : ${subJob.timeEnd == null ? '-' : subJob.timeEnd}",
                                        style: TextStyleList.text6,
                                      ),
                                      8.kH,
                                      if (ticketController
                                          .imagesBefore.isNotEmpty)
                                        AttachmentsListWidget(
                                          attachments:
                                              ticketController.imagesAfter,
                                          edit: false,
                                          jobid: jobId,
                                          option: 'after',
                                        ),
                                      Container(
                                        height: 0.5,
                                        color: const Color.fromARGB(
                                            255, 224, 222, 222),
                                      ),
                                      10.kH,
                                      ShowTextFieldType(
                                          hintText: subJob.comment == ''
                                              ? '-'
                                              : subJob.comment ?? '-'),
                                    ],
                                  )
                                ],
                              ),
                              8.kH,
                              BoxContainer(
                                children: [
                                  const TitleApp(text: 'Repair Report*'),
                                  Obx(() => ticketController
                                              .reportList.isNotEmpty ||
                                          ticketController
                                              .additionalReportList.isNotEmpty
                                      ? ShowRepairReport(
                                          reportData:
                                              ticketController.reportList,
                                          additionalReportData: ticketController
                                              .additionalReportList)
                                      : Container())
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
