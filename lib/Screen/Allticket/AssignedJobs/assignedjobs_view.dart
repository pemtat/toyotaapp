import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Allticket/AssignedJobs/assignedjobs_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
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

class AssignedjobsNew extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final AssignedjobsController assignedController =
      Get.put(AssignedjobsController());

  AssignedjobsNew({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Scaffold(
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
              searchController: assignedController.searchController,
              searchQuery: assignedController.searchQuery,
              statusCheckboxes: statusCheckboxes(),
              selectedDate: assignedController.selectedDate,
              clearFilters: assignedController.clearFilters),
          10.kH,
          JobTitle(
            headerText: 'Incoming Jobs',
            buttonText: '',
            buttonOnPressed: () {},
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(paddingApp),
              child: Obx(() {
                final filteredJobs = jobController.jobList.where((job) {
                  final query =
                      assignedController.searchQuery.value.toLowerCase();
                  final searchQueryMatch = job.ticketid.contains(query) ||
                      job.summary.contains(query);
                  final statusMatch = assignedController
                          .selectedStatus.isEmpty ||
                      assignedController.selectedStatus.contains(job.status);
                  final dateMatch = assignedController.selectedDate.value ==
                          null ||
                      (job.date.year ==
                              assignedController.selectedDate.value!.year &&
                          job.date.month ==
                              assignedController.selectedDate.value!.month &&
                          job.date.day ==
                              assignedController.selectedDate.value!.day);
                  return searchQueryMatch &&
                      dateMatch &&
                      statusMatch &&
                      job.status != 'closed';
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
                        if (job.status == 'assigned') {
                          Get.to(() => PendingTaskView(
                                ticketId: job.jobid,
                                jobId: '',
                              ));
                        } else {
                          Get.to(() => JobDetailView(
                              ticketId: job.jobid, jobId: job.jobid));
                        }
                      },
                      child: JobItemWidget(
                        job: job,
                        expandedIndex: assignedController.expandedIndex,
                        jobController: jobController,
                        sidebar: SidebarColor.getColor(job.status),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox(
          status: 'assigned',
          selectedStatus: assignedController.selectedStatus),
      buildCheckbox(
          status: 'new', selectedStatus: assignedController.selectedStatus),
      buildCheckbox(
          status: 'closed', selectedStatus: assignedController.selectedStatus),
      buildCheckbox(
          status: 'feedback',
          selectedStatus: assignedController.selectedStatus),
    ];
  }
}
