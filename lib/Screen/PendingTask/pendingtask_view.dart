import 'package:flutter/material.dart';
import 'package:toyotamobile/Screen/PendingTask/peddingtask_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

class PendingTaskView extends StatelessWidget {
  final PeddingtaskController penddingTaskController =
      Get.put(PeddingtaskController());
  final String ticketId;
  final String jobId;
  PendingTaskView({super.key, required this.ticketId, required this.jobId}) {
    penddingTaskController.fetchData(ticketId, jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white7,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
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
          var filePdf = penddingTaskController.addAttatchments.isNotEmpty
              ? penddingTaskController.addAttatchments
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
                                  ticketId: issue.id,
                                  dateTime: penddingTaskController
                                      .formatDateTime(issue.createdAt),
                                  reporter: issue.reporter.name,
                                  status: issue.status.name,
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
                                        issue.summary,
                                        style: TextStyleList.text9,
                                      ),
                                    ),
                                  ],
                                ),
                                file != null
                                    ? Column(
                                        children: [
                                          8.kH,
                                          AttachmentsListWidget(file, false),
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
                                              value: issue.category.name,
                                            ),
                                            BoxInfo(
                                              title: "Severity",
                                              value: issue.severity.name,
                                            ),
                                            const BoxInfo(
                                              title: "Relations",
                                              value: '-',
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
                            Obx(
                              () {
                                if (penddingTaskController
                                    .warrantyInfoList.isEmpty) {
                                  return const Center(
                                    child: Text('No Data'),
                                  );
                                } else {
                                  var warrantyInfo = penddingTaskController
                                      .warrantyInfoList.first;
                                  return WarrantyBox(
                                      model: warrantyInfo.model,
                                      serial: warrantyInfo.serial,
                                      status: warrantyInfo.warrantyStatus,
                                      filePdf: filePdf);
                                }
                              },
                            ),
                            8.kH,
                            BoxContainer(
                              children: [
                                const TitleApp(text: "Customer Information"),
                                8.kH,
                                BoxInfo(
                                  title: "Contact name",
                                  value: issue.reporter.name,
                                ),
                                3.kH,
                                const BoxInfo(
                                  title: "Email",
                                  value: 'email',
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
                            const BoxContainer(
                              children: [
                                JobInfo(
                                    jobId: 20,
                                    dateTime: '12 June 2024 00:25 AM',
                                    reporter: 'Alex')
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
