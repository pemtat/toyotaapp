import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_controller.dart';
import 'package:toyotamobile/Screen/JobDetail/jobdetail_view.dart';
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
              title: Text('Calendar', style: TextStyleList.title1),
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
                todayDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isNotEmpty && !isSameDay(day, DateTime.now())) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style:
                              const TextStyle().copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (events.isNotEmpty &&
                      isSameDay(day, DateTime.now())) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style:
                              const TextStyle().copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
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
                                    Get.to(() => JobDetailView(
                                          ticketId: event['ticketid'],
                                        ));
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
