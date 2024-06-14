import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Allticket/CompleteJobs/completejobs_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/Home_widget/home_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/searchbar_widget.dart';
import 'package:toyotamobile/Widget/titleheader_widget.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteJobsView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final CompleteJobsController completeJobsController =
      Get.put(CompleteJobsController());

  CompleteJobsView({super.key});

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
                title: Text('My Jobs', style: TextStyleList.title1),
                leading: const BackIcon(),
              ),
              Container(
                height: 0.5,
                color: white1,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            15.kH,
            SearchFilter(
                searchController: completeJobsController.searchController,
                searchQuery: completeJobsController.searchQuery,
                statusCheckboxes: statusCheckboxes(),
                selectedDate: completeJobsController.selectedDate,
                clearFilters: completeJobsController.clearFilters),
            10.kH,
            JobTitle(
              headerText: 'Complete Jobs',
              buttonText: '',
              buttonOnPressed: () {},
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(paddingApp),
                child: Obx(() {
                  final filteredJobs = jobController.jobList.where((job) {
                    final query =
                        completeJobsController.searchQuery.value.toLowerCase();
                    final searchQueryMatch = job.ticketid.contains(query) ||
                        job.summary.contains(query);
                    final statusMatch =
                        completeJobsController.selectedStatus.isEmpty ||
                            completeJobsController.selectedStatus
                                .contains(job.status);
                    final dateMatch =
                        completeJobsController.selectedDate.value == null ||
                            (job.date.year ==
                                    completeJobsController
                                        .selectedDate.value!.year &&
                                job.date.month ==
                                    completeJobsController
                                        .selectedDate.value!.month &&
                                job.date.day ==
                                    completeJobsController
                                        .selectedDate.value!.day);
                    return searchQueryMatch &&
                        dateMatch &&
                        statusMatch &&
                        job.status == 'closed';
                  }).toList();
                  if (filteredJobs.isEmpty) {
                    return const Center(child: Text('No new jobs available.'));
                  }
                  return ListView.builder(
                    itemCount: filteredJobs.length,
                    itemBuilder: (context, index) {
                      Home job = filteredJobs[index];
                      return InkWell(
                          onTap: () {
                            Get.to(() => TicketDetailView(
                                  ticketId: job.jobid,
                                ));
                          },
                          child: JobItemWidget(
                            job: job,
                            expandedIndex: completeJobsController.expandedIndex,
                            jobController: jobController,
                            sidebar: SidebarColor.getColor(job.status),
                          ));
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'assigned',
          selectedStatus: completeJobsController.selectedStatus),
      buildCheckbox(
          status: 'new', selectedStatus: completeJobsController.selectedStatus),
      buildCheckbox(
          status: 'closed',
          selectedStatus: completeJobsController.selectedStatus),
      buildCheckbox(
          status: 'feedback',
          selectedStatus: completeJobsController.selectedStatus),
    ];
  }
}
