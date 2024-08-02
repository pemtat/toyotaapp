import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/checkcustomer.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/EditFillForm2/editfillform2_view.dart';
import 'package:toyotamobile/Screen/EditFillForm3/editfillform3_view.dart';
import 'package:toyotamobile/Screen/FillForm2/fillform2_view.dart';
import 'package:toyotamobile/Screen/FillForm3/fillform3_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showbatteryreport_widget.dart';
import 'package:toyotamobile/Widget/JobDetail_widget/showpreventive_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/intruction_widget.dart';
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
                            Text('PM ID: $ticketId',
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
              return const Center(child: CircularProgressIndicator());
            } else {
              var filePdf = jobController.addAttatchments.isNotEmpty
                  ? jobController.addAttatchments
                  : null;
              var issue = jobController.issueData.first;
              var userData = userController.userInfo.first;

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
                                              .userData.isNotEmpty &&
                                          jobController.customer != null
                                      ? BoxContainer(
                                          children: [
                                            PMJobInfo(
                                                ticketId: issue.id,
                                                dateTime: issue.dueDate ??
                                                    getFormattedDate(
                                                        DateTime.now()),
                                                reporter:
                                                    issue.reporter.realName,
                                                summary:
                                                    '${issue.getCustomFieldValue("Customer Name")}',
                                                description:
                                                    'Service Zone :  ${userController.userInfo.first.zone} ',
                                                detail: issue.description,
                                                status: stringToStatus(
                                                    issue.status.id.toString()),
                                                location: issue
                                                    .getCustomFieldValue(
                                                        "Customer No")
                                                    .toString(),
                                                contact: jobController
                                                        .customer!.phoneNo ??
                                                    '-'
                                                        ''),
                                          ],
                                        )
                                      : Container()),
                                ),
                                8.kH,
                                Obx(() => jobController.userData.isNotEmpty &&
                                        jobController.customer != null
                                    ? Intruction(
                                        context: context,
                                        phoneNumber:
                                            jobController.customer!.phoneNo ??
                                                '-',
                                        location: issue
                                            .getCustomFieldValue("Customer No")
                                            .toString(),
                                        fetchLocation: 'yes',
                                      )
                                    : Container()),
                                8.kH,
                                Obx(
                                  () => jobController.moreTicketDetail.value
                                      ? Column(
                                          children: [
                                            8.kH,
                                            Obx(
                                              () {
                                                if (jobController
                                                    .warrantyInfoList.isEmpty) {
                                                  return Center(
                                                      child: WarrantyBox(
                                                          model: '-',
                                                          serial: '-',
                                                          status: 0,
                                                          filePdf: filePdf));
                                                } else {
                                                  var warrantyInfo =
                                                      jobController
                                                          .warrantyInfoList
                                                          .first;
                                                  return WarrantyBox(
                                                      model: warrantyInfo.model,
                                                      serial: issue
                                                          .getCustomFieldValue(
                                                              "Serial No"),
                                                      status: warrantyInfo
                                                          .warrantyStatus,
                                                      filePdf: filePdf);
                                                }
                                              },
                                            ),
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
                                    Obx(() => jobController
                                                .comment.value.text ==
                                            ''
                                        ? Column(
                                            children: [
                                              4.kH,
                                              TextFieldType(
                                                hintText: 'Add Comment',
                                                textSet:
                                                    jobController.comment.value,
                                              ),
                                              8.kH,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CustomElevatedButton(
                                                    onPressed: () async {
                                                      await changeIssueStatusPMComment(
                                                          ticketId.toString(),
                                                          102,
                                                          jobController.comment
                                                              .value.text,
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
                                8.kH,
                                BoxContainer(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TitleApp(
                                            text: 'Battery Maintenance Report'),
                                        Obx(() => jobController
                                                .reportList.isNotEmpty
                                            ? EditButton(
                                                onTap: () {
                                                  Get.to(
                                                      () => EditFillFormView2(
                                                            jobId: ticketId,
                                                          ));
                                                },
                                              )
                                            : AddButton(
                                                onTap: () {
                                                  Get.to(() => FillFormView2(
                                                        jobId: ticketId,
                                                      ));
                                                },
                                              )),
                                      ],
                                    ),
                                    Text(
                                      'Please fill the bettery maintenance report',
                                      style: TextStyleList.text16,
                                    ),
                                    Obx(() => jobController
                                            .reportList.isNotEmpty
                                        ? Column(
                                            children: [
                                              ShowBatteryReportWidget(
                                                reportData:
                                                    jobController.reportList,
                                                bugId: ticketId.toString(),
                                              ),
                                              if (jobController
                                                          .reportList
                                                          .first
                                                          .btrMaintenance!
                                                          .signature ==
                                                      null &&
                                                  jobController
                                                          .reportList
                                                          .first
                                                          .btrMaintenance!
                                                          .signaturePad ==
                                                      null)
                                                Column(
                                                  children: [
                                                    5.kH,
                                                    ButtonRed(
                                                      title: 'บันทึกลายเซ็น',
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SignatureWidget(
                                                            jobId: ticketId
                                                                .toString(),
                                                            option: 'battery',
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                )
                                            ],
                                          )
                                        : Container())
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
                                            text:
                                                'Periodic Maintenance Report'),
                                        Obx(() => jobController
                                                    .reportPreventiveList
                                                    .isNotEmpty &&
                                                jobController
                                                        .reportPreventiveList
                                                        .first
                                                        .pvtMaintenance !=
                                                    null
                                            ? EditButton(
                                                onTap: () {
                                                  Get.to(
                                                      () => EditFillFormView3(
                                                            jobId: ticketId,
                                                          ));
                                                },
                                              )
                                            : AddButton(
                                                onTap: () {
                                                  Get.to(() => FillFormView3(
                                                        jobId: ticketId,
                                                      ));
                                                },
                                              )),
                                      ],
                                    ),
                                    Text(
                                      'Please fill the periodic maintenance report',
                                      style: TextStyleList.text16,
                                    ),
                                    Obx(() => jobController.reportPreventiveList
                                                .isNotEmpty &&
                                            jobController.reportPreventiveList
                                                    .first.pvtMaintenance !=
                                                null
                                        ? Column(
                                            children: [
                                              ShowPreventiveReportWidget(
                                                reportData: jobController
                                                    .reportPreventiveList,
                                                bugId: ticketId.toString(),
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
                                                          .signaturePad ==
                                                      null)
                                                Column(
                                                  children: [
                                                    5.kH,
                                                    ButtonRed(
                                                      title: 'บันทึกลายเซ็น',
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SignatureWidget(
                                                            jobId: ticketId
                                                                .toString(),
                                                            option:
                                                                'preventive',
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                )
                                            ],
                                          )
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
