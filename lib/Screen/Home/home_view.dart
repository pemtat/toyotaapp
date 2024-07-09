import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Screen/Allticket/AssignedJobs/assignedjobs_view.dart';
import 'package:toyotamobile/Screen/Allticket/PMAssignedJobs/pmAssignedjobs_view.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/SubJobs_widget/subjobs_widget.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/titleheader_widget.dart';
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
  final SubTicketController subticketController =
      Get.put(SubTicketController());
  final AssignedjobsNew assignedjobsNew = Get.put(AssignedjobsNew());
  @override
  Widget build(BuildContext context) {
    double marginInside = 26;
    // ignore: deprecated_member_use
    return Obx(
      () {
        if (jobController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: white5,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(preferredSize),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: white3,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('My Jobs', style: TextStyleList.title1),
                        Text(getFormattedDate(DateTime.now()),
                            style: TextStyleList.title1),
                      ],
                    ),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() {
                      var userData =
                          jobController.userController.userInfo.isNotEmpty
                              ? jobController.userController.userInfo.first
                              : null;
                      if (userData != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: paddingApp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${userData.resourceNo} - ${userData.name}',
                                style: TextStyleList.title2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Service Zone : ',
                                    style: TextStyleList.title3,
                                  ),
                                  Wrap(
                                      children: jobController.serviceZoneSet
                                          .map((zone) {
                                    return Text(
                                      '$zone ',
                                      style: TextStyleList.title3,
                                    );
                                  }).toList()),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                    4.kH,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: white3,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: paddingApp),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Last 90 days',
                                style: TextStyleList.subtext3,
                              ),
                              const ArrowDown()
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: marginInside),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Jobs',
                                  style: TextStyleList.title4,
                                ),
                                Text(
                                  'Closed',
                                  style: TextStyleList.title4,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: marginInside),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  jobController.totalJobs.value.toString(),
                                  style: TextStyleList.headingbar,
                                ),
                                Text(
                                  jobController.closedJobs.value.toString(),
                                  style: TextStyleList.headingbar,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: marginInside),
                            height: 14,
                            decoration: BoxDecoration(
                              color: white3,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: white2, width: 1.5),
                            ),
                            child: Obx(() => LinearProgressIndicator(
                                value: jobController.closedJobs.value /
                                    jobController.totalJobs.value,
                                backgroundColor: Colors.transparent,
                                color: red7)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: paddingApp),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => PmAssignedJobsView());
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: Expanded(
                                  child: _buildInfoCard(
                                    icon: Icons.inbox,
                                    value: jobController.incomingJobs.value,
                                    label: 'Incoming',
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Expanded(
                                  child: _buildInfoCard(
                                    icon: Icons.warning,
                                    value: jobController.overdueJobs.value,
                                    label: 'Overdue',
                                    labelColor: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => AssignedjobsNew(
                                      selectIndex: 2,
                                    ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Expanded(
                                  child: _buildInfoCard(
                                    icon: Icons.build,
                                    value: jobController.onProcessJobs.value,
                                    label: 'On Process',
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    // 10.kH,
                    // Container(
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: paddingApp),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       JobStatusItem(
                    //         onTap: () {
                    //           Get.to(() => AssignedjobsNew());
                    //         },
                    //         count: jobController.subjobList,
                    //         title: 'Incoming New Jobs',
                    //         countColor: const Color(0xffEB0A1E),
                    //         titleColor: const Color(0xff434343),
                    //         containerColor:
                    //             const Color.fromARGB(255, 242, 194, 198),
                    //         imagePath: 'assets/propjob.png',
                    //         flexValue: 6,
                    //         center: false,
                    //       ),
                    //       10.wH,
                    //       JobStatusItem(
                    //         onTap: () {
                    //           Get.to(() => CompleteJobsView());
                    //         },
                    //         count: jobController.subjobListPending,
                    //         title: 'On Process Jobs',
                    //         countColor: const Color(0xff323232),
                    //         titleColor: const Color(0xff434343),
                    //         containerColor: const Color(0xffEAEAEA),
                    //         flexValue: 4,
                    //         center: true,
                    //       ),
                    //       5.wH,
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.all(paddingApp),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       JobStatusItem(
                    //         onTap: () {
                    //           Get.to(() => PmAssignedJobsView());
                    //         },
                    //         count: jobController.pmjobList,
                    //         title: 'PM\nIncoming Jobs',
                    //         countColor: const Color(0xffEB0A1E),
                    //         titleColor: const Color(0xff434343),
                    //         containerColor:
                    //             const Color.fromARGB(255, 242, 194, 198),
                    //         imagePath: 'assets/propjob.png',
                    //         flexValue: 6,
                    //         center: false,
                    //       ),
                    //       10.wH,
                    //       JobStatusItem(
                    //         onTap: () {
                    //           Get.to(() => PmCompleteJobsView());
                    //         },
                    //         count: jobController.pmjobListConfirmed,
                    //         title: 'PM\nOn Process Jobs',
                    //         countColor: const Color(0xff323232),
                    //         titleColor: const Color(0xff434343),
                    //         containerColor: const Color(0xffEAEAEA),
                    //         flexValue: 4,
                    //         center: true,
                    //       ),
                    //       5.wH,
                    //     ],
                    //   ),
                    // ),
                    const AppDivider(),
                    10.kH,
                    const JobTitle(
                      headerText: 'Recently Jobs',
                      buttonText: '',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(paddingApp),
                      child: Obx(() {
                        final filteredJobs = jobController.subJobAssigned
                            .where((job) => job.status == '101')
                            .toList();

                        if (filteredJobs.isEmpty) {
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
                          itemCount: filteredJobs.length,
                          itemBuilder: (context, index) {
                            final job = filteredJobs[index];
                            return InkWell(
                              onTap: () {
                                Get.to(() => PendingTaskView(
                                    ticketId: job.bugId ?? '',
                                    jobId: job.id.toString()));
                              },
                              child: SubJobsTicket(
                                  index: index,
                                  jobsHome: jobController,
                                  bugId: job.bugId ?? '',
                                  reporter: job.reporterId ?? '',
                                  job: job,
                                  expandedIndex: jobController.expandedIndex,
                                  jobController: subticketController,
                                  status: stringToStatus(job.status ?? '')),
                            );
                          },
                        );
                      }),
                    ),
                    const JobTitle(
                      headerText: 'PM Recently Jobs',
                      buttonText: '',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(paddingApp),
                      child: Obx(() {
                        final jobData = jobController.pmItems
                            .where((job) =>
                                stringToStatus(job.status ?? '') == 'pending')
                            .toList();

                        if (jobData.isEmpty) {
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
                            var job = jobData[index];
                            return InkWell(
                              onTap: () {
                                if (stringToStatus(job.status ?? '') ==
                                    'pending') {
                                  Get.to(() => PendingTaskViewPM(
                                      ticketId: job.id ?? ''));
                                } else if (stringToStatus(job.status ?? '') ==
                                    'confirmed') {
                                  Get.to(() =>
                                      JobDetailViewPM(ticketId: job.id ?? ''));
                                } else if (stringToStatus(job.status ?? '') ==
                                    'closed') {
                                  Get.to(() => TicketPMDetailView(
                                      ticketId: job.id ?? ''));
                                }
                              },
                              child: PmItemWidget(
                                job: job,
                                expandedIndex: jobController.expandedIndex2,
                                jobController: jobController,
                                sidebar: SidebarColor.getColor(
                                    stringToStatus(job.status ?? '')),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: white3,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'My Rating',
                            style: TextStyleList.title4,
                          ),
                          5.wH,
                          PannableRatingBar.builder(
                            rate: 3,
                            alignment: WrapAlignment.center,
                            spacing: 2,
                            runSpacing: 5,
                            itemCount: 5,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return const RatingWidget(
                                selectedColor: orange2,
                                unSelectedColor: white1,
                                child: Icon(
                                  Icons.star,
                                  size: 30,
                                ),
                              );
                            },
                            onChanged: (value) {},
                          )
                        ],
                      ),
                    ),
                    10.kH,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(
      {required IconData icon,
      required String label,
      required int value,
      Color? labelColor}) {
    return Container(
      width: 115,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: white3,
          border: Border.all(color: black1),
          borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 28,
                color: const Color.fromARGB(255, 129, 129, 129),
              ),
              5.wH,
              Text(
                value.toString(),
                style: labelColor != null
                    ? TextStyleList.headingbar2
                    : TextStyleList.headingbar,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyleList.subtitle4,
          ),
        ],
      ),
    );
  }
}
