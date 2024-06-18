import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
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
    jobController.jobList.listen((_) {
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
      updateEventsFromJobs(jobController.jobList, tempEvents),
      updateEventsFromPM(jobController.pmItems, tempEvents),
    ]);

    events.value = tempEvents;
  }

  Future<void> updateEventsFromPM(List<PmModel> pmList,
      Map<DateTime, List<Map<String, dynamic>>> tempEvents) async {
    var pmListCopy = List<PmModel>.from(pmList); // Create a copy of the list

    for (var pm in pmListCopy) {
      try {
        final pmDate = formatDateTimeString(pm.pmPlan ?? '');
        final dayKey = DateTime.utc(pmDate.year, pmDate.month, pmDate.day);
        final timeParts = pmDate.toLocal().toString().split(' ')[1].split(':');
        final hour = int.parse(timeParts[0]);

        String period = 'AM';
        if (hour >= 12) {
          period = 'PM';
        }
        final formattedHour = hour > 12 ? hour - 12 : hour;
        final formattedTime = '$formattedHour:${timeParts[1]} $period';
        var warrantyInfoList = <WarrantyInfo>[].obs;
        warrantyInfoList =
            await checkWarrantyReturn(pm.serialNo ?? '', warrantyInfoList);

        final eventData = {
          "ticketid": pm.jobId,
          "time": formattedTime,
          "status": pm.pmStatus,
          "task": pm.pmPlan,
          "description": pm.description,
          "location": pm.serviceZoneCode,
          "serialNo": pm.serialNo,
          "warrantyStatus": warrantyInfoList.first.warrantyStatus,
          "nameModel": warrantyInfoList.first.model,
          "type": EventType.PM,
        };

        bool isDuplicate = tempEvents[dayKey]?.any((event) =>
                event['ticketid'] == pm.jobId &&
                event['type'] == EventType.PM) ??
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

  Future<void> updateEventsFromJobs(List<Issues> jobList,
      Map<DateTime, List<Map<String, dynamic>>> tempEvents) async {
    var jobListCopy = List<Issues>.from(jobList);

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
        var warrantyInfoList = <WarrantyInfo>[].obs;
        warrantyInfoList =
            await checkWarrantyReturn(job.serialNo ?? '', warrantyInfoList);

        final eventData = {
          "ticketid": job.id.toString(),
          "time": formattedTime,
          "status": job.status!.name,
          "task": job.summary,
          "description": job.description,
          "location": job.location,
          "serialNo": warrantyInfoList.first.serial,
          "warrantyStatus": warrantyInfoList.first.warrantyStatus,
          "nameModel": warrantyInfoList.first.model,
          "type": EventType.Job,
        };

        bool isDuplicate = tempEvents[dayKey]?.any((event) =>
                event['ticketid'] == job.id.toString() &&
                event['time'] == formattedTime &&
                event['status'] == job.status!.name &&
                event['task'] == job.summary &&
                event['description'] == job.description &&
                event['location'] == job.location &&
                event['serialNo'] == warrantyInfoList.first.serial &&
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
