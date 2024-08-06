import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_controller.dart';
import 'package:toyotamobile/Screen/PendingTask/peddingtask_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/addnote_widget.dart';
import 'package:toyotamobile/Widget/customerinfo_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/moredetail.widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

class PendingTaskView extends StatelessWidget {
  final PeddingtaskController penddingTaskController =
      Get.put(PeddingtaskController());
  final JobDetailController jobController = Get.put(JobDetailController());
  final HomeController homeController = Get.put(HomeController());

  final String ticketId;
  final String jobId;
  PendingTaskView({
    super.key,
    required this.ticketId,
    required this.jobId,
  }) {
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
                  Text('Job Detail', style: TextStyleList.title1),
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
          var file = penddingTaskController.attatchments.isNotEmpty
              ? penddingTaskController.attatchments
              : null;
          var filePdf = penddingTaskController.pdfList.isNotEmpty
              ? penddingTaskController.pdfList
              : null;
          var issue = penddingTaskController.issueData.first;
          var subJob = penddingTaskController.subJobs.isNotEmpty
              ? penddingTaskController.subJobs.first
              : null;
          var customerInfo = penddingTaskController.customerInfo.isNotEmpty
              ? penddingTaskController.customerInfo.first
              : null;
          var userData = penddingTaskController.userData.isNotEmpty
              ? penddingTaskController.userData.first.users!.first
              : null;
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
                                  dateTime: formatDateTime(issue.createdAt, ''),
                                  reporter: issue.reporter.realName,
                                  status: issue.status.name,
                                ),
                              ],
                            ),
                            8.kH,
                            MoreDetail(
                              file: file,
                              description: issue.description,
                              moreDetail: penddingTaskController.moreDetail,
                              ediefile: false,
                              summary: issue.summary,
                              category: issue.category.name,
                              relations: '-',
                              severity: issue.severity.name,
                              errorCode: issue.errorCode,
                            ),
                            MoreDetailArrow(
                                moreDetail: penddingTaskController.moreDetail),
                            8.kH,
                            Obx(
                              () {
                                if (penddingTaskController
                                    .warrantyInfo.isEmpty) {
                                  return Center(
                                      child: WarrantyBox(
                                          model: '-',
                                          serial: '-',
                                          status: 0,
                                          filePdf: filePdf));
                                } else {
                                  var warrantyInfo =
                                      penddingTaskController.warrantyInfo.first;
                                  return WarrantyBox(
                                      model: warrantyInfo.model ?? '',
                                      serial: warrantyInfo.serial ?? '',
                                      status: warrantyInfo.warrantystatus == '1'
                                          ? 1
                                          : 0,
                                      filePdf: filePdf);
                                }
                              },
                            ),
                            8.kH,
                            CustomerInformation(
                                context: context,
                                contactName: issue.reporter.realName,
                                email: issue.reporter.email,
                                phoneNumber: userData!.phoneNo ?? '-',
                                location: customerInfo!.customerAddress ?? '-',
                                companyName: customerInfo.customerName ?? '',
                                onTap: () {}),
                            8.kH,
                            AddNote(
                              notePic: penddingTaskController.notePic,
                              notesFiles: penddingTaskController.notesFiles,
                              notes: penddingTaskController.notes,
                              addAttatchments:
                                  penddingTaskController.addAttatchments,
                              isPicking: penddingTaskController.isPicking,
                              addNote: penddingTaskController.addNote,
                            ),
                            8.kH,
                            BoxContainer(
                              children: [
                                JobInfo(
                                  jobId: 0,
                                  jobIdString: subJob!.id,
                                  dateTime:
                                      subJob.dueDate ?? 'ยังไม่มีกำหนดการ',
                                  reporter: issue.reporter.realName ?? '',
                                  summary: subJob.summary ?? '',
                                  description: subJob.description ?? '',
                                  status: stringToStatus(subJob.status ?? ''),
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
      }),
      bottomNavigationBar: BottomAppBar(
        color: white3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: EndButton(
                onPressed: () {
                  penddingTaskController.showAcceptDialog(
                    context,
                    'Do you confirm to accept this job?',
                    'No',
                    'Yes',
                  );
                },
                text: 'Accept',
              ),
            ),
            13.wH,
            Expanded(
              child: EndButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: white4,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            10.kH,
                            TextFieldType(
                              hintText: 'Remark',
                              textSet: penddingTaskController.cancelNote.value,
                              maxLine: 5,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'No',
                              style: TextStyleList.text1,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              updateTechSubjob(
                                  jobId,
                                  ticketId,
                                  penddingTaskController.cancelNote.value.text,
                                  2);
                              Navigator.pop(context);
                              homeController.fetchDataFromAssignJob();
                            },
                            child: Text(
                              'Yes',
                              style: TextStyleList.text1,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                text: 'Cancel',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
