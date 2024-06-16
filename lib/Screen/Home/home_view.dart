import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Screen/Allticket/CompleteJobs/completejobs_view.dart';
import 'package:toyotamobile/Screen/Allticket/AssignedJobs/assignedjobs_view.dart';
import 'package:toyotamobile/Screen/Allticket/PMAssignedJobs/pmAssignedjobs_view.dart';
import 'package:toyotamobile/Screen/Allticket/PMCompleteJobs/pmCompleteJobs_view.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/Home_widget/home_widget.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/titleheader_widget.dart';
import 'package:toyotamobile/Widget/jobstatus_widget.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

// ignore: use_key_in_widget_constructors
class HomeView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());

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
          // child: Obx(
          //   () {
          // if (jobController.jobList.isEmpty) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                10.kH,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: paddingApp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      JobStatusItem(
                        onTap: () {
                          Get.to(() => AssignedjobsNew());
                        },
                        count: jobController.jobListLength,
                        title: 'Ticket\nIncoming Jobs',
                        countColor: const Color(0xffEB0A1E),
                        titleColor: const Color(0xff434343),
                        containerColor:
                            const Color.fromARGB(255, 242, 194, 198),
                        imagePath: 'assets/propjob.png',
                        flexValue: 6,
                        center: false,
                      ),
                      10.wH,
                      JobStatusItem(
                        onTap: () {
                          Get.to(() => CompleteJobsView());
                        },
                        count: jobController.jobListCloseLength,
                        title: 'Ticket\nCompleted Jobs',
                        countColor: const Color(0xff323232),
                        titleColor: const Color(0xff434343),
                        containerColor: const Color(0xffEAEAEA),
                        flexValue: 4,
                        center: true,
                      ),
                      5.wH,
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(paddingApp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      JobStatusItem(
                        onTap: () {
                          Get.to(() => PmAssignedJobsView());
                        },
                        count: jobController.pmjobList,
                        title: 'PM\nIncoming Jobs',
                        countColor: const Color(0xffEB0A1E),
                        titleColor: const Color(0xff434343),
                        containerColor:
                            const Color.fromARGB(255, 242, 194, 198),
                        imagePath: 'assets/propjob.png',
                        flexValue: 6,
                        center: false,
                      ),
                      10.wH,
                      JobStatusItem(
                        onTap: () {
                          Get.to(() => PmCompleteJobsView());
                        },
                        count: jobController.pmjobListClosed,
                        title: 'PM\nCompleted Jobs',
                        countColor: const Color(0xff323232),
                        titleColor: const Color(0xff434343),
                        containerColor: const Color(0xffEAEAEA),
                        flexValue: 4,
                        center: true,
                      ),
                      5.wH,
                    ],
                  ),
                ),
                const AppDivider(),
                10.kH,
                JobTitle(
                  headerText: 'Ticket Incoming Jobs',
                  buttonText: 'View All',
                  buttonOnPressed: () {
                    Get.to(() => AssignedjobsNew());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(paddingApp),
                  child: Obx(() {
                    final jobs = jobController.jobList;
                    if (jobs.isEmpty) {
                      return Center(
                        child: Text(
                          'No new jobs available.',
                          style: TextStyleList.text3,
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        var job = jobs[index];
                        return InkWell(
                          onTap: () {
                            if (job.status!.name == 'assigned') {
                              Get.to(() => PendingTaskView(
                                    ticketId: job.id.toString(),
                                    jobId: '',
                                  ));
                            } else {
                              Get.to(() => JobDetailView(
                                  ticketId: job.id.toString(),
                                  jobId: job.id.toString()));
                            }
                          },
                          child: JobItemWidget(
                            job: job,
                            expandedIndex: jobController.expandedIndex,
                            jobController: jobController,
                            sidebar:
                                SidebarColor.getColor(job.status!.name ?? ''),
                          ),
                        );
                      },
                    );
                  }),
                ),
                JobTitle(
                  headerText: 'PM Incoming Jobs',
                  buttonText: 'View All',
                  buttonOnPressed: () {
                    Get.to(() => PmAssignedJobsView());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(paddingApp),
                  child: Obx(() {
                    final job = jobController.pmItems;
                    if (job.isEmpty) {
                      return Center(
                        child: Text(
                          'No new jobs available.',
                          style: TextStyleList.text3,
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        var job = jobController.pmItems[index];
                        return InkWell(
                          onTap: () {
                            if (job.pmStatus == 'assigned') {
                              Get.to(() => PendingTaskView(
                                    ticketId: job.jobId ?? '',
                                    jobId: '',
                                  ));
                            } else {
                              Get.to(() => JobDetailView(
                                  ticketId: job.jobId ?? '', jobId: job.jobId));
                            }
                          },
                          child: PmItemWidget(
                            job: job,
                            expandedIndex: jobController.expandedIndex2,
                            jobController: jobController,
                            sidebar: SidebarColor.getColor(job.pmStatus ?? ''),
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
      ),
    );
  }
}
