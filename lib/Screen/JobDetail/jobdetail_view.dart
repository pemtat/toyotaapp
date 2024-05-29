import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_view.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/attachment_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/statusbutton_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class JobDetailView extends StatelessWidget {
  final String ticketId;
  final JobDetailController jobController = Get.put(JobDetailController());

  JobDetailView({super.key, required this.ticketId}) {
    jobController.fetchData(ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Positioned(
                  right: 15.0,
                  top: 15,
                  bottom: 0,
                  child: Center(
                    child: StatusAssignedButton(),
                  ),
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
                              BoxContainer(
                                children: [
                                  const TitleApp(text: "Machine Detail"),
                                  8.kH,
                                  const BoxInfo(
                                    title: "Name/Model",
                                    value: "UBRE200H2-TH-7500",
                                  ),
                                  3.kH,
                                  const BoxInfo(
                                    title: "Serial Number",
                                    value: "6963131",
                                  ),
                                  3.kH,
                                  const BoxInfo(
                                    title: "Warranty Status",
                                    value: '',
                                    trailing: CheckStatus(
                                      imagePath: 'assets/pass.png',
                                      text: 'Active',
                                      textColor: green1,
                                    ),
                                  ),
                                  5.kH,
                                  Row(
                                    children: [
                                      const AttachmentFile(name: 'Q1.pdf'),
                                      7.wH,
                                      const AttachmentFile(name: 'Q2.pdf'),
                                      7.wH,
                                      const AttachmentFile(name: 'Q3.pdf'),
                                    ],
                                  ),
                                ],
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
                                  const TitleApp(text: 'Notes'),
                                  8.kH,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 12,
                                          child: Text('A',
                                              style: TextStyleList.text13),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Admin (Backoffice)',
                                                    style:
                                                        TextStyleList.text10),
                                                3.wH,
                                                Text(
                                                  '13 March 2024, 11:39 AM',
                                                  style: TextStyleList.subtext1,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Don\'t be late be late',
                                              style: TextStyleList.subtext3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  18.kH,
                                  const AppDivider(),
                                  18.kH,
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
                                          jobController.submitNote();
                                        },
                                        text: 'Submit',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              16.kH,
                              BoxContainer(paddingCustom: 10, children: [
                                EndButton(
                                    onPressed: () {
                                      jobController.showCompletedDialog(
                                          context,
                                          'Successfully finished job on investigating!',
                                          'Not yet',
                                          'Yes, Completed');
                                    },
                                    text: 'Complete Investigating'),
                              ])
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
