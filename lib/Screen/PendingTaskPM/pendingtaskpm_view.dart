import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/peddingtaskpm_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/addnote_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

// ignore: use_key_in_widget_constructors
class PendingTaskViewPM extends StatelessWidget {
  final String ticketId;
  final String? status;
  final PendingTaskControllerPM jobController =
      Get.put(PendingTaskControllerPM());

  PendingTaskViewPM({super.key, required this.ticketId, this.status}) {
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
                          Text(
                              jobController.issueData.first.description
                                  .substring(
                                0,
                                jobController.issueData.first.description
                                    .indexOf('บริษัท'),
                              ),
                              style: TextStyleList.title1),
                          Text('JobID: $ticketId', style: TextStyleList.text16),
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
                              InkWell(
                                onTap: () {
                                  jobController.moreTicketDetail.value =
                                      !jobController.moreTicketDetail.value;
                                },
                                child:
                                    Obx(() => jobController.userData.isNotEmpty
                                        ? BoxContainer(
                                            children: [
                                              PMJobInfo(
                                                  ticketId: issue.id,
                                                  dateTime: issue.dueDate ??
                                                      getFormattedDate(
                                                          DateTime.now()),
                                                  reporter: issue.reporter.name,
                                                  summary:
                                                      '${issue.getCustomFieldValue("Customer Name")}',
                                                  description:
                                                      'Service Zone :  ${issue.getCustomFieldValue("Service Zone Code")}',
                                                  detail: issue.description,
                                                  status: issue.status.name,
                                                  location: issue.reporter.id
                                                      .toString(),
                                                  contact: jobController
                                                          .userData
                                                          .first
                                                          .users!
                                                          .first
                                                          .phoneNo ??
                                                      ''),
                                            ],
                                          )
                                        : Container()),
                              ),
                              Column(
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
                                            serial: issue.getCustomFieldValue(
                                                "Serial No"),
                                            status: warrantyInfo.warrantyStatus,
                                            filePdf: filePdf);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              8.kH,
                              AddNote(
                                  notePic: jobController.notePic,
                                  notesFiles: jobController.notesFiles,
                                  notes: jobController.notes,
                                  addAttatchments:
                                      jobController.addAttatchments,
                                  isPicking: jobController.isPicking,
                                  addNote: jobController.addNote)
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
              jobController.showAcceptDialog(
                context,
                'Are you sure to confirm?',
                'No',
                'Yes',
              );
            },
            text: 'Update',
          ),
        ),
      ),
    );
  }
}
