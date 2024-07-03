import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
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
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/intruction_widget.dart';
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
                          Text(description, style: TextStyleList.title1),
                          Text('JobID: $ticketId', style: TextStyleList.text16),
                        ],
                      );
                    }
                  }),
                  leading: const BackIcon(),
                ),
                Obx(() => jobController.issueData.isNotEmpty
                    ? Positioned(
                        right: 15.0,
                        top: 15,
                        bottom: 0,
                        child: Center(
                            child: StatusButton(
                                status: stringToStatus(jobController
                                    .issueData.first.status.id
                                    .toString()))),
                      )
                    : Container()),
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
                              const Intruction(
                                  phoneNumber: '0823424234',
                                  location: 'Bangkok'),
                              8.kH,
                              InkWell(
                                onTap: () {
                                  jobController.moreTicketDetail.value =
                                      !jobController.moreTicketDetail.value;
                                },
                                child: BoxContainer(
                                  children: [
                                    PMJobInfo(
                                      ticketId: issue.id,
                                      dateTime: issue.dueDate ??
                                          getFormattedDate(DateTime.now()),
                                      reporter: issue.reporter.name,
                                      summary:
                                          'ช่าง ${issue.getCustomFieldValue("Customer Name")}',
                                      description:
                                          'Service Zone :  ${issue.getCustomFieldValue("Service Zone Code")}',
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
                                          Obx(
                                            () {
                                              if (jobController
                                                  .warrantyInfoList.isEmpty) {
                                                return const Center(
                                                  child: Text('No Data'),
                                                );
                                              } else {
                                                var warrantyInfo = jobController
                                                    .warrantyInfoList.first;
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
                                  Obx(
                                    () => jobController
                                                .savedDateStartTime.value ==
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
                                                  'timestart',
                                                  userData.id.toString());
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
                                              option: 'before',
                                              pmjobid: ticketId,
                                              createdBy: userData.id.toString(),
                                            )
                                          : Container()),
                                  10.kH,
                                  UploadImageWidget(
                                    pickImage: () => pickImagePM(
                                        jobController.imagesBefore,
                                        jobController.isPicking,
                                        'before',
                                        ticketId,
                                        userData.id.toString()),
                                  ),
                                  18.kH,
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
                                                    option: 'after',
                                                    pmjobid: ticketId,
                                                    createdBy:
                                                        userData.id.toString(),
                                                  )
                                                : Container()),
                                            10.kH,
                                            UploadImageWidget(
                                              pickImage: () => pickImagePM(
                                                  jobController.imagesAfter,
                                                  jobController.isPicking,
                                                  'after',
                                                  ticketId,
                                                  userData.id.toString()),
                                            ),
                                            6.kH,
                                          ],
                                        )
                                      : Container()),
                                  6.kH,
                                  TextFieldType(
                                    hintText: 'Add Comment',
                                    textSet: jobController.comment.value,
                                  ),
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
                                      Obx(() =>
                                          jobController.reportList.isNotEmpty
                                              ? EditButton(
                                                  onTap: () {
                                                    Get.to(() => FillFormView2(
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
                                  Obx(() => jobController.reportList.isNotEmpty
                                      ? ShowBatteryReportWidget(
                                          reportData: jobController.reportList,
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
                                          text: 'Periodic Maintenance Report'),
                                      Obx(() => jobController
                                              .reportPreventiveList
                                              .first
                                              .maintenanceRecords!
                                              .isNotEmpty
                                          ? EditButton(
                                              onTap: () {
                                                Get.to(() => FillFormView3(
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
                                          .first.maintenanceRecords!.isNotEmpty
                                      ? ShowPreventiveReportWidget(
                                          reportData: jobController
                                              .reportPreventiveList,
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
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration2(),
          child: EndButton(
              onPressed: () {
                jobController.showCompletedDialog(
                    context,
                    'Successfully finished job on investigating!',
                    'Not yet',
                    'Yes, Completed');
              },
              text: 'Complete'),
        ),
      ),
    );
  }
}
