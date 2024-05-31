import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_view.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/attachment_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/base64pdf.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/noteItem_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

// ignore: use_key_in_widget_constructors
class JobDetailView extends StatelessWidget {
  final String ticketId;
  final String? status;
  final JobDetailController jobController = Get.put(JobDetailController());

  JobDetailView({super.key, required this.ticketId, this.status}) {
    jobController.fetchData(ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white7,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(57.5),
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
                          Text('${job['summary']}',
                              style: TextStyleList.title1),
                          Text('JobID: ${job['id']}',
                              style: TextStyleList.text16),
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
                              BoxContainer(
                                children: [
                                  const TitleApp(text: 'Intruction'),
                                  Row(
                                    children: [
                                      Text(
                                        'Step 1: Contact reporter',
                                        style: TextStyleList.text4,
                                      ),
                                      3.wH,
                                      Text('(Phone number: 0823424234)',
                                          style: TextStyleList.subtext3),
                                    ],
                                  ),
                                  3.kH,
                                  Wrap(
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                        text: 'Step 2 ',
                                        style: TextStyleList.text4,
                                        children: [
                                          TextSpan(
                                              text: 'Go to the machine',
                                              style: TextStyleList.text4),
                                          TextSpan(
                                              text:
                                                  ' (Location: Onnut, Bangkok)   ',
                                              style: TextStyleList.subtext3),
                                          WidgetSpan(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GoogleMapButton(
                                                  onTap: () {},
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  3.kH,
                                  Text(
                                    'Step 3: Report to admin about machine',
                                    style: TextStyleList.text4,
                                  ),
                                  3.kH,
                                  Text(
                                    'Step 4: Complete investigation',
                                    style: TextStyleList.text4,
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
                              8.kH,
                              BoxContainer(
                                children: [
                                  Text(
                                    'Summary of issue',
                                    style: TextStyleList.text16,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          issue['description'],
                                          style: TextStyleList.text9,
                                        ),
                                      ),
                                    ],
                                  ),
                                  file != null
                                      ? Column(
                                          children: [
                                            8.kH,
                                            AttachmentsListWidget(file),
                                            8.kH,
                                          ],
                                        )
                                      : Container(),
                                  Obx(
                                    () => !jobController.moreDetail.value
                                        ? Container()
                                        : Column(
                                            children: [
                                              BoxInfo(
                                                title: "Category",
                                                value: issue['category'],
                                              ),
                                              BoxInfo(
                                                title: "Severity",
                                                value: issue['severity'],
                                              ),
                                              BoxInfo(
                                                title: "Relations",
                                                value: issue['relations'],
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  jobController.moreDetail.value =
                                      !jobController.moreDetail.value;
                                },
                                child: Obx(
                                  () => !jobController.moreDetail.value
                                      ? BoxContainer(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'More details',
                                                  style: TextStyleList.text16,
                                                ),
                                                Image.asset(
                                                    'assets/arrowdown.png')
                                              ],
                                            ),
                                          ],
                                        )
                                      : BoxContainer(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Less details',
                                                  style: TextStyleList.text16,
                                                ),
                                                Image.asset(
                                                    'assets/arrowup.png')
                                              ],
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              8.kH,
                              Obx(
                                () {
                                  if (jobController.warrantyInfoList.isEmpty) {
                                    return Center(
                                      child: Text('No Data'),
                                    );
                                  } else {
                                    var warrantyInfo =
                                        jobController.warrantyInfoList.first;
                                    return WarrantyBox(
                                        model: warrantyInfo.model,
                                        serial: warrantyInfo.serial,
                                        status: warrantyInfo.warrantyStatus,
                                        filePdf: filePdf);
                                  }
                                },
                              ),
                              8.kH,
                              BoxContainer(children: [
                                TicketInfo(
                                  ticketId: issue['id'],
                                  dateTime: formatDateTime(issue['created_at']),
                                  reporter: issue['reporter'],
                                ),
                              ]),
                              8.kH,
                              BoxContainer(
                                children: [
                                  Obx(() {
                                    if (jobController.notesFiles.isEmpty) {
                                      return Center(child: Container());
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TitleApp(text: 'Notes'),
                                          8.kH,
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                jobController.notesFiles.length,
                                            itemBuilder: (context, index) {
                                              final note = jobController
                                                  .notesFiles[index];
                                              return NoteItem(note: note);
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                                  12.kH,
                                  TextFieldType(
                                    hintText: 'Add Notes',
                                    textSet: jobController.notes.value,
                                  ),
                                  8.kH,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: jobController.pickFile,
                                        child: Row(
                                          children: [
                                            Image.asset('assets/link.png'),
                                            4.wH,
                                            Text(
                                              'Attach file',
                                              style: TextStyleList.text1,
                                            ),
                                            Obx(() {
                                              if (jobController
                                                  .addAttatchments.isNotEmpty) {
                                                return Row(
                                                  children: [
                                                    4.wH,
                                                    Text(
                                                      jobController
                                                          .addAttatchments
                                                          .first['name'],
                                                      style:
                                                          TextStyleList.text1,
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                          ],
                                        ),
                                      ),
                                      CustomElevatedButton(
                                        onPressed: () {
                                          jobController
                                              .addNote(jobController.notes);
                                        },
                                        text: 'Submit',
                                      ),
                                    ],
                                  ),
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
