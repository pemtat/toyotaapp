import 'package:toyotamobile/Screen/Allticket/CompleteJobs/completejobs_view.dart';
import 'package:toyotamobile/Screen/Allticket/AssignedJobs/assignedjobs_view.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/Home_widget/home_widget.dart';
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
          preferredSize: const Size.fromHeight(60.0),
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
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(paddingApp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    JobStatusItem(
                      count: jobController.jobListLength,
                      title: 'Incoming Jobs',
                      countColor: const Color(0xffEB0A1E),
                      titleColor: const Color(0xff434343),
                      containerColor: const Color.fromARGB(255, 242, 194, 198),
                      imagePath: 'assets/propjob.png',
                      flexValue: 6,
                      center: false,
                    ),
                    10.wH,
                    JobStatusItem(
                      count: jobController.jobListCloseLength,
                      title: 'Completed Jobs',
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
              10.kH,
              const AppDivider(),
              10.kH,
              JobTitle(
                headerText: 'Incoming Jobs',
                buttonText: 'View All',
                buttonOnPressed: () {
                  Get.to(() => AssignedjobsNew());
                },
              ),
              Padding(
                padding: const EdgeInsets.all(paddingApp),
                child: Obx(() {
                  final job = jobController.mostRecentNewJob.value;
                  if (job == null) {
                    return const Center(
                      child: Text('No new jobs available.'),
                    );
                  }

                  return InkWell(
                    onTap: () {
                      Get.to(() => JobDetailView(
                            ticketId: job.jobid,
                            status: job.status,
                          ));
                    },
                    child: JobItemWidget(
                      job: job,
                      expandedIndex: jobController.expandedIndex,
                      jobController: jobController,
                      sidebar: orange1,
                    ),
                  );
                }),
              ),
              JobTitle(
                headerText: 'Completed Jobs',
                buttonText: 'View All',
                buttonOnPressed: () {
                  Get.to(() => CompleteJobsView());
                },
              ),
              Padding(
                padding: const EdgeInsets.all(paddingApp),
                child: Obx(() {
                  final job = jobController.mostRecentCompleteJob.value;
                  if (job == null) {
                    return const Center(
                      child: Text('No new jobs available.'),
                    );
                  }

                  return InkWell(
                    onTap: () {
                      Get.to(() => TicketDetailView(ticketId: job.jobid));
                    },
                    child: JobItemWidget(
                      job: job,
                      expandedIndex: jobController.expandedIndex2,
                      jobController: jobController,
                      sidebar: black6,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
