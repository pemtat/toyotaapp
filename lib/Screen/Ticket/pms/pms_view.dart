import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Screen/Ticket/pms/pms_controller.dart';
import 'package:toyotamobile/Screen/Ticket/ticket_controller.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class Pms extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final PmsController pmsController = Get.put(PmsController());
  final SubTicketController subticketController =
      Get.put(SubTicketController());
  final TicketController ticketController = Get.put(TicketController());
  Pms({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (jobController.isLoading.value) {
          return const Expanded(child: Center(child: CircleLoading()));
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
                    final isFiltering =
                        ticketController.searchQuery.value != '' ||
                            ticketController.selectedStatus.isNotEmpty ||
                            ticketController.selectedDate.value != null;

                    final jobs = isFiltering
                        ? jobController.pmItems
                        : jobController.pmItemsPage;

                    final filteredJobs = jobs.where((job) {
                      final searchQueryMatch = job.customerName!
                              .contains(ticketController.searchQuery.value) ||
                          job.description!
                              .contains(ticketController.searchQuery.value) ||
                          job.id!.contains(ticketController.searchQuery.value);
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
                          job.customerStatus == '1' &&
                          statusMatch;
                    }).toList();
                    filteredJobs
                        .sort((a, b) => b.dueDate!.compareTo(a.dueDate ?? ''));

                    if (filteredJobs.isEmpty) {
                      return SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Center(
                              child: Text(
                            context.tr('no_jobs_avb'),
                            style: TextStyleList.subtitle2,
                          )),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: isFiltering
                                ? null
                                : pmsController.scrollController,
                            shrinkWrap: true,
                            itemCount: filteredJobs.length,
                            itemBuilder: (context, index) {
                              var job = filteredJobs[index];
                              return InkWell(
                                onTap: () {
                                  if (job.techStatus == '2') {
                                  } else if (stringToStatus(job.status ?? '') ==
                                      'pending') {
                                    Get.to(() => PendingTaskViewPM(
                                        ticketId: job.id ?? ''));
                                  } else if (stringToStatus(job.status ?? '') ==
                                      'confirmed') {
                                    Get.to(() => JobDetailViewPM(
                                        ticketId: job.id ?? ''));
                                  } else {
                                    Get.to(() => TicketPMDetailView(
                                        ticketId: job.id ?? ''));
                                  }
                                },
                                child: job.techStatus == '2'
                                    ? PmItemWidget(
                                        job: job,
                                        confirm: 'no',
                                        expandedIndex:
                                            pmsController.expandedIndex,
                                        jobController: jobController,
                                        sidebar: SidebarColor.getColor(
                                          'notconfirm',
                                        ))
                                    : PmItemWidget(
                                        job: job,
                                        expandedIndex:
                                            pmsController.expandedIndex,
                                        jobController: jobController,
                                        sidebar: SidebarColor.getColor(
                                            stringToStatus(job.status ?? '')),
                                      ),
                              );
                            },
                          ),
                        ),
                        if (!isFiltering && pmsController.loading.value)
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
