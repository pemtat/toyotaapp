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
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class CalendarView2 extends StatelessWidget {
  final String? other;
  final CalendarController calendarController = Get.put(CalendarController());
  CalendarView2({super.key, this.other});

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
              title: other == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text('Calendar', style: TextStyleList.title1),
                        // 5.wH,
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.calendar_month)),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CloseIcon())
                      ],
                    ),
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
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: black4,
            ))),
            child: CellCalendar(
              todayMarkColor: Colors.blue,
              dateTextStyle: TextStyleList.text2,
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
                    ],
                  ),
                );
              },
              onCellTapped: (day) {
                final eventsOnTheDate =
                    calendarController.getEventsForDay2(day);
                final selectedDay = day;
                final isToday = isSameDay(selectedDay, DateTime.now());
                final formattedDate =
                    calendarController.formatDateTime(selectedDay);
                final displayDate = isToday
                    ? '${context.tr('today')}, $formattedDate'
                    : formattedDate;
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
              eventName: eventData['type'] == EventType.Job
                  ? eventData['customerName']
                  : eventData['customerName']?.replaceAll("บริษัท", ""),
              eventDate: key,
              eventBackgroundColor: eventData['status'] != 'closed' &&
                      DateTime.parse(eventData['date']).isBefore(DateTime.now())
                  ? red1
                  : eventData['status'] == 'pending'
                      ? white2
                      : eventData['status'] == 'confirmed'
                          ? blue4
                          : eventData['status'] == 'closed'
                              ? green4
                              : red1,
              eventTextStyle: eventData['status'] != 'closed' &&
                      DateTime.parse(eventData['date']).isBefore(DateTime.now())
                  ? TextStyleList.detailtext2
                  : eventData['status'] == 'pending'
                      ? TextStyleList.detailtext3
                      : TextStyleList.detailtext2),
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
