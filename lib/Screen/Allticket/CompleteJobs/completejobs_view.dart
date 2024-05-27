import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/Home_widget/home_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/titleheader_widget.dart';
import 'package:toyotamobile/Widget/statusbutton_widget.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteJobsView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final BottomBarController bottomController = Get.put(BottomBarController());
  final RxInt expandedIndex = (-1).obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  CompleteJobsView({super.key});

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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: paddingApp),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by job ID or title',
                        hintStyle: TextStyleList.detail1,
                        filled: true,
                        fillColor: black5,
                        prefixIcon: const Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: white2,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
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
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(0),
                        child: IconButton(
                          icon: Image.asset('assets/sliders.png'),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: const Text(
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
              headerText: 'Complete Jobs',
              buttonText: '',
              buttonOnPressed: () {},
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(paddingApp),
                child: Obx(() {
                  final filteredJobs = jobController.jobList
                      .where((job) =>
                          job.status == 'closed' &&
                          (job.jobid.contains(searchQuery.value) ||
                              job.description.contains(searchQuery.value)))
                      .toList();
                  if (filteredJobs.isEmpty) {
                    return const Center(child: Text('No new jobs available.'));
                  }
                  return ListView.builder(
                    itemCount: filteredJobs.length,
                    itemBuilder: (context, index) {
                      Home job = filteredJobs[index];
                      return InkWell(
                          onTap: () {
                            Get.to(() => TicketDetailPage());
                          },
                          child: JobItemWidget(
                            job: job,
                            expandedIndex: expandedIndex,
                            jobController: jobController,
                            statusButton: const StatusCompletedButton(),
                            sidebar: black6,
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
}
