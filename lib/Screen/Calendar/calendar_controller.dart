import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';

class CalendarController extends GetxController {
  var calendarFormat = CalendarFormat.month.obs;
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var expandedIndex = false.obs;
  final HomeController jobController = Get.put(HomeController());
  final RxMap<DateTime, List<Map<String, dynamic>>> events =
      <DateTime, List<Map<String, dynamic>>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    ever(jobController.jobList, (_) {
      updateEventsFromJobList(jobController.jobList);
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  void updateEventsFromJobList(List<Home> jobList) {
    events.clear();

    if (jobList.isEmpty) {
    } else {
      for (var home in jobList) {
        try {
          final dayKey =
              DateTime.utc(home.date.year, home.date.month, home.date.day);
          final timeParts =
              home.date.toLocal().toString().split(' ')[1].split(':');
          final hour = int.parse(timeParts[0]);

          String period = 'AM';
          if (hour >= 12) {
            period = 'PM';
          }
          final formattedHour = hour > 12 ? hour - 12 : hour;
          final formattedTime = '$formattedHour:${timeParts[1]} $period';

          final eventData = {
            "ticketid": home.ticketid,
            "time": formattedTime,
            "status": home.status,
            "task": home.summary,
            "description": home.description,
            "location": home.location
          };

          if (events.containsKey(dayKey)) {
            events[dayKey]!.add(eventData);
            events[dayKey]!.sort((a, b) => a['time'].compareTo(b['time']));
          } else {
            events[dayKey] = [eventData];
          }
        } catch (e) {
          print('Error processing event: $e');
        }
      }
    }
  }

  List<Map<String, dynamic>> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}
