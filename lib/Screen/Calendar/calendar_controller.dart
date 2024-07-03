import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Models/getsubjobassigned_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';

enum EventType {
  Job,
  PM,
}

class CalendarController extends GetxController {
  var calendarFormat = CalendarFormat.month.obs;
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  final RxInt expandedIndex2 = (-2).obs;
  var expandedIndex = false.obs;
  Rx<String> expandedTicketId = Rx<String>('');
  final HomeController jobController = Get.put(HomeController());
  final RxMap<DateTime, List<Map<String, dynamic>>> events =
      <DateTime, List<Map<String, dynamic>>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    jobController.subJobAssigned.listen((_) {
      updateEvents();
    });
    jobController.pmItems.listen((_) {
      updateEvents();
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  void updateEvents() async {
    final tempEvents = <DateTime, List<Map<String, dynamic>>>{};

    await Future.wait([
      updateEventsFromJobs(jobController.subJobAssigned, tempEvents),
      updateEventsFromPM(jobController.pmItems, tempEvents),
    ]);

    events.value = tempEvents;
  }

  Future<void> updateEventsFromPM(List<PmModel> pmList,
      Map<DateTime, List<Map<String, dynamic>>> tempEvents) async {
    var pmListCopy = List<PmModel>.from(pmList);

    for (var pm in pmListCopy) {
      try {
        final pmDate = formatDateTimeString(pm.dueDate ?? '');
        final dayKey = DateTime.utc(pmDate.year, pmDate.month, pmDate.day);
        final timeParts = pmDate.toLocal().toString().split(' ')[1].split(':');
        final hour = int.parse(timeParts[0]);

        String period = 'AM';
        if (hour >= 12) {
          period = 'PM';
        }
        final formattedHour = hour > 12 ? hour - 12 : hour;
        final formattedTime = '$formattedHour:${timeParts[1]} $period';

        final eventData = {
          "jobid": pm.id,
          "bugid": '',
          "time": formattedTime,
          "status": stringToStatus(pm.status ?? ''),
          "task": pm.dueDate,
          "description": pm.description,
          "location": pm.serviceZoneCode,
          "serialNo": pm.serialNo,
          "type": EventType.PM,
        };

        bool isDuplicate = tempEvents[dayKey]?.any((event) =>
                event['ticketid'] == pm.id && event['type'] == EventType.PM) ??
            false;

        if (!isDuplicate) {
          if (tempEvents.containsKey(dayKey)) {
            tempEvents[dayKey]!.add(eventData);
            tempEvents[dayKey]!.sort((a, b) => a['time'].compareTo(b['time']));
          } else {
            tempEvents[dayKey] = [eventData];
          }
        }
      } catch (e) {
        print('Error processing PM event: $e');
      }
    }
  }

  Future<void> updateEventsFromJobs(List<SubJobAssgined> jobList,
      Map<DateTime, List<Map<String, dynamic>>> tempEvents) async {
    var jobListCopy = List<SubJobAssgined>.from(jobList);

    for (var job in jobListCopy) {
      try {
        final jobDate = formatDateTimeString(job.dueDate ?? '');

        final dayKey = DateTime.utc(jobDate.year, jobDate.month, jobDate.day);
        final timeParts = jobDate.toLocal().toString().split(' ')[1].split(':');
        final hour = int.parse(timeParts[0]);

        String period = 'AM';
        if (hour >= 12) {
          period = 'PM';
        }
        final formattedHour = hour > 12 ? hour - 12 : hour;
        final formattedTime = '$formattedHour:${timeParts[1]} $period';
        // var warrantyInfoList = <WarrantyInfo>[].obs;
        // warrantyInfoList =
        //     await checkWarrantyReturn(job.serialNo ?? '', warrantyInfoList);
        final eventData = {
          "jobid": job.id.toString(),
          "bugid": job.bugId.toString(),
          "time": formattedTime,
          "status": stringToStatus(job.status ?? ''),
          "task": job.description,
          "description": '',
          "location": 'Bangkok',
          "serialNo": 'SOOPSM',
          "type": EventType.Job,
        };

        bool isDuplicate = tempEvents[dayKey]?.any((event) =>
                event['ticketid'] == job.id &&
                event['type'] == EventType.Job) ??
            false;

        if (!isDuplicate) {
          if (tempEvents.containsKey(dayKey)) {
            tempEvents[dayKey]!.add(eventData);
            tempEvents[dayKey]!.sort((a, b) => a['time'].compareTo(b['time']));
          } else {
            tempEvents[dayKey] = [eventData];
          }
        }
      } catch (e) {
        print('Error processing job event: $e');
      }
    }
  }

  List<Map<String, dynamic>> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}
