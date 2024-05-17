import 'package:flutter/widgets.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/titleheader_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/statusbutton_widget.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/warranty_widget.dart';

class AllTicketView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final BottomBarController bottomController = Get.put(BottomBarController());
  final RxInt expandedIndex = (-1).obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

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
                leading: BackIcon(),
              ),
              Container(
                height: 0.5,
                color: border,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            15.kH,
            Container(
              padding: EdgeInsets.symmetric(horizontal: PaddingApp),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by job ID or title',
                        hintStyle: TextStyleList.detail5,
                        filled: true,
                        fillColor: search,
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: border2,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 19.0),
                      ),
                      onChanged: (value) {
                        searchQuery.value = value;
                      },
                    ),
                  ),
                  8.wH,
                  Stack(
                    children: [
                      Container(
                        decoration: Decoration2(),
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                          icon: Image.asset('assets/sliders.png'),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            10.kH,
            JobTitle(
              headerText: 'Incoming Jobs',
              buttonText: '',
              buttonOnPressed: () {},
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(PaddingApp),
                child: Obx(() {
                  final filteredJobs = jobController.jobList
                      .where((job) =>
                          job.jobid.contains(searchQuery.value) ||
                          job.detail.contains(searchQuery.value))
                      .toList();

                  return ListView.builder(
                    itemCount: filteredJobs.length,
                    itemBuilder: (context, index) {
                      Home job = filteredJobs[index];
                      if (job.status == 'New') {
                        return InkWell(
                          onTap: () {
                            Get.to(() => TicketDetailPage());
                          },
                          child: Container(
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
                                        icon: expandedIndex.value == index
                                            ? Image.asset('assets/arrowup.png')
                                            : Image.asset(
                                                'assets/arrowdown.png'),
                                        onPressed: () {
                                          if (expandedIndex.value == index) {
                                            expandedIndex.value = -1;
                                          } else {
                                            expandedIndex.value = index;
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  job.detail,
                                  style: TextStyleList.detail2,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_month_outlined),
                                    5.wH,
                                    Text(
                                      job.date,
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
                                Obx(() => expandedIndex.value == index
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 0.5,
                                              color: Color(0xFFEAEAEA),
                                            ),
                                            10.kH,
                                            Text(
                                              'Ticket ID #${job.ticketid}',
                                              style: TextStyleList.detail1,
                                            ),
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
                                                      imagePath:
                                                          'assets/pass.png',
                                                      text: 'Active',
                                                      textColor: pass,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container())
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
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
}
