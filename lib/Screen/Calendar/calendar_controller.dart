import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toyotamobile/Function/checkwarranty.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:toyotamobile/Models/pm_model.dart';
import 'package:toyotamobile/Models/warrantyInfo_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';

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
    ever(jobController.jobList, (_) {
      updateEventsFromJobs(jobController.jobList);
    });
    ever(jobController.pmItems, (_) {
      updateEventsFromPM(jobController.pmItems);
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  void updateEventsFromPM(List<PmModel> pmList) async {
    events.clear();

    for (var pm in pmList) {
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
        };

        if (events.containsKey(dayKey)) {
          events[dayKey]!.add(eventData);
          events[dayKey]!.sort((a, b) => a['time'].compareTo(b['time']));
        } else {
          events[dayKey] = [eventData];
        }
      } catch (e) {
        print('Error processing PM event: $e');
      }
    }
  }

  void updateEventsFromJobs(List<Home> jobList) async {
    for (var job in jobList) {
      try {
        final jobDate = job.date;
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
            await checkWarrantyReturn(job.serialnumber, warrantyInfoList);

        final eventData = {
          "ticketid": job.ticketid,
          "time": formattedTime,
          "status": job.status,
          "task": job.summary,
          "description": job.description,
          "location": job.location,
          "serialNo": warrantyInfoList.first.serial,
          "warrantyStatus": warrantyInfoList.first.warrantyStatus,
          "nameModel": warrantyInfoList.first.model,
        };
        if (events.containsKey(dayKey)) {
          events[dayKey]!.add(eventData);
          events[dayKey]!.sort((a, b) => a['time'].compareTo(b['time']));
        } else {
          events[dayKey] = [eventData];
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
