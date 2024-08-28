import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Screen/Ticket/jobs/jobs_controller.dart';
import 'package:toyotamobile/Screen/Ticket/ticket_controller.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobs_widget/subjobs_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class Jobs extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final JobsController jobs = Get.put(JobsController());
  final SubTicketController subTicketController =
      Get.put(SubTicketController());
  final TicketController ticketController = Get.put(TicketController());
  Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (jobController.isLoading.value) {
          return const Expanded(
            child: Center(
              child: CircleLoading(),
            ),
          );
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(paddingApp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.kH,
                Expanded(
                  child: Obx(() {
                    if (jobController.subJobAssignedPage.isEmpty) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Center(
                              child: Text(
                            'No jobs available.',
                            style: TextStyleList.subtitle2,
                          )),
                        ),
                      );
                    }
                    final filteredJobs =
                        jobController.subJobAssignedPage.where((job) {
                      final query =
                          ticketController.searchQuery.value.toLowerCase();
                      final searchQueryMatch =
                          job.id.toString().contains(query) ||
                              job.description!.contains(query);
                      final statusMatch =
                          ticketController.selectedStatus.isEmpty ||
                              ticketController.selectedStatus
                                  .contains(stringToStatus(job.status ?? ''));
                      final jobDate = formatDateTimeString(job.dueDate ?? '');
                      final dateMatch = ticketController.selectedDate.value ==
                              null ||
                          (jobDate.year ==
                                  ticketController.selectedDate.value!.year &&
                              jobDate.month ==
                                  ticketController.selectedDate.value!.month &&
                              jobDate.day ==
                                  ticketController.selectedDate.value!.day);
                      return searchQueryMatch &&
                          dateMatch &&
                          statusMatch &&
                          (job.status == '101' ||
                              job.status == '102' ||
                              job.status == '103');
                    }).toList();

                    if (filteredJobs.isEmpty) {
                      return Center(
                        child: Text(
                          'No jobs match the search',
                          style: TextStyleList.subtitle2,
                        ),
                      );
                    }
                    filteredJobs
                        .sort((a, b) => b.dueDate!.compareTo(a.dueDate ?? ''));
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: jobs.scrollController,
                            itemCount: filteredJobs.length,
                            itemBuilder: (context, index) {
                              final job = filteredJobs[index];
                              return InkWell(
                                onTap: () {
                                  if (job.techStatus == '2') {
                                  } else if (job.status == '101') {
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
                                },
                                child: SubJobsTicket(
                                  index: index,
                                  jobsHome: jobController,
                                  bugId: job.bugId ?? '',
                                  confirm: job.techStatus == '2' ? 'yes' : null,
                                  job: job,
                                  reporter: job.reporterId ?? '',
                                  expandedIndex: ticketController.expandedIndex,
                                  jobController: subTicketController,
                                  status: stringToStatus(job.status ?? ''),
                                ),
                              );
                            },
                          ),
                        ),
                        if (jobs.loading.value)
                          const Center(
                            child: DataCircleLoading(),
                          )
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
