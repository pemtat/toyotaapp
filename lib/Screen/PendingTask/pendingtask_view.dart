import 'package:flutter/material.dart';
import 'package:toyotamobile/Screen/PendingTask/peddingtask_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/attachment_widget.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';
import 'package:get/get.dart';

class PendingTaskView extends StatelessWidget {
  final PeddingtaskController penddingTaskController =
      Get.put(PeddingtaskController());
  final String ticketId;

  PendingTaskView({super.key, required this.ticketId}) {
    penddingTaskController.fetchData(ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white7,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: white3,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('View Detail', style: TextStyleList.title1),
                ],
              ),
              leading: const BackIcon(),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (penddingTaskController.issueData.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var file = penddingTaskController.attachments.isNotEmpty
              ? penddingTaskController.attachments
              : null;
          var issue = penddingTaskController.issueData.first;

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
                                TicketInfoStatus(
                                  ticketId: issue['id'],
                                  dateTime: penddingTaskController
                                      .formatDateTime(issue['created_at']),
                                  reporter: issue['reporter'],
                                  status: issue['status'],
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
                                        issue['summary'],
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
                                  () => !penddingTaskController.moreDetail.value
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
                                penddingTaskController.moreDetail.value =
                                    !penddingTaskController.moreDetail.value;
                              },
                              child: Obx(
                                () => !penddingTaskController.moreDetail.value
                                    ? BoxContainer(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Less details',
                                                style: TextStyleList.text16,
                                              ),
                                              Image.asset('assets/arrowup.png')
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
                                const BoxInfo(
                                  title: "Warranty Status",
                                  value: '',
                                  trailing: CheckStatus(
                                    status: 1,
                                  ),
                                ),
                                3.kH,
                                const BoxInfo(
                                  title: "Attachment File",
                                  value: "",
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
      }),
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Container(
          decoration: Decoration2(),
          child: EndButton(
            onPressed: () {
              penddingTaskController.showAcceptDialog(
                context,
                'Do you confirm you will accept this job?',
                'No',
                'Yes',
              );
            },
            text: 'Accept Ticket',
          ),
        ),
      ),
    );
  }
}
