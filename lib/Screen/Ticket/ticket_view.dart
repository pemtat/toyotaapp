import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/ticketbyid_model.dart' as ticket;
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_view.dart';
import 'package:toyotamobile/Screen/Ticket/ticket_controller.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Home_widget/home_widget.dart';
import 'package:toyotamobile/Widget/SubJobs_widget/subjobs_widget.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/searchbar_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class TicketView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final TicketController ticketController = Get.put(TicketController());
  final SubTicketController subticketController =
      Get.put(SubTicketController());
  TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(preferredSize),
          child: Column(
            children: [
              AppBar(
                backgroundColor: white3,
                title: Text('All Ticket', style: TextStyleList.title1),
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
          onRefresh: refresh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.kH,
              SearchFilter(
                  searchController: ticketController.searchController,
                  searchQuery: ticketController.searchQuery,
                  statusCheckboxes: statusCheckboxes(),
                  selectedDate: ticketController.selectedDate,
                  clearFilters: ticketController.clearFilters),
              16.kH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ticketController.isSelected.value = 1;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ticketController.isSelected.value == 1
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
                                  'PM',
                                  style: ticketController.isSelected.value == 1
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
                          ticketController.isSelected.value = 2;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ticketController.isSelected.value == 2
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
                                  'Ticket',
                                  style: ticketController.isSelected.value == 2
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
                          ticketController.isSelected.value = 3;
                        },
                        child: Obx(() => Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ticketController.isSelected.value == 3
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
                                  'Job',
                                  style: ticketController.isSelected.value == 3
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
                if (ticketController.isSelected.value == 1) {
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
                                  jobController.pmItems.where((job) {
                                final searchQueryMatch = job.customerName!
                                        .contains(ticketController
                                            .searchQuery.value) ||
                                    job.description!.contains(
                                        ticketController.searchQuery.value);
                                final statusMatch =
                                    ticketController.selectedStatus.isEmpty ||
                                        ticketController.selectedStatus
                                            .contains(job.pmStatus);
                                final jobDate =
                                    formatDateTimeString(job.pmPlan ?? '');
                                final dateMatch =
                                    ticketController.selectedDate.value ==
                                            null ||
                                        (jobDate.year ==
                                                ticketController
                                                    .selectedDate.value!.year &&
                                            jobDate.month ==
                                                ticketController.selectedDate
                                                    .value!.month &&
                                            jobDate.day ==
                                                ticketController
                                                    .selectedDate.value!.day);
                                return searchQueryMatch &&
                                    dateMatch &&
                                    statusMatch;
                              }).toList();
                              if (filteredJobs.isEmpty) {
                                return Center(
                                    child: Text(
                                  'No jobs available.',
                                  style: TextStyleList.subtitle2,
                                ));
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  var job = filteredJobs[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => JobDetailViewPM(
                                          ticketId: '99', data: job));
                                    },
                                    child: PmItemWidget(
                                      job: job,
                                      expandedIndex:
                                          ticketController.expandedIndex2,
                                      jobController: jobController,
                                      sidebar: SidebarColor.getColor(
                                          job.pmStatus ?? ''),
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
                } else if (ticketController.isSelected.value == 2) {
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
                                  jobController.issueData.where((job) {
                                final jobDate = job.dueDate ?? DateTime.now();

                                final searchQueryMatch = job.id
                                        .toString()
                                        .contains(ticketController
                                            .searchQuery.value) ||
                                    job.description!.contains(
                                        ticketController.searchQuery.value);
                                final statusMatch =
                                    ticketController.selectedStatus.isEmpty ||
                                        ticketController.selectedStatus
                                            .contains(job.status!.name);

                                final dateMatch =
                                    ticketController.selectedDate.value ==
                                            null ||
                                        (jobDate.year ==
                                                ticketController
                                                    .selectedDate.value!.year &&
                                            jobDate.month ==
                                                ticketController.selectedDate
                                                    .value!.month &&
                                            jobDate.day ==
                                                ticketController
                                                    .selectedDate.value!.day);
                                return searchQueryMatch &&
                                    statusMatch &&
                                    dateMatch;
                              }).toList();
                              // filteredJobs.sort(
                              //     (a, b) => b.dueDate!.compareTo(a.dueDate!));

                              if (filteredJobs.isEmpty) {
                                return Center(
                                    child: Text(
                                  'No jobs available.',
                                  style: TextStyleList.subtitle2,
                                ));
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredJobs.length,
                                itemBuilder: (context, index) {
                                  ticket.Issues job = filteredJobs[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => SubTicketView(
                                          ticketId: job.id.toString()));
                                    },
                                    child: JobItemWidget(
                                      job: job,
                                      expandedIndex:
                                          ticketController.expandedIndex2,
                                      jobController: jobController,
                                      sidebar: SidebarColor.getColor(
                                          job.status!.name ?? ''),
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
                } else if (ticketController.isSelected.value == 3) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(paddingApp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.kH,
                          Expanded(
                            child: Obx(() {
                              if (jobController.subJobAssigned.isEmpty) {
                                return Center(
                                    child: Text(
                                  'No jobs available.',
                                  style: TextStyleList.subtitle2,
                                ));
                              }
                              final filteredJobs =
                                  jobController.subJobAssigned.where((job) {
                                final query = ticketController.searchQuery.value
                                    .toLowerCase();
                                final searchQueryMatch =
                                    job.id.toString().contains(query) ||
                                        job.description!.contains(query);
                                final statusMatch = ticketController
                                        .selectedStatus.isEmpty ||
                                    ticketController.selectedStatus.contains(
                                        stringToStatus(job.status ?? ''));

                                return searchQueryMatch && statusMatch;
                              }).toList();

                              if (filteredJobs.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No jobs match the search',
                                    style: TextStyleList.subtitle2,
                                  ),
                                );
                              }
                              return ListView.builder(
                                itemCount: jobController.subJobAssigned.length,
                                itemBuilder: (context, index) {
                                  final job =
                                      jobController.subJobAssigned[index];
                                  return InkWell(
                                    onTap: () {
                                      if (job.status == '101') {
                                        Get.to(() => PendingTaskView(
                                            ticketId: job.bugId ?? '',
                                            jobId: job.id.toString()));
                                      } else if (job.status == '103') {
                                        Get.to(() => TicketDetailView(
                                              ticketId: job.bugId ?? '',
                                              jobId: job.id.toString(),
                                            ));
                                      } else {
                                        Get.to(() => JobDetailView(
                                            ticketId: job.bugId ?? '',
                                            jobId: job.id.toString()));
                                      }
                                      ;
                                    },
                                    child: SubJobsTicket(
                                      index: index,
                                      jobsHome: jobController,
                                      bugId: job.bugId ?? '',
                                      job: job,
                                      reporter: job.reporterId ?? '',
                                      expandedIndex:
                                          ticketController.expandedIndex,
                                      jobController: subticketController,
                                      status: stringToStatus(job.status ?? ''),
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
          status: 'assigned', selectedStatus: ticketController.selectedStatus),
      buildCheckbox(
          status: 'new', selectedStatus: ticketController.selectedStatus),
      buildCheckbox(
          status: 'closed', selectedStatus: ticketController.selectedStatus),
      buildCheckbox(
          status: 'feedback', selectedStatus: ticketController.selectedStatus),
    ];
  }
}
