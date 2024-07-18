import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_view2.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/peddingtaskpm_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/addnote_widget.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

// ignore: use_key_in_widget_constructors
class PendingTaskViewPM extends StatelessWidget {
  final String ticketId;
  final String? status;
  final PendingTaskControllerPM jobController =
      Get.put(PendingTaskControllerPM());
  final HomeController homeController = Get.put(HomeController());

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
                  centerTitle: false,
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
                                    .indexOf('.CD'),
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
            var filePdf =
                jobController.pdfList.isNotEmpty ? jobController.pdfList : null;
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
                                                  status: stringToStatus(issue
                                                      .status.id
                                                      .toString()),
                                                  location: issue
                                                      .getCustomFieldValue(
                                                          "Customer No")
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
                                        return Center(
                                            child: WarrantyBox(
                                                model: '-',
                                                serial: '-',
                                                status: 0,
                                                filePdf: filePdf));
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
                              // ignore: prefer_const_constructors
                              BoxContainer(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      jobController.moreHistory.value =
                                          !jobController.moreHistory.value;
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TitleApp(text: "History"),
                                        Obx(() =>
                                            jobController.moreHistory.value ==
                                                    false
                                                ? const ArrowRight()
                                                : const ArrowDown()),
                                      ],
                                    ),
                                  ),
                                  if (jobController.moreHistory.value)
                                    Obx(() {
                                      final serialNo = issue
                                          .getCustomFieldValue('Serial No');
                                      final filteredJobs =
                                          homeController.pmItems.where((job) {
                                        return (job.status == '102' ||
                                                job.status == '103') &&
                                            job.serialNo == serialNo;
                                      }).toList();
                                      if (filteredJobs.isEmpty) {
                                        return Center(
                                            child: Text(
                                          'No jobs history',
                                          style: TextStyleList.text1,
                                        ));
                                      }
                                      filteredJobs.sort((a, b) => b.dueDate!
                                          .compareTo(a.dueDate ??
                                              getFormattedDate(
                                                  DateTime.now())));

                                      final jobsToDisplay =
                                          filteredJobs.take(5).toList();

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: jobsToDisplay.length,
                                          itemBuilder: (context, index) {
                                            final job = filteredJobs[index];
                                            return InkWell(
                                              onTap: () {
                                                {
                                                  if (stringToStatus(
                                                          job.status ?? '') ==
                                                      'pending') {
                                                    Get.to(() =>
                                                        PendingTaskViewPM(
                                                            ticketId:
                                                                job.id ?? ''));
                                                  } else if (stringToStatus(
                                                          job.status ?? '') ==
                                                      'confirmed') {
                                                    Get.to(() =>
                                                        JobDetailViewPM(
                                                            ticketId:
                                                                job.id ?? ''));
                                                  } else {
                                                    Get.to(() =>
                                                        TicketPMDetailView(
                                                            ticketId:
                                                                job.id ?? ''));
                                                  }
                                                }
                                              },
                                              child: PmItemWidget(
                                                job: job,
                                                expandedIndex:
                                                    jobController.expandedIndex,
                                                jobController: homeController,
                                                sidebar: SidebarColor.getColor(
                                                    stringToStatus(
                                                        job.status ?? '')),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }),
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
                                  addNote: jobController.addNote),
                              8.kH,
                              BoxContainer(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => Get.to(() =>
                                              CalendarView2(other: 'yes')),
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'My Tasks',
                                                  style: TextStyleList.text16,
                                                ),
                                                const Icon(
                                                  Icons.calendar_today,
                                                  size: 22,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      10.wH,
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => selectDate(context,
                                              jobController.selectedDateTime),
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: "Reschedule",
                                              labelStyle:
                                                  TextStyleList.headtitle2,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Obx(() {
                                                  return Text(
                                                    jobController
                                                                .selectedDateTime
                                                                .value !=
                                                            null
                                                        ? DateFormat.yMMMd()
                                                            .add_jms()
                                                            .format(jobController
                                                                .selectedDateTime
                                                                .value!)
                                                        : 'Select Date',
                                                    style: TextStyleList.text5,
                                                  );
                                                }),
                                                Obx(() => jobController
                                                            .selectedDateTime
                                                            .value ==
                                                        null
                                                    ? const Icon(
                                                        Icons.calendar_today,
                                                        size: 22,
                                                      )
                                                    : Container()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  15.kH,
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          jobController.confirm.value =
                                              !jobController.confirm.value;
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: jobController.confirm.value
                                                ? red1
                                                : Colors.transparent,
                                            border: !jobController.confirm.value
                                                ? Border.all(color: Colors.grey)
                                                : Border.all(
                                                    color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: jobController.confirm.value
                                              ? const Icon(Icons.check,
                                                  color: Colors.white, size: 20)
                                              : null,
                                        ),
                                      ),
                                      8.wH,
                                      Text(
                                        'Confirm schedule',
                                        style: TextStyleList.text9,
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
