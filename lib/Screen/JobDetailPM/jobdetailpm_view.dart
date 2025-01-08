import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/checkcustomer.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editfillform2_view.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editfillform3_view.dart';
import 'package:toyotamobile/Screen/EditFillForm3_IC/editfillform3_ic_view.dart';
import 'package:toyotamobile/Screen/FillForm2/fillform2_view.dart';
import 'package:toyotamobile/Screen/FillForm3/fillform3_view.dart';
import 'package:toyotamobile/Screen/FillForm3_IC/fillform3_ic_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showbatteryreport_widget.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showpreventive_widget.dart';
import 'package:toyotamobile/Widget/SubJobSparepart_widget/subjobsparepart_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/intruction_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/showtextfield_widget.dart';
import 'package:toyotamobile/Widget/signature_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/uploadimage_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

// ignore: use_key_in_widget_constructors
class JobDetailViewPM extends StatelessWidget {
  final String ticketId;
  final String? status;
  final JobDetailControllerPM jobController = Get.put(JobDetailControllerPM());
  final UserController userController = Get.put(UserController());

  JobDetailViewPM({super.key, required this.ticketId, this.status}) {
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
                    centerTitle: false,
                    backgroundColor: white3,
                    title: Obx(() {
                      if (jobController.issueData.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Loading...', style: TextStyleList.title1),
                            Text('Loading...', style: TextStyleList.text16),
                          ],
                        );
                      } else {
                        String description =
                            jobController.issueData.first.description ?? '';
                        if (description.length > 22) {
                          description = '${description.substring(0, 22)}...';
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(extractDescription(description),
                                style: TextStyleList.title1),
                            Text(
                                'PM ID: ${ticketId.toString().padLeft(7, '0')}',
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
              var filePdf = jobController.addAttatchments.isNotEmpty
                  ? jobController.addAttatchments
                  : null;
              var issue = jobController.issueData.first;
              var userData = userController.userInfo.first;
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
                                8.kH,
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
                                                contact: pmJobs.phoneNo ?? ''),
                                          ],
                                        )
                                      : Container()),
                                ),
                                8.kH,
                                Obx(() => jobController.issueData.isNotEmpty &&
                                        pmJobs != null
                                    ? Intruction(
                                        context: context,
                                        phoneNumber: pmJobs.phoneNo ?? '',
                                        location: pmJobs.address ?? '',
                                        fetchLocation: 'yes',
                                      )
                                    : Container()),
                                8.kH,
                                Obx(
                                  () => jobController.moreTicketDetail.value
                                      ? Column(
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
                                                    serial:
                                                        pmJobs.serialNo ?? '-',
                                                    status:
                                                        pmJobs.tWarranty == '1'
                                                            ? 1
                                                            : 0,
                                                    filePdf: filePdf),
                                          ],
                                        )
                                      : Container(),
                                ),
                                8.kH,
                                BoxContainer(
                                  children: [
                                    Text(
                                      'ภาพก่อนการเเก้ไข',
                                      style: TextStyleList.text11,
                                    ),
                                    8.kH,
                                    Obx(() => jobController
                                            .imagesBefore.isNotEmpty
                                        ? AttachmentsListWidget(
                                            attachments:
                                                jobController.imagesBefore,
                                            edit: true,
                                            option: 'before',
                                            pmjobid: ticketId,
                                            createdBy: userData.id.toString(),
                                          )
                                        : Container()),
                                    12.kH,
                                    UploadImageWidget(
                                      pickImage: () => pickImagePM(
                                        context,
                                        jobController.imagesBefore,
                                        jobController.isPicking,
                                        'before',
                                        ticketId,
                                        userData.id.toString(),
                                        jobController.imagesBefore,
                                        jobController.imagesAfter,
                                      ),
                                    ),
                                    12.kH,
                                    Obx(() => jobController
                                            .imagesBefore.isNotEmpty
                                        ? Obx(
                                            () => jobController
                                                        .savedDateStartTime
                                                        .value ==
                                                    ''
                                                ? Column(
                                                    children: [
                                                      2.kH,
                                                      ButtonTime(
                                                        saveTime: (datetime) {
                                                          showTimeDialogPM(
                                                              context,
                                                              'Are you sure to confirm?',
                                                              'No',
                                                              'Yes',
                                                              datetime,
                                                              ticketId,
                                                              'timestart',
                                                              userData.id
                                                                  .toString());
                                                        },
                                                        time: jobController
                                                            .savedDateStartTime,
                                                        title: 'Start Time',
                                                      ),
                                                      6.kH,
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      6.kH,
                                                      Row(
                                                        children: [
                                                          Icon(Icons
                                                              .access_time),
                                                          4.wH,
                                                          Text(
                                                            "Start Time : ${jobController.savedDateStartTime.value}",
                                                            style: TextStyleList
                                                                .text6,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                          )
                                        : Container()),
                                    Obx(() => jobController
                                                .savedDateStartTime.value !=
                                            ''
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              10.kH,
                                              Text(
                                                'ภาพหลังการเเก้ไข',
                                                style: TextStyleList.text11,
                                              ),
                                              8.kH,
                                              Obx(() => jobController
                                                      .imagesAfter.isNotEmpty
                                                  ? AttachmentsListWidget(
                                                      attachments: jobController
                                                          .imagesAfter,
                                                      edit: true,
                                                      option: 'after',
                                                      pmjobid: ticketId,
                                                      createdBy: userData.id
                                                          .toString(),
                                                    )
                                                  : Container()),
                                              12.kH,
                                              UploadImageWidget(
                                                pickImage: () => pickImagePM(
                                                    context,
                                                    jobController.imagesAfter,
                                                    jobController.isPicking,
                                                    'after',
                                                    ticketId,
                                                    userData.id.toString(),
                                                    jobController.imagesBefore,
                                                    jobController.imagesAfter),
                                              ),
                                              12.kH,
                                            ],
                                          )
                                        : Container()),
                                    2.kH,
                                    Obx(() =>
                                        jobController.comment.value.text == ''
                                            ? Column(
                                                children: [
                                                  4.kH,
                                                  TextFieldType(
                                                    hintText: 'Add Comment',
                                                    textSet: jobController
                                                        .comment2.value,
                                                  ),
                                                  8.kH,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      CustomElevatedButton(
                                                        onPressed: () async {
                                                          await changeIssueStatusPMComment(
                                                              ticketId
                                                                  .toString(),
                                                              102,
                                                              jobController
                                                                  .comment2
                                                                  .value
                                                                  .text,
                                                              jobController
                                                                  .comment);
                                                        },
                                                        text: 'Submit',
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            : Obx(() => ShowTextFieldType(
                                                hintText: jobController
                                                    .comment.value.text))),
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
                                                        showTimeDialogPM(
                                                            context,
                                                            'Are you sure to confirm?',
                                                            'No',
                                                            'Yes',
                                                            datetime,
                                                            ticketId,
                                                            'timeend',
                                                            userData.id
                                                                .toString());
                                                      },
                                                      time: jobController
                                                          .savedDateEndTime,
                                                      title: 'End Time',
                                                    )
                                                  : Column(
                                                      children: [
                                                        4.kH,
                                                        Row(
                                                          children: [
                                                            const Icon(Icons
                                                                .access_time),
                                                            4.wH,
                                                            Text(
                                                              "End Time : ${jobController.savedDateEndTime.value}",
                                                              style:
                                                                  TextStyleList
                                                                      .text6,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                            ],
                                          )
                                        : Container()),
                                  ],
                                ),
                                Obx(() =>
                                    jobController.savedDateEndTime.value != ''
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
                                                      const TitleApp(
                                                          text:
                                                              'Battery Maintenance Report'),
                                                      Obx(() => jobController
                                                                  .reportList
                                                                  .isNotEmpty &&
                                                              jobController
                                                                  .canEdit.value
                                                          ? EditButton(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    EditFillFormView2(
                                                                      jobId:
                                                                          ticketId,
                                                                    ));
                                                              },
                                                            )
                                                          : jobController
                                                                  .canEdit.value
                                                              ? AddButton(
                                                                  onTap: () {
                                                                    Get.to(() =>
                                                                        FillFormView2(
                                                                          jobId:
                                                                              ticketId,
                                                                        ));
                                                                  },
                                                                )
                                                              : Container()),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Please fill the bettery maintenance report',
                                                    style: TextStyleList.text16,
                                                  ),
                                                  Obx(
                                                      () =>
                                                          jobController
                                                                  .reportList
                                                                  .isNotEmpty
                                                              ? Column(
                                                                  children: [
                                                                    ShowBatteryReportWidget(
                                                                      reportData:
                                                                          jobController
                                                                              .reportList,
                                                                      bugId: ticketId
                                                                          .toString(),
                                                                      pdfOption:
                                                                          'btr',
                                                                      timeStart:
                                                                          jobController
                                                                              .savedDateStartTime,
                                                                      timeEnd:
                                                                          jobController
                                                                              .savedDateEndTime,
                                                                    ),
                                                                    if (jobController.reportList.first.btrMaintenance!.signature ==
                                                                            null &&
                                                                        jobController.reportList.first.btrMaintenance!.signaturePadUrl ==
                                                                            null)
                                                                      Column(
                                                                        children: [
                                                                          5.kH,
                                                                          ButtonRed(
                                                                            title:
                                                                                'บันทึกลายเซ็น',
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) => SignatureWidget(
                                                                                  jobId: ticketId.toString(),
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
                                                              .reportList
                                                              .isNotEmpty &&
                                                          jobController
                                                              .subJobSparePart
                                                              .isNotEmpty &&
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
                                                                      .signaturePadUrl !=
                                                                  null))
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            ButtonColor(
                                                              backgroundColor:
                                                                  red4,
                                                              title:
                                                                  'View Part Detail',
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        Obx(() =>
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
                                Obx(() =>
                                    jobController.savedDateEndTime.value != ''
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
                                                      const TitleApp(
                                                          text:
                                                              'Periodic Maintenance Report'),
                                                      Obx(() => jobController
                                                                  .reportPreventiveList
                                                                  .isNotEmpty &&
                                                              jobController
                                                                      .reportPreventiveList
                                                                      .first
                                                                      .pvtMaintenance !=
                                                                  null &&
                                                              jobController
                                                                  .canEdit.value
                                                          ? EditButton(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    EditFillFormView3(
                                                                      jobId:
                                                                          ticketId,
                                                                    ));
                                                              },
                                                            )
                                                          : jobController
                                                                  .canEdit.value
                                                              ? AddButton(
                                                                  onTap: () {
                                                                    Get.to(() =>
                                                                        FillFormView3(
                                                                          jobId:
                                                                              ticketId,
                                                                        ));
                                                                  },
                                                                )
                                                              : Container()),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Please fill the periodic maintenance report',
                                                    style: TextStyleList.text16,
                                                  ),
                                                  Obx(() => jobController
                                                              .reportPreventiveList
                                                              .isNotEmpty &&
                                                          jobController
                                                                  .reportPreventiveList
                                                                  .first
                                                                  .pvtMaintenance !=
                                                              null
                                                      ? Column(
                                                          children: [
                                                            ShowPreventiveReportWidget(
                                                              reportData:
                                                                  jobController
                                                                      .reportPreventiveList,
                                                              bugId: ticketId
                                                                  .toString(),
                                                              timeStart:
                                                                  jobController
                                                                      .savedDateStartTime,
                                                              timeEnd: jobController
                                                                  .savedDateEndTime,
                                                            ),
                                                            if (jobController
                                                                        .reportPreventiveList
                                                                        .first
                                                                        .pvtMaintenance!
                                                                        .signature ==
                                                                    null &&
                                                                jobController
                                                                        .reportPreventiveList
                                                                        .first
                                                                        .pvtMaintenance!
                                                                        .signaturePadUrl ==
                                                                    null)
                                                              Column(
                                                                children: [
                                                                  5.kH,
                                                                  ButtonRed(
                                                                    title:
                                                                        'บันทึกลายเซ็น',
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                SignatureWidget(
                                                                          jobId:
                                                                              ticketId.toString(),
                                                                          option:
                                                                              'preventive',
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            Obx(() => ((jobController
                                                                            .reportPreventiveList.isNotEmpty &&
                                                                        jobController.reportPreventiveList.first.pvtMaintenance !=
                                                                            null) &&
                                                                    jobController
                                                                        .subJobSparePart
                                                                        .isNotEmpty &&
                                                                    (jobController.reportPreventiveList.first.pvtMaintenance!.signature !=
                                                                            null &&
                                                                        jobController.reportPreventiveList.first.pvtMaintenance!.signaturePadUrl !=
                                                                            null))
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      ButtonColor(
                                                                        backgroundColor:
                                                                            red4,
                                                                        title:
                                                                            'View Part Detail',
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
                                                      : Container())
                                                ],
                                              ),
                                            ],
                                          )
                                        : Container()),
                                Obx(() =>
                                    jobController.savedDateEndTime.value != ''
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
                                                      const TitleApp(
                                                          text:
                                                              'Periodic Maintenance Report IC'),
                                                      Obx(() => jobController
                                                                  .reportPreventiveListIc
                                                                  .isNotEmpty &&
                                                              jobController
                                                                      .reportPreventiveListIc
                                                                      .first
                                                                      .pvtMaintenance !=
                                                                  null &&
                                                              jobController
                                                                  .canEdit.value
                                                          ? EditButton(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    EditFillFormView3IC(
                                                                      jobId:
                                                                          ticketId,
                                                                    ));
                                                              },
                                                            )
                                                          : jobController
                                                                  .canEdit.value
                                                              ? AddButton(
                                                                  onTap: () {
                                                                    Get.to(() =>
                                                                        FillFormView3IC(
                                                                          jobId:
                                                                              ticketId,
                                                                        ));
                                                                  },
                                                                )
                                                              : Container()),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Please fill the periodic maintenance report ic',
                                                    style: TextStyleList.text16,
                                                  ),
                                                  Obx(() => jobController
                                                              .reportPreventiveListIc
                                                              .isNotEmpty &&
                                                          jobController
                                                                  .reportPreventiveListIc
                                                                  .first
                                                                  .pvtMaintenance !=
                                                              null
                                                      ? Column(
                                                          children: [
                                                            ShowPreventiveReportWidget(
                                                              ic: 'yes',
                                                              reportData:
                                                                  jobController
                                                                      .reportPreventiveListIc,
                                                              bugId: ticketId
                                                                  .toString(),
                                                              timeStart:
                                                                  jobController
                                                                      .savedDateStartTime,
                                                              timeEnd: jobController
                                                                  .savedDateEndTime,
                                                            ),
                                                            if (jobController
                                                                        .reportPreventiveListIc
                                                                        .first
                                                                        .pvtMaintenance!
                                                                        .signature ==
                                                                    null &&
                                                                jobController
                                                                        .reportPreventiveListIc
                                                                        .first
                                                                        .pvtMaintenance!
                                                                        .signaturePadUrl ==
                                                                    null)
                                                              Column(
                                                                children: [
                                                                  5.kH,
                                                                  ButtonRed(
                                                                    title:
                                                                        'บันทึกลายเซ็น',
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                SignatureWidget(
                                                                          jobId:
                                                                              ticketId.toString(),
                                                                          option:
                                                                              'preventive_ic',
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            Obx(() => ((jobController
                                                                            .reportPreventiveListIc.isNotEmpty &&
                                                                        jobController.reportPreventiveListIc.first.pvtMaintenance !=
                                                                            null) &&
                                                                    jobController
                                                                        .subJobSparePart
                                                                        .isNotEmpty &&
                                                                    (jobController.reportPreventiveListIc.first.pvtMaintenance!.signature !=
                                                                            null &&
                                                                        jobController.reportPreventiveListIc.first.pvtMaintenance!.signaturePadUrl !=
                                                                            null))
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      ButtonColor(
                                                                        backgroundColor:
                                                                            red4,
                                                                        title:
                                                                            'View Part Detail',
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
                                                      : Container())
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
                          jobController.showCompletedDialog(context,
                              'Are you sure to complete?', 'No', 'Yes');
                        },
                        text: 'Complete'),
                  ),
                )
              : SizedBox.shrink();
        }));
  }
}
