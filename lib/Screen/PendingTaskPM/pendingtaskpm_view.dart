import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/checkcustomer.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/peddingtaskpm_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfieldtype_widget.dart';
import 'package:toyotamobile/Widget/ticketinfo_widget.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

// ignore: use_key_in_widget_constructors
class PendingTaskViewPM extends StatelessWidget {
  final String ticketId;
  final String? status;
  final String? showOnly;
  final PendingTaskControllerPM jobController =
      Get.put(PendingTaskControllerPM());
  final HomeController homeController = Get.put(HomeController());

  PendingTaskViewPM(
      {super.key, required this.ticketId, this.status, this.showOnly}) {
    jobController.fetchData(ticketId);
  }
  final UserController userController = Get.put(UserController());

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
                          Text(extractDescription(description),
                              style: TextStyleList.title1),
                          Text('PM ID: ${ticketId.toString().padLeft(7, '0')}',
                              style: TextStyleList.text16),
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
            return const Center(child: CircleLoading());
          } else {
            var filePdf =
                jobController.pdfList.isNotEmpty ? jobController.pdfList : null;
            var issue = jobController.issueData.first;
            var pmJobs = jobController.pmJobs.isNotEmpty
                ? jobController.pmJobs.first
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
                              InkWell(
                                onTap: () {
                                  jobController.moreTicketDetail.value =
                                      !jobController.moreTicketDetail.value;
                                },
                                child: Obx(() => jobController
                                            .issueData.isNotEmpty &&
                                        pmJobs != null
                                    ? BoxContainer(
                                        children: [
                                          PMJobInfo(
                                              ticketId: issue.id,
                                              dateTime: issue.dueDate ??
                                                  getFormattedDate(
                                                      DateTime.now()),
                                              reporter: '',
                                              summary:
                                                  pmJobs.customerName ?? '',
                                              description:
                                                  'Service Zone :  ${pmJobs.serviceZoneCode} ',
                                              detail: issue.description,
                                              status: stringToStatus(
                                                  issue.status.id.toString()),
                                              location: pmJobs.address ?? '',
                                              contact: pmJobs.phoneNo ?? ''),
                                        ],
                                      )
                                    : Container()),
                              ),
                              Column(
                                children: [
                                  8.kH,
                                  pmJobs == null
                                      ? Center(
                                          child: WarrantyBox(
                                              model: '-',
                                              serial: '-',
                                              status: 0,
                                              filePdf: filePdf))
                                      : WarrantyBox(
                                          model: pmJobs.tModel ?? '-',
                                          serial: pmJobs.serialNo ?? '-',
                                          status:
                                              pmJobs.tWarranty == '1' ? 1 : 0,
                                          filePdf: filePdf),
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
                                                index: index,
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
                              // AddNote(
                              //     notePic: jobController.notePic,
                              //     notesFiles: jobController.notesFiles,
                              //     notes: jobController.notes,
                              //     addAttatchments:
                              //         jobController.addAttatchments,
                              //     isPicking: jobController.isPicking,
                              //     addNote: jobController.addNote),
                              // 8.kH,
                              // BoxContainer(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Expanded(
                              //           child: InkWell(
                              //             onTap: () => Get.to(() =>
                              //                 CalendarView2(other: 'yes')),
                              //             child: InputDecorator(
                              //               decoration: InputDecoration(
                              //                 border: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(10.0),
                              //                 ),
                              //               ),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: <Widget>[
                              //                   Text(
                              //                     'My Tasks',
                              //                     style: TextStyleList.text16,
                              //                   ),
                              //                   const Icon(
                              //                     Icons.calendar_today,
                              //                     size: 22,
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         10.wH,
                              //         Expanded(
                              //           child: InkWell(
                              //             onTap: () => selectDate(context,
                              //                 jobController.selectedDateTime),
                              //             child: InputDecorator(
                              //               decoration: InputDecoration(
                              //                 labelText: "Reschedule",
                              //                 labelStyle:
                              //                     TextStyleList.headtitle2,
                              //                 border: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(10.0),
                              //                 ),
                              //               ),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: <Widget>[
                              //                   Obx(() {
                              //                     return Text(
                              //                       jobController
                              //                                   .selectedDateTime
                              //                                   .value !=
                              //                               null
                              //                           ? DateFormat.yMMMd()
                              //                               .add_jms()
                              //                               .format(jobController
                              //                                   .selectedDateTime
                              //                                   .value!)
                              //                           : 'Select Date',
                              //                       style: TextStyleList.text5,
                              //                     );
                              //                   }),
                              //                   Obx(() => jobController
                              //                               .selectedDateTime
                              //                               .value ==
                              //                           null
                              //                       ? const Icon(
                              //                           Icons.calendar_today,
                              //                           size: 22,
                              //                         )
                              //                       : Container()),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     15.kH,
                              //     Row(
                              //       children: [
                              //         GestureDetector(
                              //           onTap: () {
                              //             jobController.confirm.value =
                              //                 !jobController.confirm.value;
                              //           },
                              //           child: Container(
                              //             width: 24,
                              //             height: 24,
                              //             decoration: BoxDecoration(
                              //               color: jobController.confirm.value
                              //                   ? red1
                              //                   : Colors.transparent,
                              //               border: !jobController.confirm.value
                              //                   ? Border.all(color: Colors.grey)
                              //                   : Border.all(
                              //                       color: Colors.transparent),
                              //               borderRadius:
                              //                   BorderRadius.circular(4),
                              //             ),
                              //             child: jobController.confirm.value
                              //                 ? const Icon(Icons.check,
                              //                     color: Colors.white, size: 20)
                              //                 : null,
                              //           ),
                              //         ),
                              //         8.wH,
                              //         Text(
                              //           'Confirm schedule',
                              //           style: TextStyleList.text9,
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
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
      bottomNavigationBar: showOnly == null
          ? BottomAppBar(
              color: white3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: EndButton(
                      onPressed: () {
                        jobController.showAcceptDialog(
                          context,
                          'Are you sure to confirm?',
                          'No',
                          'Yes',
                        );
                      },
                      text: 'Confirm',
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
                                    textSet: jobController.cancelNote.value,
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
                                  onPressed: () async {
                                    await updateJobPM(
                                        ticketId.toString(),
                                        2,
                                        jobController.cancelNote.value.text,
                                        jobController
                                            .issueData.first.customerStatus,
                                        'yes');

                                    Navigator.pop(context);
                                    Navigator.pop(context);
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
            )
          : null,
    );
  }
}
