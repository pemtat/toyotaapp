import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/intruction_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/uploadimage_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

// ignore: use_key_in_widget_constructors
class JobDetailViewPM extends StatelessWidget {
  final String ticketId;
  final String? jobId;
  final String? status;
  final PmModel data;
  final JobDetailControllerPM jobController = Get.put(JobDetailControllerPM());

  JobDetailViewPM(
      {super.key,
      required this.ticketId,
      this.jobId,
      this.status,
      required this.data}) {
    jobController.fetchData(ticketId, data);
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.description ?? '',
                              style: TextStyleList.title1),
                          Text('JobID: 0001', style: TextStyleList.text16),
                        ],
                      );
                    }
                  }),
                  leading: const BackIcon(),
                ),
                Positioned(
                  right: 15.0,
                  top: 15,
                  bottom: 0,
                  child:
                      Center(child: StatusButton(status: data.pmStatus ?? '')),
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
                                      ticketId: 1,
                                      dateTime: data.pmPlan ?? '',
                                      reporter: data.customerNo ?? '',
                                      summary: 'ช่าง ${data.resourceName}',
                                      description:
                                          'Service Zone :  ${data.serviceZoneCode ?? ''}',
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
                                                    model: '-',
                                                    serial: "415822",
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
                                              jobController.showTimeDialog(
                                                context,
                                                'Are you sure to confirm?',
                                                'No',
                                                'Yes',
                                                datetime,
                                              );
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
                                        jobId ?? ''),
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
                                                      jobController
                                                          .showTimeDialog(
                                                        context,
                                                        'Are you sure to confirm?',
                                                        'No',
                                                        'Yes',
                                                        datetime,
                                                      );
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
                                            6.kH,
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
                                      const TitleApp(text: 'Repair Report*'),
                                      AddButton(
                                        onTap: () {
                                          Get.to(() => FillFormView(
                                                ticketId: ticketId,
                                                jobId: jobId ?? '',
                                              ));
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Please fill the field service report',
                                    style: TextStyleList.text16,
                                  )
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
              text: 'Complete Investigating'),
        ),
      ),
    );
  }
}
