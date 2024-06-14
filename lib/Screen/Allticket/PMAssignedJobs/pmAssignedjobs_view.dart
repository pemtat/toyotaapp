import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Screen/Allticket/PMAssignedJobs/pmAssignedjobs_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
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
import 'package:toyotamobile/Widget/titleheader_widget.dart';

class PmAssignedJobsView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final TicketController ticketController = Get.put(TicketController());
  final PMAssignedJobsController pmAssignedController =
      Get.put(PMAssignedJobsController());

  PmAssignedJobsView({super.key});

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
                title: Text('My Jobs', style: TextStyleList.title1),
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
                  searchController: pmAssignedController.searchController,
                  searchQuery: pmAssignedController.searchQuery,
                  statusCheckboxes: statusCheckboxes(),
                  selectedDate: pmAssignedController.selectedDate,
                  clearFilters: pmAssignedController.clearFilters),
              JobTitle(
                headerText: 'Incoming Jobs',
                buttonText: '',
                buttonOnPressed: () {},
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(paddingApp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(() {
                          final filteredJobs =
                              jobController.pmItems.where((job) {
                            final jobDate =
                                formatDateTimeString(job.pmPlan ?? '');
                            final searchQueryMatch = job.jobId
                                    .toString()
                                    .contains(pmAssignedController
                                        .searchQuery.value) ||
                                job.description!.contains(
                                    pmAssignedController.searchQuery.value);
                            final statusMatch =
                                pmAssignedController.selectedStatus.isEmpty ||
                                    pmAssignedController.selectedStatus
                                        .contains(job.pmStatus);
                            final dateMatch =
                                pmAssignedController.selectedDate.value ==
                                        null ||
                                    (jobDate.year ==
                                            pmAssignedController
                                                .selectedDate.value!.year &&
                                        jobDate.month ==
                                            pmAssignedController
                                                .selectedDate.value!.month &&
                                        jobDate.day ==
                                            pmAssignedController
                                                .selectedDate.value!.day);
                            return searchQueryMatch &&
                                statusMatch &&
                                dateMatch &&
                                job.pmStatus != 'closed';
                          }).toList();
                          filteredJobs.sort((a, b) =>
                              b.pmStatus!.compareTo(a.pmStatus ?? ''));

                          if (filteredJobs.isEmpty) {
                            return Center(
                                child: Text(
                              'No new jobs available.',
                              style: TextStyleList.subtitle2,
                            ));
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredJobs.length,
                            itemBuilder: (context, index) {
                              var job = filteredJobs[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(() => JobDetailViewPM(ticketId: '99'));
                                },
                                child: PmItemWidget(
                                  job: job,
                                  expandedIndex:
                                      pmAssignedController.expandedIndex,
                                  jobController: jobController,
                                  sidebar:
                                      SidebarColor.getColor(job.pmStatus ?? ''),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'assigned',
          selectedStatus: pmAssignedController.selectedStatus),
      buildCheckbox(
          status: 'new', selectedStatus: pmAssignedController.selectedStatus),
      buildCheckbox(
          status: 'closed',
          selectedStatus: pmAssignedController.selectedStatus),
      buildCheckbox(
          status: 'feedback',
          selectedStatus: pmAssignedController.selectedStatus),
      buildCheckbox(
          status: 'planning',
          selectedStatus: pmAssignedController.selectedStatus),
    ];
  }
}
