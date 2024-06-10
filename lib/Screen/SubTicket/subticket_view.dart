import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/SubJobs_widget/subjobs_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class SubTicketView extends StatelessWidget {
  final String ticketId;
  final HomeController jobController = Get.put(HomeController());
  final SubTicketController subticketController =
      Get.put(SubTicketController());

  SubTicketView({super.key, required this.ticketId}) {
    subticketController.fetchData(ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              backgroundColor: white3,
              title: Text('Jobs', style: TextStyleList.title1),
            ),
            Container(
              height: 0.5,
              color: white1,
            ),
            const AppDivider()
          ],
        ),
      ),
      body: Obx(
        () {
          if (subticketController.subJobs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.kH,
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingApp, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: subticketController.searchController,
                          decoration: InputDecoration(
                            hintText: 'Search by Jobs ID or title',
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
                            subticketController.searchQuery.value = value;
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
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry>[
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
                                              subticketController
                                                  .clearFilters();
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
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );
                                        if (pickedDate != null) {
                                          subticketController
                                              .selectedDate.value = pickedDate;
                                        }
                                      },
                                      child: AbsorbPointer(
                                        child: TextField(
                                          controller: TextEditingController(
                                            text: subticketController
                                                        .selectedDate.value !=
                                                    null
                                                ? "${subticketController.selectedDate.value!.day}/${subticketController.selectedDate.value!.month}/${subticketController.selectedDate.value!.year}"
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
                                        ),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(paddingApp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today',
                          style: TextStyleList.subtext4,
                        ),
                        5.kH,
                        Expanded(
                          child: Obx(() {
                            if (subticketController.subJobs.isEmpty) {
                              return Center(
                                  child: Text(
                                'No new jobs available.',
                                style: TextStyleList.subtitle2,
                              ));
                            }
                            final filteredJobs =
                                subticketController.subJobs.where((job) {
                              final query = subticketController
                                  .searchQuery.value
                                  .toLowerCase();
                              final searchQueryMatch =
                                  job.id!.contains(query) ||
                                      job.summary!.contains(query);
                              // final statusMatch =
                              //     subticketController.selectedStatus.isEmpty ||
                              //         subticketController.selectedStatus
                              //             .contains(job.status?.name);
                              return searchQueryMatch;
                            }).toList();

                            if (filteredJobs.isEmpty) {
                              return Center(
                                child: Text(
                                  'No jobs match the search',
                                  style: TextStyleList.subtitle2,
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: subticketController.subJobs.length,
                              itemBuilder: (context, index) {
                                final job = subticketController.subJobs[index];
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => JobDetailView(
                                        ticketId: ticketId,
                                        jobId: job.id ?? ''));
                                  },
                                  child: SubJobsTicket(
                                      job: job,
                                      expandedIndex:
                                          subticketController.expandedIndex,
                                      jobController: subticketController,
                                      status: 'assigned'),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                10.kH,
              ],
            );
          }
        },
      ),
    );
  }

  List<Widget> statusCheckboxes() {
    return [
      buildCheckbox('assigned'),
      buildCheckbox('new'),
      buildCheckbox('closed'),
      buildCheckbox('feedback'),
    ];
  }

  Widget buildCheckbox(String status) {
    return Obx(() {
      final isSelected = subticketController.selectedStatus.contains(status);
      return Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              if (value != null && value) {
                subticketController.selectedStatus.add(status);
              } else {
                subticketController.selectedStatus.remove(status);
              }
            },
          ),
          Text(
            status.capitalizeFirst!,
            style: isSelected ? TextStyleList.text9 : null,
          ),
        ],
      );
    });
  }
}
