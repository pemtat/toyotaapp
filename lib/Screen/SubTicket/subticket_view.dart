import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobs_widget/subjobs_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/searchbar_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class SubTicketView extends StatelessWidget {
  final String ticketId;
  final HomeController jobController = Get.put(HomeController());
  final SubTicketController subticketController =
      Get.put(SubTicketController());

  SubTicketView({super.key, required this.ticketId}) {
    subticketController.fetchData(ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              backgroundColor: white3,
              title: Text('Jobs', style: TextStyleList.title1),
            ),
            Container(
              height: 0.5,
              color: white1,
            ),
            const AppDivider()
          ],
        ),
      ),
      body: Obx(
        () {
          if (subticketController.subJobs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.kH,
                SearchFilter(
                    searchController: subticketController.searchController,
                    searchQuery: subticketController.searchQuery,
                    statusCheckboxes: statusCheckboxes(),
                    selectedDate: subticketController.selectedDate,
                    clearFilters: subticketController.clearFilters),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(paddingApp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Obx(() {
                            if (subticketController.subJobs.isEmpty) {
                              return Center(
                                  child: Text(
                                'No new jobs available.',
                                style: TextStyleList.subtitle2,
                              ));
                            }
                            final filteredJobs =
                                subticketController.subJobs.where((job) {
                              final query = subticketController
                                  .searchQuery.value
                                  .toLowerCase();
                              final searchQueryMatch =
                                  job.id.toString().contains(query) ||
                                      job.summary!.contains(query);
                              final statusMatch = subticketController
                                      .selectedStatus.isEmpty ||
                                  subticketController.selectedStatus.contains(
                                      stringToStatus(job.status!.name ?? ''));

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
                              itemCount: subticketController.subJobs.length,
                              itemBuilder: (context, index) {
                                final job = subticketController.subJobs[index];
                                return InkWell(
                                  onTap: () {
                                    if (job.status!.name == 'new') {
                                      Get.to(() => PendingTaskView(
                                          ticketId: ticketId,
                                          jobId: job.id.toString()));
                                    } else if (job.status!.name == 'closed') {
                                      Get.to(() => TicketDetailView(
                                            ticketId: ticketId,
                                            jobId: job.id.toString(),
                                          ));
                                    } else {
                                      Get.to(() => JobDetailView(
                                          ticketId: ticketId,
                                          jobId: job.id.toString()));
                                    }
                                    ;
                                  },
                                  child: SubJobsTicket(
                                      jobsHome: jobController,
                                      bugId: ticketId,
                                      reporter: job.reporter!.id.toString(),
                                      job: job,
                                      expandedIndex:
                                          subticketController.expandedIndex,
                                      jobController: subticketController,
                                      status: job.status!.name ?? ''),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                10.kH,
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'assigned',
          selectedStatus: subticketController.selectedStatus),
      buildCheckbox(
          status: 'new', selectedStatus: subticketController.selectedStatus),
      buildCheckbox(
          status: 'closed', selectedStatus: subticketController.selectedStatus),
      buildCheckbox(
          status: 'feedback',
          selectedStatus: subticketController.selectedStatus),
    ];
  }
}
