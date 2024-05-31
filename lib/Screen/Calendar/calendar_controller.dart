import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';

class CalendarController extends GetxController {
  var calendarFormat = CalendarFormat.month.obs;
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var expandedIndex = false.obs;

  final Map<DateTime, List<Map<String, dynamic>>> events = {
    DateTime.utc(2024, 5, 10): [
      {
        "ticketid": "123456",
        "time": "04:00PM",
        "status": "pending",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      },
      {
        "ticketid": "32356",
        "time": "04:00PM",
        "status": "ongoing",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      },
      {
        "time": "123456",
        "status": "ongoing",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      },
      {
        "time": "123456",
        "status": "ongoing",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      },
      {
        "time": "123456",
        "status": "ongoing",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      }
    ],
    DateTime.utc(2024, 5, 19): [
      {
        "ticketid": "552356",
        "time": "04:00PM",
        "status": "pending",
        "task": "Check car",
        "location": "Bangkok, Thailand"
      },
      {
        "ticketid": "32356",
        "time": "04:00PM",
        "status": "ongoing",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      },
      {
        "time": "123456",
        "status": "ongoing",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      },
      {
        "time": "123456",
        "status": "ongoing",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      },
      {
        "time": "123456",
        "status": "ongoing",
        "task":
            "Machine doesn't work at all. Petrol is leaking from the machine.",
        "location": "Bangkok, Thailand"
      }
    ],
  };
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  List<Map<String, dynamic>> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}
