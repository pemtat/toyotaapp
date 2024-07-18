import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/EditFillForm/editfillform_view.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_view.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showreport_widget.dart';
import 'package:toyotamobile/Widget/addnote_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/intruction_widget.dart';
import 'package:toyotamobile/Widget/moredetail.widget.dart';
import 'package:toyotamobile/Widget/signature_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/uploadimage_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

// ignore: use_key_in_widget_constructors
class JobDetailView extends StatelessWidget {
  final String ticketId;
  final String? jobId;
  final String? status;
  final JobDetailController jobController = Get.put(JobDetailController());

  JobDetailView({super.key, required this.ticketId, this.jobId, this.status}) {
    jobController.fetchData(ticketId, jobId ?? '');
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
                  centerTitle: false,
                  backgroundColor: white3,
                  title: Obx(() {
                    if (jobController.subJobs.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Loading...', style: TextStyleList.title1),
                          Text('Loading...', style: TextStyleList.text16),
                        ],
                      );
                    } else {
                      var job = jobController.subJobs.first;
                      String description = job.description ?? '';
                      if (description.length > 30) {
                        description = '${description.substring(0, 30)}...';
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(description, style: TextStyleList.title1),
                          Text('JobID: ${job.id}', style: TextStyleList.text16),
                        ],
                      );
                    }
                  }),
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
            return const Center(child: CircularProgressIndicator());
          } else {
            var file = jobController.attatchments.isNotEmpty
                ? jobController.attatchments
                : null;
            var filePdf =
                jobController.pdfList.isNotEmpty ? jobController.pdfList : null;
            var issue = jobController.issueData.first;
            var subJob = jobController.subJobs.isNotEmpty
                ? jobController.subJobs.first
                : null;
            var customerInfo = jobController.customerInfo.isNotEmpty
                ? jobController.customerInfo.first
                : null;
            var userData = jobController.userData.isNotEmpty
                ? jobController.userData.first.users!.first
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
                              Intruction(
                                  context: context,
                                  phoneNumber: userData!.phoneNo ?? '',
                                  location:
                                      customerInfo!.customerAddress ?? ''),
                              8.kH,
                              InkWell(
                                onTap: () {
                                  jobController.moreTicketDetail.value =
                                      !jobController.moreTicketDetail.value;
                                },
                                child: BoxContainer(
                                  children: [
                                    TicketInfoStatus(
                                      ticketId: issue.id,
                                      dateTime: formatDateTime(issue.createdAt),
                                      status: issue.status.name,
                                      reporter: issue.reporter.name,
                                      more:
                                          jobController.moreTicketDetail.value,
                                    ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => jobController.moreTicketDetail.value
                                    ? Column(
                                        children: [
                                          8.kH,
                                          MoreDetail(
                                            file: file,
                                            description: issue.description,
                                            moreDetail:
                                                jobController.moreDetail,
                                            ediefile: false,
                                            summary: issue.summary,
                                            category: issue.category.name,
                                            relations: '-',
                                            severity: issue.severity.name,
                                            errorCode: issue.errorCode,
                                          ),
                                          MoreDetailArrow(
                                              moreDetail:
                                                  jobController.moreDetail),
                                          8.kH,
                                          Obx(
                                            () {
                                              if (jobController
                                                  .warrantyInfo.isEmpty) {
                                                return Center(
                                                    child: WarrantyBox(
                                                        model: '-',
                                                        serial: '-',
                                                        status: 0,
                                                        filePdf: filePdf));
                                              } else {
                                                var warrantyInfo = jobController
                                                    .warrantyInfo.first;
                                                return WarrantyBox(
                                                    model: warrantyInfo.model ??
                                                        '',
                                                    serial:
                                                        warrantyInfo.serial ??
                                                            '',
                                                    status: warrantyInfo
                                                                .warrantystatus ==
                                                            '1'
                                                        ? 1
                                                        : 0,
                                                    filePdf: filePdf);
                                              }
                                            },
                                          ),
                                          8.kH,
                                          AddNote(
                                              notePic: jobController.notePic,
                                              notesFiles:
                                                  jobController.notesFiles,
                                              notes: jobController.notes,
                                              addAttatchments:
                                                  jobController.addAttatchments,
                                              isPicking:
                                                  jobController.isPicking,
                                              addNote: jobController.addNote)
                                        ],
                                      )
                                    : Container(),
                              ),
                              Obx(() {
                                if (jobController.subJobs.isNotEmpty) {
                                  return BoxContainer(
                                    children: [
                                      JobInfo(
                                        jobId: 0,
                                        jobIdString: subJob!.id,
                                        dateTime: subJob.dueDate ??
                                            'ยังไม่มีกำหนดการ',
                                        reporter: issue.reporter.name ?? '',
                                        summary: subJob.summary ?? '',
                                        description: subJob.description ?? '',
                                        status: stringToStatus(
                                            subJob.status.toString()),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                              8.kH,
                              BoxContainer(
                                children: [
                                  Obx(
                                    () => jobController
                                                .savedDateStartTime.value ==
                                            ''
                                        ? ButtonTime(
                                            saveTime: (datetime) {
                                              showTimeDialog(
                                                  context,
                                                  'Are you sure to confirm?',
                                                  'No',
                                                  'Yes',
                                                  datetime,
                                                  jobId ?? '',
                                                  'timestart',
                                                  ticketId);
                                            },
                                            time: jobController
                                                .savedDateStartTime,
                                            title: 'Start Time',
                                          )
                                        : Text(
                                            "Start Time : ${jobController.savedDateStartTime.value}",
                                            style: TextStyleList.text6,
                                          ),
                                  ),
                                  10.kH,
                                  Text(
                                    'ภาพก่อนการเเก้ไข',
                                    style: TextStyleList.text11,
                                  ),
                                  6.kH,
                                  Obx(() =>
                                      jobController.imagesBefore.isNotEmpty
                                          ? AttachmentsListWidget(
                                              attachments:
                                                  jobController.imagesBefore,
                                              edit: true,
                                              jobid: jobId ?? '',
                                              option: 'before',
                                            )
                                          : Container()),
                                  10.kH,
                                  UploadImageWidget(
                                      pickImage: () => pickImage(
                                          jobController.imagesBefore,
                                          jobController.isPicking,
                                          'before',
                                          ticketId,
                                          jobId ?? '')),
                                  18.kH,
                                  Container(
                                    height: 0.5,
                                    color: const Color.fromARGB(
                                        255, 224, 222, 222),
                                  ),
                                  14.kH,
                                  Obx(() => jobController
                                              .savedDateStartTime.value !=
                                          ''
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Obx(() => jobController
                                                        .savedDateEndTime
                                                        .value ==
                                                    ''
                                                ? ButtonTime(
                                                    saveTime: (datetime) {
                                                      showTimeDialog(
                                                          context,
                                                          'Are you sure to confirm?',
                                                          'No',
                                                          'Yes',
                                                          datetime,
                                                          jobId ?? '',
                                                          'timeend',
                                                          ticketId);
                                                    },
                                                    time: jobController
                                                        .savedDateEndTime,
                                                    title: 'End Time',
                                                  )
                                                : Text(
                                                    "End Time : ${jobController.savedDateEndTime.value}",
                                                    style: TextStyleList.text6,
                                                  )),
                                            10.kH,
                                            Text(
                                              'ภาพหลังการเเก้ไข',
                                              style: TextStyleList.text11,
                                            ),
                                            6.kH,
                                            Obx(() => jobController
                                                    .imagesAfter.isNotEmpty
                                                ? AttachmentsListWidget(
                                                    attachments: jobController
                                                        .imagesAfter,
                                                    edit: true,
                                                    jobid: jobId ?? '',
                                                    option: 'after',
                                                  )
                                                : Container()),
                                            10.kH,
                                            UploadImageWidget(
                                              pickImage: () => pickImage(
                                                  jobController.imagesAfter,
                                                  jobController.isPicking,
                                                  'after',
                                                  ticketId,
                                                  jobId ?? ''),
                                            ),
                                            16.kH,
                                          ],
                                        )
                                      : Container()),
                                  TextFieldType(
                                    hintText: 'Add Comment',
                                    textSet: jobController.comment.value,
                                  ),
                                ],
                              ),
                              BoxContainer(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TitleApp(text: 'Repair Report*'),
                                      Obx(() => jobController
                                              .reportList.isNotEmpty
                                          ? EditButton(
                                              onTap: () {
                                                Get.to(() => EditFillFormView(
                                                      reportId: jobId ?? '',
                                                      ticketId: ticketId,
                                                      jobId: jobId.toString(),
                                                    ));
                                              },
                                            )
                                          : AddButton(
                                              onTap: () {
                                                Get.to(() => FillFormView(
                                                      ticketId: ticketId,
                                                      jobId: jobId ?? '',
                                                    ));
                                              },
                                            )),
                                    ],
                                  ),
                                  Text(
                                    'Please fill the field service report',
                                    style: TextStyleList.text16,
                                  ),
                                  Obx(() => jobController
                                              .reportList.isNotEmpty ||
                                          jobController
                                              .additionalReportList.isNotEmpty
                                      ? Column(
                                          children: [
                                            ShowRepairReport(
                                              reportData:
                                                  jobController.reportList,
                                              additionalReportData:
                                                  jobController
                                                      .additionalReportList,
                                            ),
                                            if (jobController.reportList.first
                                                        .signature ==
                                                    '' &&
                                                jobController.reportList.first
                                                        .signaturePad ==
                                                    '')
                                              ButtonRed(
                                                title: 'บันทึกลายเซ็น',
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        SignatureWidget(
                                                      jobId: jobId.toString(),
                                                      ticketId:
                                                          ticketId.toString(),
                                                    ),
                                                  );
                                                },
                                              )
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
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration2(),
          child: EndButton(
              onPressed: () {
                jobController.showCompletedDialog(
                    context, 'Are you sure to complete?', 'No', 'Yes');
              },
              text: 'Complete'),
        ),
      ),
    );
  }
}
