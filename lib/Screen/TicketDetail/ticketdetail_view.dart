import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/attachment_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/noteItem_widget.dart';
import 'package:toyotamobile/Widget/progressbar_widget.dart.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class TicketDetailView extends StatelessWidget {
  final String ticketId;
  final TicketDetailController ticketController =
      Get.put(TicketDetailController());

  TicketDetailView({super.key, required this.ticketId}) {
    ticketController.fetchData(ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(57.5),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: white3,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ticket Detail', style: TextStyleList.title1),
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
            var issue = ticketController.issueData.first;

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
                              BoxContainer(children: [
                                TicketInfoStatus(
                                  ticketId: issue['id'],
                                  dateTime: formatDateTime(issue['created_at']),
                                  reporter: issue['reporter'],
                                  status: issue['status'],
                                ),
                              ]),
                              8.kH,
                              BoxContainer(
                                children: [
                                  const TitleApp(text: 'Job Progress'),
                                  8.kH,
                                  Column(
                                    children: List.generate(
                                        ticketController
                                            .jobTimeLineItems.length, (index) {
                                      return Column(
                                        children: [
                                          TimeLineItem(
                                            imagePath: ticketController
                                                .jobTimeLineItems[index]
                                                .imagePath,
                                            jobid: ticketController
                                                .jobTimeLineItems[index].jobid,
                                            description: ticketController
                                                .jobTimeLineItems[index]
                                                .description,
                                            dateTime: ticketController
                                                .jobTimeLineItems[index]
                                                .datetime,
                                            status: ticketController
                                                .jobTimeLineItems[index].status,
                                            isLast: index ==
                                                ticketController
                                                        .jobTimeLineItems
                                                        .length -
                                                    1,
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
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
                                    () => !ticketController.moreDetail.value
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
                                  ticketController.moreDetail.value =
                                      !ticketController.moreDetail.value;
                                },
                                child: Obx(
                                  () => !ticketController.moreDetail.value
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
                                    title: "Warranty",
                                    value: '',
                                    trailing: CheckStatus(
                                      status: 1,
                                    ),
                                  ),
                                  3.kH,
                                  const BoxInfo(
                                    title: "Attachment File",
                                    value: '',
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
                              BoxContainer(
                                children: [
                                  const TitleApp(text: "Customer Information"),
                                  8.kH,
                                  BoxInfo(
                                    title: "Contact name",
                                    value: issue['reporter'],
                                  ),
                                  3.kH,
                                  BoxInfo(
                                    title: "Email",
                                    value: issue['email'],
                                  ),
                                  3.kH,
                                  const BoxInfo(
                                    title: "Phone number",
                                    value: "0828203345",
                                  ),
                                  const BoxInfo(
                                    title: "Location",
                                    value: "Onnut, Bangkok, Thailand",
                                  ),
                                  5.kH,
                                  Row(
                                    children: [
                                      const Spacer(),
                                      GoogleMapButton(
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              8.kH,
                              BoxContainer(
                                children: [
                                  Obx(() {
                                    if (ticketController.notesFiles.isEmpty) {
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
                                            itemCount: ticketController
                                                .notesFiles.length,
                                            itemBuilder: (context, index) {
                                              final note = ticketController
                                                  .notesFiles[index];
                                              return NoteItem(note: note);
                                            },
                                          ),
                                          18.kH,
                                        ],
                                      );
                                    }
                                  }),
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
