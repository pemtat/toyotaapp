import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_view2.dart';
import 'package:toyotamobile/Screen/TicketPMDetail/ticketpmdetail_view.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
import 'package:toyotamobile/Screen/JobDetailPM/jobdetailpm_view.dart';
import 'package:toyotamobile/Screen/PendingTask/pendingtask_view.dart';
import 'package:toyotamobile/Screen/PendingTaskPM/pendingtaskpm_view.dart';
import 'package:toyotamobile/Screen/TicketDetail/ticketdetail_view.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Calendar_widget/calendar_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

// ignore: use_key_in_widget_constructors
class CalendarView extends StatelessWidget {
  final CalendarController calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              backgroundColor: white3,
              title: InkWell(
                  onTap: () {
                    Get.to(
                      () => CalendarView2(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Calendar', style: TextStyleList.title1),
                      5.wH,
                      Icon(Icons.calendar_month),
                    ],
                  )),
            ),
            Container(
              height: 0.5,
              color: white5,
            ),
            const AppDivider()
          ],
        ),
      ),
      body: Column(
        children: [
          Obx(() {
            return TableCalendar(
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyleList.subdetail1,
                  weekendStyle: TextStyleList.subdetail1),
              headerStyle: HeaderStyle(
                  formatButtonTextStyle: TextStyleList.text9,
                  titleTextStyle: TextStyleList.title2,
                  titleCentered: true),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: calendarController.focusedDay.value,
              calendarFormat: calendarController.calendarFormat.value,
              eventLoader: (day) {
                return calendarController.getEventsForDay(day);
              },
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyleList.subtitle2,
                todayDecoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 147, 17),
                  shape: BoxShape.circle,
                  border: calendarController
                          .getEventsForDay(DateTime.now())
                          .isNotEmpty
                      ? const Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 182, 164, 30),
                            width: 3,
                          ),
                        )
                      : null,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(),
              ),
              calendarBuilders:
                  CalendarBuilders(markerBuilder: (context, day, events) {
                if (events is List<Map<String, dynamic>> && events.isNotEmpty) {
                  final jobEvents = events
                      .where((event) => event['type'] == EventType.Job)
                      .toList();
                  final pmEvents = events
                      .where((event) => event['type'] == EventType.PM)
                      .toList();

                  if (jobEvents.isNotEmpty && pmEvents.isNotEmpty) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 251, 98, 3),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                    color: red6, shape: BoxShape.circle),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  if (jobEvents.isNotEmpty &&
                      pmEvents.isNotEmpty &&
                      (isSameDay(day, DateTime.now()))) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 251, 98, 3),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                    color: red6, shape: BoxShape.circle),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  if (jobEvents.isNotEmpty) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: red5,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: red5, shape: BoxShape.circle),
                          ),
                        )
                      ],
                    );
                  }
                  if (pmEvents.isNotEmpty) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: blue2,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: blue2, shape: BoxShape.circle),
                          ),
                        )
                      ],
                    );
                  }

                  return null;
                }
                return null;
              }),
              selectedDayPredicate: (day) {
                return isSameDay(calendarController.selectedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                calendarController.selectedDay.value = selectedDay;
                calendarController.focusedDay.value = focusedDay;
              },
              onFormatChanged: (format) {
                if (calendarController.calendarFormat.value != format) {
                  calendarController.calendarFormat.value = format;
                }
              },
              onPageChanged: (focusedDay) {
                calendarController.focusedDay.value = focusedDay;
              },
            );
          }),
          Obx(() {
            final events = calendarController
                .getEventsForDay(calendarController.selectedDay.value);
            final selectedDay = calendarController.selectedDay.value;
            final isToday = isSameDay(selectedDay, DateTime.now());
            final formattedDate =
                calendarController.formatDateTime(selectedDay);
            final displayDate =
                isToday ? 'Today, $formattedDate' : formattedDate;
            return Expanded(
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: white5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Text(
                          displayDate,
                          style: TextStyleList.subtitle1,
                        ),
                      )),
                  8.kH,
                  events.isEmpty
                      ? Center(
                          child: Text(
                          'No jobs for this day.',
                          style: TextStyleList.subtitle2,
                        ))
                      : Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(paddingApp),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];

                                return InkWell(
                                  onTap: () {
                                    if (event['type'] == EventType.Job) {
                                      if (event['status'] == 'pending') {
                                        Get.to(() => PendingTaskView(
                                            ticketId: event['bugid'] ?? '',
                                            jobId: event['jobid']));
                                      } else if (event['status'] ==
                                          'confirmed') {
                                        Get.to(() => JobDetailView(
                                            ticketId: event['bugid'] ?? '',
                                            jobId: event['jobid']));
                                      } else {
                                        Get.to(() => TicketDetailView(
                                            ticketId: event['bugid'] ?? '',
                                            jobId: event['jobid']));
                                      }
                                    } else {
                                      if (event['status'] == 'pending') {
                                        Get.to(() => PendingTaskViewPM(
                                            ticketId: event['jobid']));
                                      } else if (event['status'] ==
                                          'confirmed') {
                                        Get.to(() => JobDetailViewPM(
                                            ticketId: event['jobid']));
                                      } else {
                                        Get.to(() => TicketPMDetailView(
                                            ticketId: event['jobid']));
                                      }
                                    }
                                  },
                                  child: CalendarItem(
                                    event: event,
                                    expandedIndex:
                                        calendarController.expandedIndex,
                                    expandedTicketId:
                                        calendarController.expandedTicketId,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
