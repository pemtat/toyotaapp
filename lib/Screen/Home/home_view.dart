import 'package:toyotamobile/Function/refresh.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Models/getsubjobassigned_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Screen/Account/account_controller.dart';
import 'package:toyotamobile/Screen/Account/account_view.dart';
import 'package:toyotamobile/Screen/Allticket/AssignedJobs/assignedjobs_view.dart';
import 'package:toyotamobile/Screen/Allticket/PMAssignedJobs/pmAssignedjobs_view.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Screen/Notification/notification_view.dart';
import 'package:toyotamobile/Screen/Overdue/overduejob_view.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/SubJobs_widget/subjobs_widget.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/drawer_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
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
            child: CircleLoading(),
          );
        }
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: white5,
            drawer: Drawer(
              width: 200,
              child: sideDrawer(),
            ),
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
              displacement: 30,
              color: Colors.red,
              backgroundColor: Colors.white,
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
                                '${userData.resourceNo} - ${userData.realName}',
                                style: TextStyleList.title2,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Service Zone : ',
                                      style: TextStyleList.title3,
                                    ),
                                    Text(
                                      userData.zone,
                                      style: TextStyleList.title3,
                                    ),
                                  ]),
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
                        border: Border.all(color: black3),
                        borderRadius: BorderRadius.circular(6),
                        color: white3,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: paddingApp),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Text(
                          //       'Last 90 days',
                          //       style: TextStyleList.subtext3,
                          //     ),
                          //     const ArrowDown()
                          //   ],
                          // ),
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
                                value: jobController.closedJobs.value == 0 &&
                                        jobController.totalJobs.value == 0
                                    ? 0
                                    : jobController.closedJobs.value /
                                        jobController.totalJobs.value,
                                backgroundColor: Colors.transparent,
                                color: red7)),
                          ),
                        ],
                      ),
                    ),
                    2.kH,
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
                                child: _buildInfoCard(
                                  icon: Icons.inbox,
                                  value: jobController.incomingJobs.value,
                                  label: 'Incoming',
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
                                child: _buildInfoCard(
                                  icon: Icons.build,
                                  value: jobController.onProcessJobs.value,
                                  label: 'On Process',
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => OverduejobView());
                              },
                              child: Container(
                                child: _buildInfoCard(
                                  icon: Icons.warning,
                                  value: jobController.overdueJobs.value,
                                  label: 'Overdue',
                                  labelColor: Colors.red,
                                ),
                              ),
                            ),
                          ]),
                    ),
                    const AppDivider(),
                    10.kH,
                    const JobTitle(
                      headerText: 'Recently Jobs',
                      buttonText: '',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(paddingApp),
                      child: Obx(() {
                        final List<dynamic> combinedData = [];

                        final pmJobData = jobController.pmItems
                            .where((job) =>
                                stringToStatus(job.status ?? '') == 'pending' &&
                                job.techStatus != '2')
                            .toList();

                        combinedData.addAll(pmJobData);

                        final jobData = jobController.subJobAssigned
                            .where((job) =>
                                job.status == '101' && job.techStatus != '2')
                            .toList();

                        combinedData.addAll(jobData);
                        combinedData.sort((a, b) {
                          final DateTime aDate = (a is PmModel)
                              ? DateTime.parse(
                                  a.dueDate ?? getFormattedDate(DateTime.now()))
                              : DateTime.parse((a as SubJobAssgined).dueDate ??
                                  getFormattedDate(DateTime.now()));
                          final DateTime bDate = (b is PmModel)
                              ? DateTime.parse(
                                  b.dueDate ?? getFormattedDate(DateTime.now()))
                              : DateTime.parse((b as SubJobAssgined).dueDate ??
                                  getFormattedDate(DateTime.now()));
                          return bDate.compareTo(aDate); // Sort descending
                        });

                        if (combinedData.isEmpty) {
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
                          itemCount: combinedData.length,
                          itemBuilder: (context, index) {
                            final item = combinedData[index];
                            if (item is PmModel) {
                              return InkWell(
                                onTap: () {
                                  if (stringToStatus(item.status ?? '') ==
                                      'pending') {
                                    Get.to(() => PendingTaskViewPM(
                                        ticketId: item.id ?? ''));
                                  } else if (stringToStatus(
                                          item.status ?? '') ==
                                      'confirmed') {
                                    Get.to(() => JobDetailViewPM(
                                        ticketId: item.id ?? ''));
                                  } else if (stringToStatus(
                                          item.status ?? '') ==
                                      'closed') {
                                    Get.to(() => TicketPMDetailView(
                                        ticketId: item.id ?? ''));
                                  }
                                },
                                child: PmItemWidget(
                                  job: item,
                                  index: index,
                                  expandedIndex: jobController.expandedIndex2,
                                  jobController: jobController,
                                  sidebar: SidebarColor.getColor(
                                      stringToStatus(item.status ?? '')),
                                ),
                              );
                            } else {
                              // Display Job Item
                              final job = item as SubJobAssgined;
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
                            }
                          },
                        );
                      }),
                    ),

                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(6),
                    //     color: white3,
                    //   ),
                    //   margin: const EdgeInsets.symmetric(horizontal: 16),
                    //   padding: const EdgeInsets.symmetric(vertical: 6),
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         'My Rating',
                    //         style: TextStyleList.title4,
                    //       ),
                    //       5.wH,
                    //       PannableRatingBar.builder(
                    //         rate: 3,
                    //         alignment: WrapAlignment.center,
                    //         spacing: 2,
                    //         runSpacing: 5,
                    //         itemCount: 5,
                    //         direction: Axis.horizontal,
                    //         itemBuilder: (context, index) {
                    //           return const RatingWidget(
                    //             selectedColor: orange2,
                    //             unSelectedColor: white1,
                    //             child: Icon(
                    //               Icons.star,
                    //               size: 30,
                    //             ),
                    //           );
                    //         },
                    //         onChanged: (value) {},
                    //       )
                    //     ],
                    //   ),
                    // ),
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

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required int value,
    Color? labelColor,
  }) {
    return Container(
      width: 112,
      height: 108,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: white3,
        border: Border.all(color: black1),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 28,
                color: const Color.fromARGB(255, 129, 129, 129),
              ),
              const SizedBox(width: 5),
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
