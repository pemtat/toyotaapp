import 'package:cell_calendar/cell_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Function/stringtostatus.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/getsubjobassigned_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Models/userinfobyid_model.dart';
import 'package:toyotamobile/Models/warrantytruckbyid.dart';
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
  final RxMap<DateTime, List<Map<String, dynamic>>> events2 =
      <DateTime, List<Map<String, dynamic>>>{}.obs;

  final CellCalendarPageController cellCalendarPageController =
      CellCalendarPageController(); // Define the controller here
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
    final tempEvents2 = <DateTime, List<Map<String, dynamic>>>{};

    await Future.wait([
      updateEventsFromJobs(
          jobController.subJobAssigned, tempEvents, tempEvents2),
      updateEventsFromPM(jobController.pmItems, tempEvents, tempEvents2),
    ]);

    events.value = tempEvents;
    events2.value = tempEvents2;
  }

  Future<void> updateEventsFromPM(
      List<PmModel> pmList,
      Map<DateTime, List<Map<String, dynamic>>> tempEvents,
      Map<DateTime, List<Map<String, dynamic>>> tempEvents2) async {
    var pmListCopy = List<PmModel>.from(pmList);

    for (var pm in pmListCopy) {
      try {
        final pmDate = formatDateTimeString(pm.dueDate ?? '');
        final dayKey = DateTime.utc(pmDate.year, pmDate.month, pmDate.day);
        final dayKey2 = DateTime(pmDate.year, pmDate.month, pmDate.day);
        final formattedTime = DateFormat('hh:mm a').format(pmDate);

        final eventData = {
          "jobid": pm.id,
          "bugid": '',
          "time": formattedTime,
          "status": stringToStatus(pm.status ?? ''),
          "task": pm.dueDate,
          "customerName": pm.customerName,
          'warrantyStatus': '',
          "date": formatDateTimeCut(pm.dueDate ?? ''),
          'reporterId': pm.customerNo,
          "description": pm.description,
          "location": 'Service Zone ${pm.serviceZoneCode}',
          "serialNo": pm.serialNo,
          "type": EventType.PM,
        };

        bool isDuplicate = tempEvents[dayKey]?.any((event) =>
                event['jobid'] == pm.id && event['type'] == EventType.PM) ??
            false;

        if (!isDuplicate) {
          if (tempEvents.containsKey(dayKey)) {
            tempEvents[dayKey]!.add(eventData);
            tempEvents[dayKey]!.sort((a, b) => a['time'].compareTo(b['time']));
          } else {
            tempEvents[dayKey] = [eventData];
          }
        }

        bool isDuplicate2 = tempEvents2[dayKey2]?.any((event) =>
                event['jobid'] == pm.id && event['type'] == EventType.PM) ??
            false;

        if (!isDuplicate2) {
          if (tempEvents2.containsKey(dayKey2)) {
            tempEvents2[dayKey2]!.add(eventData);
            tempEvents2[dayKey2]!
                .sort((a, b) => a['time'].compareTo(b['time']));
          } else {
            tempEvents2[dayKey2] = [eventData];
          }
        }
      } catch (e) {
        // print('Error processing PM event: $e');
      }
    }
  }

  Future<void> updateEventsFromJobs(
      List<SubJobAssgined> jobList,
      Map<DateTime, List<Map<String, dynamic>>> tempEvents,
      Map<DateTime, List<Map<String, dynamic>>> tempEvents2) async {
    var jobListCopy = List<SubJobAssgined>.from(jobList);

    for (var job in jobListCopy) {
      try {
        final jobDate = formatDateTimeString(job.dueDate ?? '');

        final dayKey = DateTime.utc(jobDate.year, jobDate.month, jobDate.day);
        final dayKey2 = DateTime(jobDate.year, jobDate.month, jobDate.day);

        final formattedTime = DateFormat('hh:mm a').format(jobDate);

        String? token = await getToken();
        var warrantyInfo = <WarrantyTruckbyId>[].obs;

        var userData = <UserById>[].obs;
        await fetchUserById(job.reporterId ?? '', userData);
        await fetchWarrantyById(
            job.bugId.toString(), token ?? '', warrantyInfo);
        var jobDateString = job.dueDate == null ? DateTime.now() : job.dueDate;
        final eventData = {
          "jobid": job.id.toString(),
          "bugid": job.bugId.toString(),
          "time": formattedTime,
          "status": stringToStatus(job.status ?? ''),
          "customerName": userData.first.users!.first.name,
          "task": job.description,
          "date": jobDateString,
          'warrantyStatus': '',
          'reporterId': job.reporterId,
          "description": job.summaryBug,
          "location": 'Bangkok',
          "serialNo": warrantyInfo.first.serialNo,
          "type": EventType.Job,
        };

        bool isDuplicate = tempEvents[dayKey]?.any((event) =>
                event['bugid'] == job.id && event['type'] == EventType.Job) ??
            false;

        if (!isDuplicate) {
          if (tempEvents.containsKey(dayKey)) {
            tempEvents[dayKey]!.add(eventData);
            tempEvents[dayKey]!.sort((a, b) => a['time'].compareTo(b['time']));
          } else {
            tempEvents[dayKey] = [eventData];
          }
        }
        bool isDuplicate2 = tempEvents2[dayKey2]?.any((event) =>
                event['bugid'] == job.id && event['type'] == EventType.Job) ??
            false;

        if (!isDuplicate2) {
          if (tempEvents2.containsKey(dayKey2)) {
            tempEvents2[dayKey2]!.add(eventData);
            tempEvents2[dayKey2]!
                .sort((a, b) => a['time'].compareTo(b['time']));
          } else {
            tempEvents2[dayKey2] = [eventData];
          }
        }
      } catch (e) {
        // print('Error processing job event: $e');
      }
    }
  }

  List<Map<String, dynamic>> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  List<Map<String, dynamic>> getEventsForDay2(DateTime day) {
    return events2[day] ?? [];
  }
}
