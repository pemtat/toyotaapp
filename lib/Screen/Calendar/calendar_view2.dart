import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Screen/Calendar/calendar_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/Calendar_widget/fullcalendar_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class CalendarView2 extends StatelessWidget {
  final CalendarController calendarController = Get.put(CalendarController());
  CalendarView2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              backgroundColor: white3,
              automaticallyImplyLeading: false,
              title: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Calendar', style: TextStyleList.title1),
                      5.wH,
                      const Icon(Icons.calendar_today),
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
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: CellCalendar(
            events: _mapEvents(calendarController.events),
            daysOfTheWeekBuilder: (dayIndex) {
              final labels = ["S", "M", "T", "W", "T", "F", "S"];
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  labels[dayIndex],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
            monthYearLabelBuilder: (datetime) {
              final year = datetime!.year.toString();
              final month = _getMonthName(datetime.month);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Text("$month $year", style: TextStyleList.title2),
                    // const Spacer(),
                    // IconButton(
                    //   padding: EdgeInsets.zero,
                    //   icon: const Icon(Icons.calendar_today),
                    //   onPressed: () {
                    //     calendarController.cellCalendarPageController
                    //         .animateToDate(
                    //       DateTime.now(),
                    //       curve: Curves.linear,
                    //       duration: const Duration(milliseconds: 300),
                    //     );
                    //   },
                    // )
                  ],
                ),
              );
            },
            onCellTapped: (day) {
              final eventsOnTheDate = calendarController.getEventsForDay2(day);
              final selectedDay = day;
              final isToday = isSameDay(selectedDay, DateTime.now());
              final formattedDate =
                  calendarController.formatDateTime(selectedDay);
              final displayDate =
                  isToday ? 'Today, $formattedDate' : formattedDate;
              Get.to(() => FullCalendarWidget(
                  eventsOnTheDate: eventsOnTheDate,
                  expandedIndex: calendarController.expandedIndex,
                  displayDate: displayDate,
                  expandedTicketId: calendarController.expandedTicketId));
            },
            onPageChanged: (firstDate, lastDate) {},
          ),
        ),
      ),
    );
  }

  List<CalendarEvent> _mapEvents(
      RxMap<DateTime, List<Map<String, dynamic>>> rxEvents) {
    List<CalendarEvent> events = [];

    rxEvents.forEach((key, value) {
      for (var eventData in value) {
        events.add(
          CalendarEvent(
              eventName: eventData['task'],
              eventDate: key,
              eventBackgroundColor:
                  eventData['type'] == EventType.Job ? red5 : blue2,
              eventTextStyle: TextStyleList.subtext8),
        );
      }
    });

    return events;
  }

  String _getMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
}
