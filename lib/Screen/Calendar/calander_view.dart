import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_controller.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/arrowIcon_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkstatus.dart';
import 'package:toyotamobile/Widget/checkstatus_widget.dart';
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
          ],
        ),
      ),
      body: Column(
        children: [
          Obx(() {
            return TableCalendar(
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
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      top: 5,
                      right: 0,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
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
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: Decoration1(
                                    sideBorderColor:
                                        event['status'] == 'Pending'
                                            ? orange1
                                            : green1,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              Text(
                                                event['time'],
                                                style: TextStyleList.text2,
                                              ),
                                              4.kH,
                                              StatusButton(
                                                  status: event['status']),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                  width: 1, color: white1),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Ticket ID : ${event['ticketid']}',
                                                    style: TextStyleList.text16,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  const Spacer(),
                                                  Obx(
                                                    () => IconButton(
                                                      icon: calendarController
                                                              .expandedIndex
                                                              .value
                                                          ? const ArrowUp()
                                                          : const ArrowDown(),
                                                      onPressed: () {
                                                        calendarController
                                                                .expandedIndex
                                                                .value =
                                                            !calendarController
                                                                .expandedIndex
                                                                .value;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                event['task'],
                                                style: TextStyleList.text15,
                                              ),
                                              const SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  const Icon(Icons
                                                      .location_on_outlined),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    event['location'],
                                                    style:
                                                        TextStyleList.subtext1,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Row(
                                                    children: [
                                                      GoogleMapButton(
                                                        onTap: () {},
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Obx(
                                                () => calendarController
                                                        .expandedIndex.value
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 0.5,
                                                              color: const Color(
                                                                  0xFFEAEAEA),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Text(
                                                              'Ticket ID #${event['ticketid']}',
                                                              style:
                                                                  TextStyleList
                                                                      .text16,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              event['task'],
                                                              style:
                                                                  TextStyleList
                                                                      .text15,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  Decoration2(),
                                                              child:
                                                                  const Column(
                                                                children: [
                                                                  BoxInfo(
                                                                    title:
                                                                        "Name/Model",
                                                                    value:
                                                                        "UBRE200H2-TH-7500",
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          3),
                                                                  BoxInfo(
                                                                    title:
                                                                        "Serial Number",
                                                                    value:
                                                                        "6963131",
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          3),
                                                                  BoxInfo(
                                                                    title:
                                                                        "Warranty Status",
                                                                    value: '',
                                                                    trailing:
                                                                        CheckStatus(
                                                                      status: 1,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
