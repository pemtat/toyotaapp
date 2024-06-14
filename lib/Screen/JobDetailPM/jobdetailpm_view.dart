import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/addnote_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/intruction_widget.dart';
import 'package:toyotamobile/Widget/moredetail.widget.dart';
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
  final JobDetailControllerPM jobController = Get.put(JobDetailControllerPM());

  JobDetailViewPM(
      {super.key, required this.ticketId, this.jobId, this.status}) {
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
                      var job = jobController.issueData.first;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${job.summary}', style: TextStyleList.title1),
                          Text('JobID: ${job.id}', style: TextStyleList.text16),
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
                  child: Center(child: StatusButton(status: status ?? '')),
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
                                    TicketInfo(
                                      ticketId: issue.id,
                                      dateTime: formatDateTime(issue.createdAt),
                                      reporter: issue.reporter.name,
                                      more:
                                          jobController.moreTicketDetail.value,
                                    ),
                                  ],
                                ),
                              ),
                              8.kH,
                              Obx(
                                () => jobController.moreTicketDetail.value
                                    ? Column(
                                        children: [
                                          MoreDetail(
                                              file: file,
                                              description: issue.description,
                                              moreDetail:
                                                  jobController.moreDetail,
                                              ediefile: false,
                                              summary: issue.summary,
                                              category: issue.category.name,
                                              relations: '-',
                                              severity: issue.severity.name),
                                          MoreDetailArrow(
                                              moreDetail:
                                                  jobController.moreDetail),
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
                                                    serial: warrantyInfo.serial,
                                                    status: warrantyInfo
                                                        .warrantyStatus,
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
                                              addNote: jobController.addNote),
                                        ],
                                      )
                                    : Container(),
                              ),
                              const BoxContainer(
                                children: [
                                  JobInfo(
                                      jobId: 20,
                                      dateTime: '12 June 2024 00:25 AM',
                                      reporter: 'Alex')
                                ],
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
                                              jobController.imagesBefore, true)
                                          : Container()),
                                  10.kH,
                                  UploadImageWidget(
                                    pickImage: () => pickImage(
                                        jobController.imagesBefore,
                                        jobController.isPicking),
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
                                                    jobController.imagesAfter,
                                                    true)
                                                : Container()),
                                            10.kH,
                                            UploadImageWidget(
                                              pickImage: () => pickImage(
                                                  jobController.imagesAfter,
                                                  jobController.isPicking),
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
                                          Get.to(() => const FillFormView());
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
