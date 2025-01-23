import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/Allticket/PMAssignedJobs/pmAssignedjobs_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/Ticket/ticket_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/searchbar_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class PmAssignedJobsView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final TicketController ticketController = Get.put(TicketController());
  final PMAssignedJobsController pmAssignedController =
      Get.put(PMAssignedJobsController());

  PmAssignedJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Column(
            children: [
              AppBar(
                backgroundColor: white3,
                title: Text(context.tr('pm_job'), style: TextStyleList.title1),
              ),
              Container(
                height: 0.5,
                color: white1,
              ),
              const AppDivider()
            ],
          ),
        ),
        body: RefreshIndicator(
          color: Colors.red,
          backgroundColor: Colors.white,
          onRefresh: refresh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.kH,
              SearchFilter(
                  searchController: pmAssignedController.searchController,
                  searchQuery: pmAssignedController.searchQuery,
                  statusCheckboxes: statusCheckboxes(),
                  selectedDate: pmAssignedController.selectedDate,
                  clearFilters: pmAssignedController.clearFilters),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pmAssignedController.isSelected.value = 1;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    pmAssignedController.isSelected.value == 1
                                        ? red4
                                        : white5,
                                border: const Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 162, 160, 160),
                                  ),
                                ),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Text(
                                  '${context.tr('pending')} (${jobController.pmjobList.value})',
                                  style:
                                      pmAssignedController.isSelected.value == 1
                                          ? TextStyleList.text7
                                          : TextStyleList.text6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pmAssignedController.isSelected.value = 2;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    pmAssignedController.isSelected.value == 2
                                        ? red4
                                        : white5,
                                border: const Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 162, 160, 160),
                                    ),
                                    left: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 218, 214, 214),
                                    ),
                                    right: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 218, 214, 214),
                                    )),
                              ),
                              child: Center(
                                child: Text(
                                  '${context.tr('confirmed')} (${jobController.pmjobListConfirmed.value})',
                                  style:
                                      pmAssignedController.isSelected.value == 2
                                          ? TextStyleList.text7
                                          : TextStyleList.text6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          pmAssignedController.isSelected.value = 3;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    pmAssignedController.isSelected.value == 3
                                        ? red4
                                        : white5,
                                border: const Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 162, 160, 160),
                                  ),
                                ),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Text(
                                  '${context.tr('completed')} (${jobController.pmCompletedList.value})',
                                  style:
                                      pmAssignedController.isSelected.value == 3
                                          ? TextStyleList.text7
                                          : TextStyleList.text6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              // 16.kH,
              // Obx(() {
              //   return Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: List.generate(
              //             (jobController.pmItems.length /
              //                     pmAssignedController.itemsPerPage)
              //                 .ceil(), (index) {
              //           final pageIndex = index + 1;
              //           return InkWell(
              //             onTap: () {
              //               pmAssignedController.currentPage.value = pageIndex;
              //             },
              //             child: Obx(() {
              //               final isSelected =
              //                   pmAssignedController.currentPage.value ==
              //                       pageIndex;
              //               return Container(
              //                 padding: const EdgeInsets.symmetric(
              //                     vertical: 7.0, horizontal: 12.0),
              //                 decoration: BoxDecoration(
              //                     color: isSelected ? red4 : white8,
              //                     border: Border.all(
              //                         color: const Color.fromARGB(
              //                             136, 218, 213, 213))),
              //                 child: Text(
              //                   '$pageIndex',
              //                   style: isSelected
              //                       ? TextStyleList.text7
              //                       : TextStyleList.text6,
              //                 ),
              //               );
              //             }),
              //           );
              //         }),
              //       ),
              //     ),
              //   );
              // }),
              Obx(() {
                if (pmAssignedController.isSelected.value == 1) {
                  return buildJobList(context, 'pending');
                } else if (pmAssignedController.isSelected.value == 2) {
                  return buildJobList(context, 'confirmed');
                } else if (pmAssignedController.isSelected.value == 3) {
                  return buildJobList(context, 'completedAndclosed');
                } else {
                  return const SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildJobList(BuildContext context, String status) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(paddingApp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.kH,
            Expanded(
              child: Obx(() {
                final filteredJobs = jobController.pmItems.where((job) {
                  final searchQueryMatch = job.id!
                          .contains(pmAssignedController.searchQuery.value) ||
                      job.description!
                          .contains(pmAssignedController.searchQuery.value);
                  final statusMatch =
                      pmAssignedController.selectedStatus.isEmpty ||
                          pmAssignedController.selectedStatus
                              .contains(stringToStatus(job.status ?? ''));
                  final jobDate = formatDateTimeString(job.dueDate ?? '');
                  final dateMatch = pmAssignedController.selectedDate.value ==
                          null ||
                      (jobDate.year ==
                              pmAssignedController.selectedDate.value!.year &&
                          jobDate.month ==
                              pmAssignedController.selectedDate.value!.month &&
                          jobDate.day ==
                              pmAssignedController.selectedDate.value!.day);
                  return searchQueryMatch &&
                      dateMatch &&
                      status.contains(stringToStatus(job.status ?? '')) &&
                      statusMatch;
                }).toList();

                if (filteredJobs.isEmpty) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Center(
                          child: Text(
                        context.tr('no_jobs_avb'),
                        style: TextStyleList.subtitle2,
                      )),
                    ),
                  );
                }
                filteredJobs
                    .sort((a, b) => b.dueDate!.compareTo(a.dueDate ?? ''));
                return ListView.builder(
                  itemCount: filteredJobs.length,
                  itemBuilder: (context, index) {
                    final job = filteredJobs[index];
                    return InkWell(
                      onTap: () {
                        if (job.techStatus == '2') {
                        } else if (status == 'pending') {
                          Get.to(
                              () => PendingTaskViewPM(ticketId: job.id ?? ''));
                        } else if (status == 'confirmed') {
                          Get.to(() => JobDetailViewPM(ticketId: job.id ?? ''));
                        } else {
                          Get.to(
                              () => TicketPMDetailView(ticketId: job.id ?? ''));
                        }
                      },
                      child: job.techStatus == '2'
                          ? PmItemWidget(
                              job: job,
                              index: index,
                              confirm: 'no',
                              expandedIndex: pmAssignedController.expandedIndex,
                              jobController: jobController,
                              sidebar: SidebarColor.getColor(
                                'notconfirm',
                              ))
                          : PmItemWidget(
                              job: job,
                              index: index,
                              expandedIndex: pmAssignedController.expandedIndex,
                              jobController: jobController,
                              sidebar: SidebarColor.getColor(
                                  stringToStatus(job.status ?? '')),
                            ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'pending',
          selectedStatus: pmAssignedController.selectedStatus),
      buildCheckbox(
          status: 'confirmed',
          selectedStatus: pmAssignedController.selectedStatus),
      buildCheckbox(
          status: 'completed',
          selectedStatus: pmAssignedController.selectedStatus),
      buildCheckbox(
          status: 'closed',
          selectedStatus: pmAssignedController.selectedStatus),
    ];
  }
}
