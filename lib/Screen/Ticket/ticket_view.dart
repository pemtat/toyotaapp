import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/SubTicket/subticket_view.dart';
import 'package:toyotamobile/Screen/Ticket/ticket_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Ticket_widget/ticket_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class TicketView extends StatelessWidget {
  final HomeController jobController = Get.put(HomeController());
  final TicketController ticketController = Get.put(TicketController());

  TicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(preferredSize),
          child: Column(
            children: [
              AppBar(
                backgroundColor: white3,
                title: Text('Incoming Ticket', style: TextStyleList.title1),
              ),
              Container(
                height: 0.5,
                color: white1,
              ),
              const AppDivider()
            ],
          ),
        ),
        body: Column(
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
                      controller: ticketController.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by ticket ID or title',
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
                        ticketController.searchQuery.value = value;
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
                                          ticketController.clearFilters();
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
                                      ticketController.selectedDate.value =
                                          pickedDate;
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextField(
                                      controller: TextEditingController(
                                        text: ticketController
                                                    .selectedDate.value !=
                                                null
                                            ? "${ticketController.selectedDate.value!.day}/${ticketController.selectedDate.value!.month}/${ticketController.selectedDate.value!.year}"
                                            : '',
                                      ),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "Select date",
                                        hintStyle: TextStyleList.text5,
                                        suffixIcon:
                                            const Icon(Icons.calendar_today),
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
            16.kH,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        ticketController.isSelected.value = false;
                      },
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              color: !ticketController.isSelected.value
                                  ? white2
                                  : white3,
                              border: const Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 102, 101, 101),
                                ),
                              ),
                              borderRadius: const BorderRadius.only(),
                            ),
                            child: Text(
                              'PM',
                              style: TextStyleList.text6,
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        ticketController.isSelected.value = true;
                      },
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              color: ticketController.isSelected.value
                                  ? white2
                                  : white3,
                              border: const Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 102, 101, 101),
                                ),
                              ),
                              borderRadius: const BorderRadius.only(),
                            ),
                            child: Text(
                              'Ticket',
                              style: TextStyleList.text6,
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (!ticketController.isSelected.value) {
                return Padding(
                  padding: const EdgeInsets.all(paddingApp),
                  child: Column(
                    children: [
                      Text(
                        'No Data',
                        style: TextStyleList.subtext4,
                      ),
                    ],
                  ),
                );
              } else if (ticketController.isSelected.value) {
                return Expanded(
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
                            final filteredJobs =
                                jobController.jobList.where((job) {
                              final jobDate = job.date;
                              final searchQueryMatch = job.jobid.contains(
                                      ticketController.searchQuery.value) ||
                                  job.description.contains(
                                      ticketController.searchQuery.value);
                              final statusMatch =
                                  ticketController.selectedStatus.isEmpty ||
                                      ticketController.selectedStatus
                                          .contains(job.status);
                              final dateMatch =
                                  ticketController.selectedDate.value == null ||
                                      (jobDate.year ==
                                              ticketController
                                                  .selectedDate.value!.year &&
                                          jobDate.month ==
                                              ticketController
                                                  .selectedDate.value!.month &&
                                          jobDate.day ==
                                              ticketController
                                                  .selectedDate.value!.day);
                              return searchQueryMatch &&
                                  statusMatch &&
                                  dateMatch;
                            }).toList();
                            filteredJobs
                                .sort((a, b) => b.date.compareTo(a.date));

                            if (filteredJobs.isEmpty) {
                              return Center(
                                  child: Text(
                                'No new jobs available.',
                                style: TextStyleList.subtitle2,
                              ));
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredJobs.length,
                              itemBuilder: (context, index) {
                                Home job = filteredJobs[index];
                                return InkWell(
                                  onTap: () {
                                    Get.to(() =>
                                        SubTicketView(ticketId: job.jobid));
                                  },
                                  child: JobItemTicket(
                                    job: job,
                                    expandedIndex:
                                        ticketController.expandedIndex,
                                    jobController: jobController,
                                    status: job.status,
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
            10.kH,
          ],
        ),
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
      final isSelected = ticketController.selectedStatus.contains(status);
      return Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              if (value != null && value) {
                ticketController.selectedStatus.add(status);
              } else {
                ticketController.selectedStatus.remove(status);
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
