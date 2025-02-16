import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/Allticket/AssignedJobs/assignedjobs_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/SubJobs_widget/subjobs_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/searchbar_widget.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class AssignedjobsNew extends StatelessWidget {
  final int? selectIndex;
  final HomeController jobController = Get.put(HomeController());
  final AssignedjobsController assignedController =
      Get.put(AssignedjobsController());
  final SubTicketController subticketController =
      Get.put(SubTicketController());
  AssignedjobsNew({super.key, this.selectIndex}) {
    if (selectIndex != null) {
      assignedController.isSelected.value = 2;
    }
  }
  final isSelected = 1.obs;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(preferredSize),
          child: Column(
            children: [
              AppBar(
                backgroundColor: white3,
                title: Text(context.tr('my_job'), style: TextStyleList.title1),
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
                  searchController: assignedController.searchController,
                  searchQuery: assignedController.searchQuery,
                  statusCheckboxes: statusCheckboxes(),
                  selectedDate: assignedController.selectedDate,
                  clearFilters: assignedController.clearFilters),
              16.kH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          assignedController.isSelected.value = 1;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: assignedController.isSelected.value == 1
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
                                  '${context.tr('pending')} (${jobController.subjobList.value})',
                                  style:
                                      assignedController.isSelected.value == 1
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
                          assignedController.isSelected.value = 2;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: assignedController.isSelected.value == 2
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
                                  '${context.tr('confirmed')} (${jobController.subjobListPending.value})',
                                  style:
                                      assignedController.isSelected.value == 2
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
                          assignedController.isSelected.value = 3;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: assignedController.isSelected.value == 3
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
                                  '${context.tr('completed')} (${jobController.subjobListClosed.value})',
                                  style:
                                      assignedController.isSelected.value == 3
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
              Obx(() {
                if (assignedController.isSelected.value == 1) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(paddingApp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.kH,
                          Expanded(
                            child: Obx(() {
                              final filteredJobs =
                                  jobController.subJobAssigned.where((job) {
                                final searchQueryMatch = job.id!.contains(
                                        assignedController.searchQuery.value) ||
                                    job.description!.contains(
                                        assignedController.searchQuery.value);
                                final statusMatch = assignedController
                                        .selectedStatus.isEmpty ||
                                    assignedController.selectedStatus.contains(
                                        stringToStatus(job.status ?? ''));
                                final jobDate =
                                    formatDateTimeString(job.dueDate ?? '');
                                final dateMatch = assignedController
                                            .selectedDate.value ==
                                        null ||
                                    (jobDate.year ==
                                            assignedController
                                                .selectedDate.value!.year &&
                                        jobDate.month ==
                                            assignedController
                                                .selectedDate.value!.month &&
                                        jobDate.day ==
                                            assignedController
                                                .selectedDate.value!.day);
                                return searchQueryMatch &&
                                    dateMatch &&
                                    job.status == '101' &&
                                    statusMatch;
                              }).toList();
                              if (filteredJobs.isEmpty) {
                                return SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
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
                              filteredJobs.sort((a, b) =>
                                  b.dueDate!.compareTo(a.dueDate ?? ''));
                              return ListView.builder(
                                itemCount: filteredJobs.length,
                                itemBuilder: (context, index) {
                                  final job = filteredJobs[index];
                                  return InkWell(
                                    onTap: () {
                                      if (job.techStatus == '2') {
                                      } else {
                                        Get.to(() => PendingTaskView(
                                            ticketId: job.bugId ?? '',
                                            jobId: job.id.toString()));
                                      }
                                    },
                                    child: SubJobsTicket(
                                        index: index,
                                        bugId: job.bugId ?? '',
                                        reporter: job.reporterId ?? '',
                                        confirm: job.techStatus == '2'
                                            ? 'yes'
                                            : null,
                                        job: job,
                                        jobsHome: jobController,
                                        expandedIndex:
                                            jobController.expandedIndex,
                                        jobController: subticketController,
                                        status:
                                            stringToStatus(job.status ?? '')),
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (assignedController.isSelected.value == 2) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(paddingApp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.kH,
                          Expanded(
                            child: Obx(() {
                              final filteredJobs =
                                  jobController.subJobAssigned.where((job) {
                                final searchQueryMatch = job.id!.contains(
                                        assignedController.searchQuery.value) ||
                                    job.description!.contains(
                                        assignedController.searchQuery.value);
                                final statusMatch = assignedController
                                        .selectedStatus.isEmpty ||
                                    assignedController.selectedStatus.contains(
                                        stringToStatus(job.status ?? ''));
                                final jobDate =
                                    formatDateTimeString(job.dueDate ?? '');
                                final dateMatch = assignedController
                                            .selectedDate.value ==
                                        null ||
                                    (jobDate.year ==
                                            assignedController
                                                .selectedDate.value!.year &&
                                        jobDate.month ==
                                            assignedController
                                                .selectedDate.value!.month &&
                                        jobDate.day ==
                                            assignedController
                                                .selectedDate.value!.day);
                                return searchQueryMatch &&
                                    dateMatch &&
                                    job.status == '102' &&
                                    statusMatch;
                              }).toList();
                              if (filteredJobs.isEmpty) {
                                return SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
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
                              filteredJobs.sort((a, b) =>
                                  b.dueDate!.compareTo(a.dueDate ?? ''));
                              return ListView.builder(
                                itemCount: filteredJobs.length,
                                itemBuilder: (context, index) {
                                  final job = filteredJobs[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => JobDetailView(
                                          ticketId: job.bugId ?? '',
                                          jobId: job.id.toString()));
                                    },
                                    child: SubJobsTicket(
                                        index: index,
                                        bugId: job.bugId ?? '',
                                        reporter: job.reporterId ?? '',
                                        job: job,
                                        jobsHome: jobController,
                                        expandedIndex:
                                            jobController.expandedIndex,
                                        jobController: subticketController,
                                        status:
                                            stringToStatus(job.status ?? '')),
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (assignedController.isSelected.value == 3) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(paddingApp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.kH,
                          Expanded(
                            child: Obx(() {
                              final filteredJobs =
                                  jobController.subJobAssigned.where((job) {
                                final searchQueryMatch = job.id!.contains(
                                        assignedController.searchQuery.value) ||
                                    job.description!.contains(
                                        assignedController.searchQuery.value);
                                final statusMatch = assignedController
                                        .selectedStatus.isEmpty ||
                                    assignedController.selectedStatus.contains(
                                        stringToStatus(job.status ?? ''));
                                final jobDate =
                                    formatDateTimeString(job.dueDate ?? '');
                                final dateMatch = assignedController
                                            .selectedDate.value ==
                                        null ||
                                    (jobDate.year ==
                                            assignedController
                                                .selectedDate.value!.year &&
                                        jobDate.month ==
                                            assignedController
                                                .selectedDate.value!.month &&
                                        jobDate.day ==
                                            assignedController
                                                .selectedDate.value!.day);
                                return searchQueryMatch &&
                                    dateMatch &&
                                    (job.status == '103' ||
                                        job.status == '90') &&
                                    statusMatch;
                              }).toList();
                              if (filteredJobs.isEmpty) {
                                return SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
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
                              filteredJobs.sort((a, b) =>
                                  b.dueDate!.compareTo(a.dueDate ?? ''));
                              return ListView.builder(
                                itemCount: filteredJobs.length,
                                itemBuilder: (context, index) {
                                  final job = filteredJobs[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => TicketDetailView(
                                          ticketId: job.bugId ?? '',
                                          jobId: job.id.toString()));
                                    },
                                    child: SubJobsTicket(
                                        index: index,
                                        bugId: job.bugId ?? '',
                                        reporter: job.reporterId ?? '',
                                        job: job,
                                        expandedIndex:
                                            jobController.expandedIndex,
                                        jobController: subticketController,
                                        jobsHome: jobController,
                                        status:
                                            stringToStatus(job.status ?? '')),
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
              10.kH,
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'pending', selectedStatus: assignedController.selectedStatus),
      buildCheckbox(
          status: 'confirmed',
          selectedStatus: assignedController.selectedStatus),
      buildCheckbox(
          status: 'completed',
          selectedStatus: assignedController.selectedStatus),
    ];
  }
}
