import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/EditFillForm/editfillform_view.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editfillform2_view.dart';
import 'package:toyotamobile/Screen/FillForm2/fillform2_view.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_view.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/Sparepart/sparepart_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showbatteryreport_widget.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showreport_widget.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/intruction_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/moredetail.widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/signature_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/uploadimage_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

// ignore: use_key_in_widget_constructors
class JobDetailView extends StatelessWidget {
  final String ticketId;
  final String? jobId;
  final String? status;
  final JobDetailController jobController = Get.put(JobDetailController());
  final SparePartController subjob = Get.put(SparePartController());

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
                            Text(context.tr('loading'),
                                style: TextStyleList.title1),
                            Text(context.tr('loading'),
                                style: TextStyleList.text16),
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
                            Text('JobID: ${job.id}',
                                style: TextStyleList.text16),
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
              return const Center(child: CircleLoading());
            } else {
              var file = jobController.attatchments.isNotEmpty
                  ? jobController.attatchments
                  : null;
              var filePdf = jobController.pdfList.isNotEmpty
                  ? jobController.pdfList
                  : null;
              var issue = jobController.issueData.first;
              var subJob = jobController.subJobs.isNotEmpty
                  ? jobController.subJobs.first
                  : null;
              var subJobSparePart = jobController.subJobSparePart.isNotEmpty
                  ? jobController.subJobSparePart.first
                  : null;
              if (subJobSparePart != null) {
                if (subJobSparePart.estimateStatus == '1' ||
                    subJobSparePart.estimateStatus == '2') {
                  jobController.canEdit.value = false;
                } else {
                  jobController.canEdit.value = true;
                }
              }
              // var customerInfo = jobController.customerInfo.isNotEmpty
              //     ? jobController.customerInfo.first
              //     : null;
              // var userData = jobController.userData.isNotEmpty
              //     ? jobController.userData.first.users!.first
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
                                if (subJob != null)
                                  Intruction(
                                      context: context,
                                      phoneNumber: subJob.phoneNumber ?? '',
                                      location: subJob.address ?? ''),
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
                                        companyName: subJob != null
                                            ? subJob.companyName ?? ''
                                            : '',
                                        dateTime:
                                            formatDateTime(issue.createdAt, ''),
                                        status: issue.status.name,
                                        reporter: issue.reporter.realName ?? '',
                                        more: jobController
                                            .moreTicketDetail.value,
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

                                            subJob == null
                                                ? Center(
                                                    child: WarrantyBox(
                                                        model: '-',
                                                        serial: '-',
                                                        status: 0,
                                                        filePdf: filePdf))
                                                : WarrantyBox(
                                                    model: subJob.model ?? '',
                                                    serial:
                                                        subJob.serialNo ?? '',
                                                    status:
                                                        subJob.warrantyStatus ==
                                                                '1'
                                                            ? 1
                                                            : 0,
                                                    filePdf: filePdf),

                                            // 8.kH,
                                            // AddNote(
                                            //     notePic: jobController.notePic,
                                            //     notesFiles:
                                            //         jobController.notesFiles,
                                            //     notes: jobController.notes,
                                            //     addAttatchments: jobController
                                            //         .addAttatchments,
                                            //     isPicking:
                                            //         jobController.isPicking,
                                            //     addNote: jobController.addNote),
                                            8.kH,
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Container(),
                                            8.kH,
                                          ],
                                        ),
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
                                          reporter: subJob.realName ?? '',
                                          summary: subJob.summaryBug ?? '',
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
                                    Text(
                                      context.tr('before_image'),
                                      style: TextStyleList.text11,
                                    ),
                                    8.kH,
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
                                    14.kH,
                                    UploadImageWidget(
                                        pickImage: () => pickImage(
                                            context,
                                            jobController.imagesBefore,
                                            jobController.isPicking,
                                            'before',
                                            ticketId,
                                            jobId ?? '')),
                                    14.kH,
                                    Obx(() =>
                                        jobController.imagesBefore.isNotEmpty
                                            ? Obx(
                                                () => jobController
                                                            .savedDateStartTime
                                                            .value ==
                                                        ''
                                                    ? ButtonTime(
                                                        saveTime: (datetime) {
                                                          showTimeDialog(
                                                              context,
                                                              context.tr(
                                                                  'confirm_message'),
                                                              context.tr('no'),
                                                              context.tr('yes'),
                                                              datetime,
                                                              jobId ?? '',
                                                              'timestart',
                                                              ticketId);
                                                        },
                                                        time: jobController
                                                            .savedDateStartTime,
                                                        title: context
                                                            .tr('start_time'),
                                                      )
                                                    : Column(
                                                        children: [
                                                          6.kH,
                                                          Row(
                                                            children: [
                                                              const Icon(Icons
                                                                  .access_time),
                                                              4.wH,
                                                              Text(
                                                                "${context.tr('start_time')} : ${jobController.savedDateStartTime.value}",
                                                                style:
                                                                    TextStyleList
                                                                        .text6,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                              )
                                            : Container()),
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
                                              Text(
                                                context.tr('after_image'),
                                                style: TextStyleList.text11,
                                              ),
                                              10.kH,
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
                                              14.kH,
                                              UploadImageWidget(
                                                pickImage: () => pickImage(
                                                    context,
                                                    jobController.imagesAfter,
                                                    jobController.isPicking,
                                                    'after',
                                                    ticketId,
                                                    jobId ?? ''),
                                              ),
                                              10.kH,
                                            ],
                                          )
                                        : Container()),
                                    6.kH,
                                    Obx(() => jobController
                                                .comment.value.text ==
                                            ''
                                        ? Column(
                                            children: [
                                              TextFieldType(
                                                hintText:
                                                    context.tr('add_comment'),
                                                textSet: jobController
                                                    .comment2.value,
                                              ),
                                              6.kH,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CustomElevatedButton(
                                                    onPressed: () async {
                                                      if (jobController.comment2
                                                              .value.text !=
                                                          '') {
                                                        await updateCommentJobs(
                                                            jobId.toString(),
                                                            jobController
                                                                .comment2
                                                                .value
                                                                .text,
                                                            ticketId.toString(),
                                                            jobController
                                                                .comment);
                                                      }
                                                    },
                                                    text: context.tr('submit'),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        : ShowTextFieldType(
                                            hintText: jobController
                                                .comment.value.text)),
                                    Obx(() => jobController
                                                .imagesAfter.isNotEmpty &&
                                            jobController.comment.value.text !=
                                                ''
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              12.kH,
                                              Obx(() => jobController
                                                          .savedDateEndTime
                                                          .value ==
                                                      ''
                                                  ? ButtonTime(
                                                      saveTime: (datetime) {
                                                        showTimeDialog(
                                                            context,
                                                            context.tr(
                                                                'confirm_message'),
                                                            context.tr('no'),
                                                            context.tr('yes'),
                                                            datetime,
                                                            jobId ?? '',
                                                            'timeend',
                                                            ticketId);
                                                      },
                                                      time: jobController
                                                          .savedDateEndTime,
                                                      title: context
                                                          .tr('end_time'),
                                                    )
                                                  : Column(
                                                      children: [
                                                        6.kH,
                                                        Row(
                                                          children: [
                                                            const Icon(Icons
                                                                .access_time),
                                                            4.wH,
                                                            Text(
                                                              "${context.tr('end_time')} : ${jobController.savedDateEndTime.value}",
                                                              style:
                                                                  TextStyleList
                                                                      .text6,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                              12.kH,
                                            ],
                                          )
                                        : Container()),
                                  ],
                                ),
                                Obx(
                                    () =>
                                        jobController.savedDateEndTime.value !=
                                                ''
                                            ? Column(
                                                children: [
                                                  8.kH,
                                                  BoxContainer(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TitleApp(
                                                            text: context.tr(
                                                                'field_service_report'),
                                                          ),
                                                          Obx(() => jobController
                                                                      .reportList
                                                                      .isNotEmpty &&
                                                                  jobController
                                                                      .canEdit
                                                                      .value
                                                              ? EditButton(
                                                                  onTap: () {
                                                                    Get.to(() =>
                                                                        EditFillFormView(
                                                                          reportId:
                                                                              jobId ?? '',
                                                                          ticketId:
                                                                              ticketId,
                                                                          jobId:
                                                                              jobId.toString(),
                                                                        ));
                                                                  },
                                                                )
                                                              : jobController
                                                                      .canEdit
                                                                      .value
                                                                  ? AddButton(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            FillFormView(
                                                                              ticketId: ticketId,
                                                                              jobId: jobId ?? '',
                                                                            ));
                                                                      },
                                                                    )
                                                                  : Container())
                                                        ],
                                                      ),
                                                      Text(
                                                        '${context.tr('fill_request')} ${context.tr('field_service_report')}',
                                                        style: TextStyleList
                                                            .text16,
                                                      ),
                                                      Obx(() => jobController
                                                                  .reportList
                                                                  .isNotEmpty ||
                                                              jobController
                                                                  .additionalReportList
                                                                  .isNotEmpty
                                                          ? Column(
                                                              children: [
                                                                ShowRepairReport(
                                                                  reportData:
                                                                      jobController
                                                                          .reportList,
                                                                  additionalReportData:
                                                                      jobController
                                                                          .additionalReportList,
                                                                  jobId: jobId
                                                                      .toString(),
                                                                  timeStart:
                                                                      jobController
                                                                          .savedDateStartTime,
                                                                  timeEnd:
                                                                      jobController
                                                                          .savedDateEndTime,
                                                                ),
                                                                Obx(() {
                                                                  if (jobController
                                                                          .reportList
                                                                          .isNotEmpty &&
                                                                      (jobController.reportList.first.signature ==
                                                                              '' &&
                                                                          (jobController.reportList.first.signaturePadUrl == '' ||
                                                                              jobController.reportList.first.signaturePadUrl == null))) {
                                                                    return Column(
                                                                      children: [
                                                                        5.kH,
                                                                        ButtonRed(
                                                                          title:
                                                                              context.tr('save_signature'),
                                                                          onTap:
                                                                              () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) => SignatureWidget(
                                                                                jobId: jobId.toString(),
                                                                                ticketId: ticketId.toString(),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    );
                                                                  } else {
                                                                    return const SizedBox
                                                                        .shrink();
                                                                  }
                                                                }),
                                                                Obx(() => (jobController.subJobSparePart.isNotEmpty &&
                                                                        subJob !=
                                                                            null &&
                                                                        jobController
                                                                            .reportList
                                                                            .isNotEmpty &&
                                                                        jobController.reportList.first.signature !=
                                                                            '' &&
                                                                        (jobController.reportList.first.signaturePadUrl !=
                                                                                null &&
                                                                            jobController.reportList.first.signaturePadUrl !=
                                                                                ''))
                                                                    ? Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          ButtonColor(
                                                                            backgroundColor:
                                                                                red4,
                                                                            title:
                                                                                context.tr('view_part_detail'),
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) => Obx(() => Material(
                                                                                        color: Colors.transparent,
                                                                                        child: SubJobSparePartWidget(
                                                                                          subJobSparePart: jobController.subJobSparePart.first,
                                                                                        ),
                                                                                      )));
                                                                            },
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Container()),
                                                              ],
                                                            )
                                                          : Container()),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Container()),
                                Obx(
                                    () =>
                                        jobController.savedDateEndTime.value !=
                                                ''
                                            ? Column(
                                                children: [
                                                  8.kH,
                                                  BoxContainer(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TitleApp(
                                                              text: context.tr(
                                                                  'battery_maintenance_report')),
                                                          Obx(() => jobController
                                                                      .reportBatteryList
                                                                      .isNotEmpty &&
                                                                  jobController
                                                                      .canEdit
                                                                      .value
                                                              ? EditButton(
                                                                  onTap: () {
                                                                    Get.to(() =>
                                                                        EditFillFormView2(
                                                                          jobId:
                                                                              ticketId,
                                                                          jobIssueId:
                                                                              jobId.toString(),
                                                                        ));
                                                                  },
                                                                )
                                                              : jobController
                                                                      .canEdit
                                                                      .value
                                                                  ? AddButton(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            FillFormView2(
                                                                              jobId: ticketId,
                                                                              jobIssueId: jobId.toString(),
                                                                            ));
                                                                      },
                                                                    )
                                                                  : Container()),
                                                        ],
                                                      ),
                                                      Text(
                                                        '${context.tr('fill_request')} ${context.tr('battery_maintenance_report')}',
                                                        style: TextStyleList
                                                            .text16,
                                                      ),
                                                      Obx(() => jobController
                                                              .reportBatteryList
                                                              .isNotEmpty
                                                          ? Column(
                                                              children: [
                                                                ShowBatteryReportWidget(
                                                                  reportData:
                                                                      jobController
                                                                          .reportBatteryList,
                                                                  bugId:
                                                                      jobId ??
                                                                          '',
                                                                  pdfOption:
                                                                      'fieldreport_btr',
                                                                  timeStart:
                                                                      jobController
                                                                          .savedDateStartTime,
                                                                  timeEnd:
                                                                      jobController
                                                                          .savedDateEndTime,
                                                                ),
                                                                if (jobController
                                                                            .reportBatteryList
                                                                            .first
                                                                            .btrMaintenance!
                                                                            .signature ==
                                                                        null &&
                                                                    jobController
                                                                            .reportBatteryList
                                                                            .first
                                                                            .btrMaintenance!
                                                                            .signaturePadUrl ==
                                                                        null)
                                                                  Column(
                                                                    children: [
                                                                      5.kH,
                                                                      ButtonRed(
                                                                        title: context
                                                                            .tr('save_signature'),
                                                                        onTap:
                                                                            () {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                SignatureWidget(
                                                                              jobId: jobId.toString(),
                                                                              ticketId: ticketId.toString(),
                                                                              option: 'battery',
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  )
                                                              ],
                                                            )
                                                          : Container()),
                                                      Obx(() => (jobController
                                                                  .subJobSparePart
                                                                  .isNotEmpty &&
                                                              jobController
                                                                  .reportBatteryList
                                                                  .isNotEmpty &&
                                                              jobController
                                                                      .reportBatteryList
                                                                      .first
                                                                      .btrMaintenance!
                                                                      .signature !=
                                                                  null &&
                                                              jobController
                                                                      .reportBatteryList
                                                                      .first
                                                                      .btrMaintenance!
                                                                      .signaturePadUrl !=
                                                                  null)
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                ButtonColor(
                                                                  backgroundColor:
                                                                      red4,
                                                                  title: context
                                                                      .tr('view_part_detail'),
                                                                  onTap: () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (BuildContext context) => Obx(() =>
                                                                            Material(
                                                                              color: Colors.transparent,
                                                                              child: SubJobSparePartWidget(
                                                                                subJobSparePart: jobController.subJobSparePart.first,
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
                                              )
                                            : Container()),
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
        bottomNavigationBar: Obx(() {
          return jobController.completeCheck.value
              ? BottomAppBar(
                  color: white3,
                  child: Container(
                    decoration: Decoration2(),
                    child: EndButton(
                        onPressed: () {
                          jobController.showCompletedDialog(
                              context,
                              context.tr('complete_message'),
                              context.tr('no'),
                              context.tr('yes'));
                        },
                        text: context.tr('complete')),
                  ),
                )
              : const SizedBox.shrink();
        }));
  }
}
