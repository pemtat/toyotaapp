import 'package:flutter/widgets.dart';
import 'package:toyotamobile/Screen/Allticket/CompleteJobs/completejobs_view.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Allticket/NewJobs/newjobs_view.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/titleheader_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/statusbutton_widget.dart';
import 'package:toyotamobile/Widget/jobstatus_widget.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final BottomBarController bottomController = Get.put(BottomBarController());
  final RxInt expandedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Column(
            children: [
              AppBar(
                backgroundColor: buttontextcolor,
                title: Text('My Jobs', style: TextStyleList.topbar),
              ),
              Container(
                height: 0.5,
                color: border,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(PaddingApp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    JobStatusItem(
                      count: '2',
                      title: 'Incoming Jobs',
                      countColor: Color(0xffEB0A1E),
                      titleColor: Color(0xff434343),
                      containerColor: Color.fromARGB(255, 242, 194, 198),
                      imagePath: 'assets/propjob.png',
                      flexValue: 6,
                      center: false,
                    ),
                    10.wH,
                    JobStatusItem(
                      count: '1',
                      title: 'Completed Jobs',
                      countColor: Color(0xff323232),
                      titleColor: Color(0xff434343),
                      containerColor: Color(0xffEAEAEA),
                      flexValue: 4,
                      center: true,
                    ),
                    5.wH,
                  ],
                ),
              ),
              10.kH,
              AppDivider(),
              10.kH,
              JobTitle(
                headerText: 'Incoming Jobs',
                buttonText: 'View All',
                buttonOnPressed: () {
                  Get.to(() => NewJobsView());
                },
              ),
              Padding(
                padding: EdgeInsets.all(PaddingApp),
                child: Obx(() {
                  final job = jobController.mostRecentNewJob.value;
                  if (job == null) {
                    return Center(
                      child: Text('No new jobs available.'),
                    );
                  }

                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: CustomBoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'JobID : ${job.jobid}',
                              style: TextStyleList.detail1,
                            ),
                            10.wH,
                            StatusNewButton(),
                            Spacer(),
                            Obx(
                              () => IconButton(
                                icon: expandedIndex.value ==
                                        jobController.jobList.indexOf(job)
                                    ? Image.asset('assets/arrowup.png')
                                    : Image.asset('assets/arrowdown.png'),
                                onPressed: () {
                                  if (expandedIndex.value ==
                                      jobController.jobList.indexOf(job)) {
                                    expandedIndex.value = -1;
                                  } else {
                                    expandedIndex.value =
                                        jobController.jobList.indexOf(job);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          job.detail,
                          style: TextStyleList.detail2,
                        ),
                        5.kH,
                        Row(
                          children: [
                            Icon(Icons.calendar_month_outlined),
                            5.wH,
                            Text(
                              job.getFormattedDate(),
                              style: TextStyleList.detail3,
                            ),
                          ],
                        ),
                        5.kH,
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            5.wH,
                            Text(
                              job.location,
                              style: TextStyleList.detail3,
                            ),
                            5.wH,
                            Row(
                              children: [
                                GoogleMapButton(
                                  onTap: () {},
                                )
                              ],
                            ),
                          ],
                        ),
                        10.kH,
                        Obx(() => expandedIndex.value ==
                                jobController.jobList.indexOf(job)
                            ? Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 0.5,
                                      color: Color(0xFFEAEAEA),
                                    ),
                                    10.kH,
                                    Text('Ticket ID #${job.ticketid}',
                                        style: TextStyleList.detail1),
                                    5.kH,
                                    Text(
                                      job.problem,
                                      style: TextStyleList.detail2,
                                    ),
                                    5.kH,
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: Decoration2(),
                                        child: Column(
                                          children: [
                                            WarrantyInfo(
                                              title: "Name/Model",
                                              value: "UBRE200H2-TH-7500",
                                            ),
                                            3.kH,
                                            WarrantyInfo(
                                              title: "Serial Number",
                                              value: "6963131",
                                            ),
                                            3.kH,
                                            WarrantyInfo(
                                              title: "Warranty Status",
                                              value: '',
                                              trailing: CheckStatus(
                                                imagePath: 'assets/pass.png',
                                                text: 'Active',
                                                textColor: pass,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              )
                            : SizedBox())
                      ],
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
                padding: EdgeInsets.all(PaddingApp),
                child: Obx(() {
                  final job = jobController.mostRecentCompleteJob.value;
                  if (job == null) {
                    return Center(
                      child: Text('No new jobs available.'),
                    );
                  }

                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: CustomBoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'JobID : ${job.jobid}',
                              style: TextStyleList.detail1,
                            ),
                            10.wH,
                            StatusCompletedButton(),
                            Spacer(),
                            Obx(
                              () => IconButton(
                                icon: expandedIndex.value ==
                                        jobController.jobList.indexOf(job)
                                    ? Image.asset('assets/arrowup.png')
                                    : Image.asset('assets/arrowdown.png'),
                                onPressed: () {
                                  if (expandedIndex.value ==
                                      jobController.jobList.indexOf(job)) {
                                    expandedIndex.value = -1;
                                  } else {
                                    expandedIndex.value =
                                        jobController.jobList.indexOf(job);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          job.detail,
                          style: TextStyleList.detail2,
                        ),
                        5.kH,
                        Row(
                          children: [
                            Icon(Icons.calendar_month_outlined),
                            5.wH,
                            Text(
                              job.getFormattedDate(),
                              style: TextStyleList.detail3,
                            ),
                          ],
                        ),
                        5.kH,
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            5.wH,
                            Text(
                              job.location,
                              style: TextStyleList.detail3,
                            ),
                            5.wH,
                            Row(
                              children: [
                                GoogleMapButton(
                                  onTap: () {},
                                )
                              ],
                            ),
                          ],
                        ),
                        10.kH,
                        Obx(() => expandedIndex.value ==
                                jobController.jobList.indexOf(job)
                            ? Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 0.5,
                                      color: Color(0xFFEAEAEA),
                                    ),
                                    10.kH,
                                    Text('Ticket ID #${job.ticketid}',
                                        style: TextStyleList.detail1),
                                    5.kH,
                                    Text(
                                      job.problem,
                                      style: TextStyleList.detail2,
                                    ),
                                    5.kH,
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: Decoration2(),
                                        child: Column(
                                          children: [
                                            WarrantyInfo(
                                              title: "Name/Model",
                                              value: "UBRE200H2-TH-7500",
                                            ),
                                            3.kH,
                                            WarrantyInfo(
                                              title: "Serial Number",
                                              value: "6963131",
                                            ),
                                            3.kH,
                                            WarrantyInfo(
                                              title: "Warranty Status",
                                              value: '',
                                              trailing: CheckStatus(
                                                imagePath: 'assets/pass.png',
                                                text: 'Active',
                                                textColor: pass,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              )
                            : SizedBox())
                      ],
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
