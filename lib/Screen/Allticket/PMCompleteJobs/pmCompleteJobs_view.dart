import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Screen/Allticket/PMCompleteJobs/pmCompleteJobs_controller.dart';
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

class PmCompleteJobsView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final TicketController ticketController = Get.put(TicketController());
  final PMCompleteJobsController pmCompleteController =
      Get.put(PMCompleteJobsController());

  PmCompleteJobsView({super.key});

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
                title: Text('Completed Jobs', style: TextStyleList.title1),
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
                  searchController: pmCompleteController.searchController,
                  searchQuery: pmCompleteController.searchQuery,
                  statusCheckboxes: statusCheckboxes(),
                  selectedDate: pmCompleteController.selectedDate,
                  clearFilters: pmCompleteController.clearFilters),
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
                                formatDateTimeString(job.dueDate ?? '');
                            final searchQueryMatch = job.id.toString().contains(
                                    pmCompleteController.searchQuery.value) ||
                                job.description!.contains(
                                    pmCompleteController.searchQuery.value);
                            final statusMatch =
                                pmCompleteController.selectedStatus.isEmpty ||
                                    pmCompleteController.selectedStatus
                                        .contains(job.status);
                            final dateMatch =
                                pmCompleteController.selectedDate.value ==
                                        null ||
                                    (jobDate.year ==
                                            pmCompleteController
                                                .selectedDate.value!.year &&
                                        jobDate.month ==
                                            pmCompleteController
                                                .selectedDate.value!.month &&
                                        jobDate.day ==
                                            pmCompleteController
                                                .selectedDate.value!.day);
                            return searchQueryMatch &&
                                statusMatch &&
                                dateMatch &&
                                job.status == 'closed';
                          }).toList();
                          filteredJobs.sort(
                              (a, b) => b.status!.compareTo(a.status ?? ''));

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
                                  Get.to(() => JobDetailViewPM(
                                        ticketId: job.id.toString(),
                                      ));
                                },
                                child: PmItemWidget(
                                  job: job,
                                  expandedIndex:
                                      pmCompleteController.expandedIndex,
                                  jobController: jobController,
                                  sidebar:
                                      SidebarColor.getColor(job.status ?? ''),
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
          selectedStatus: pmCompleteController.selectedStatus),
      buildCheckbox(
          status: 'new', selectedStatus: pmCompleteController.selectedStatus),
      buildCheckbox(
          status: 'closed',
          selectedStatus: pmCompleteController.selectedStatus),
      buildCheckbox(
          status: 'feedback',
          selectedStatus: pmCompleteController.selectedStatus),
      buildCheckbox(
          status: 'planning',
          selectedStatus: pmCompleteController.selectedStatus),
    ];
  }
}
