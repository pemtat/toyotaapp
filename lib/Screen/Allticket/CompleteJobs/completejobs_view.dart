import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Allticket/CompleteJobs/completejobs_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Widget/Home_widget/home_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
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
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingApp, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: completeJobsController.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by Ticket ID or title',
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
                            vertical: 10.0, horizontal: 20.0),
                      ),
                      onChanged: (value) {
                        completeJobsController.searchQuery.value = value;
                      },
                    ),
                  ),
                  8.wH,
                  InkWell(
                    onTap: () {},
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        popupMenuTheme: const PopupMenuThemeData(
                          color: white3,
                        ),
                      ),
                      child: PopupMenuButton(
                        offset: const Offset(0, 60),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            value: 'edit',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Status',
                                      style: TextStyleList.text2,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          completeJobsController.clearFilters();
                                        },
                                        child: Text(
                                          'reset',
                                          style: TextStyleList.subtext3,
                                        )),
                                  ],
                                ),
                                ...statusCheckboxes(),
                                8.kH,
                                const AppDivider(),
                                8.kH,
                                Text(
                                  'Date',
                                  style: TextStyleList.text2,
                                ),
                                8.kH,
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      completeJobsController
                                          .selectedDate.value = pickedDate;
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: Obx(() => TextField(
                                          controller: TextEditingController(
                                            text: completeJobsController
                                                        .selectedDate.value !=
                                                    null
                                                ? "${completeJobsController.selectedDate.value!.day}/${completeJobsController.selectedDate.value!.month}/${completeJobsController.selectedDate.value!.year}"
                                                : '',
                                          ),
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: "Select date",
                                            hintStyle: TextStyleList.text5,
                                            suffixIcon: const Icon(
                                                Icons.calendar_today),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                8.kH,
                              ],
                            ),
                          ),
                        ],
                        child: Stack(
                          children: [
                            Container(
                              decoration: Decoration2(),
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.all(10),
                              child: Image.asset('assets/sliders.png'),
                            ),
                          ],
                        ),
                        onSelected: (value) {
                          if (value == 'edit') {}
                        },
                      ),
                    ),
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
