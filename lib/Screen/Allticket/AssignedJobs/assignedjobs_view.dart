import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Allticket/AssignedJobs/assignedjobs_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
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

class AssignedjobsNew extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final AssignedjobsController assignedController =
      Get.put(AssignedjobsController());

  AssignedjobsNew({super.key});

  @override
  Widget build(BuildContext context) {
    BottomBarView();
    // ignore: deprecated_member_use
    return Scaffold(
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
                    controller: assignedController.searchController,
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
                      assignedController.searchQuery.value = value;
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
            headerText: 'Incoming Jobs',
            buttonText: '',
            buttonOnPressed: () {},
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(paddingApp),
              child: Obx(() {
                final filteredJobs = jobController.jobList
                    .where((job) =>
                        job.status != 'closed' &&
                        (job.jobid.contains(
                                assignedController.searchQuery.value) ||
                            job.description.contains(
                                assignedController.searchQuery.value)))
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
                        Get.to(() => JobDetailView(
                              ticketId: job.jobid,
                            ));
                      },
                      child: JobItemWidget(
                        job: job,
                        expandedIndex: assignedController.expandedIndex,
                        jobController: jobController,
                        statusButton: const StatusAssignedButton(),
                        sidebar: orange1,
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
}
