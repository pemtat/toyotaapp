import 'package:get/get.dart';
import 'package:toyotamobile/Function/stringtodatetime.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';

class NotificationController extends GetxController {
  final HomeController jobController = Get.put(HomeController());
  var subJobSparePart = <SubJobSparePart>[].obs;

  List<Issues> get todayNotifications {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    return jobController.jobList.where((notification) {
      final jobDate = formatDateTimeString(notification.dueDate ?? '');
      final notificationDate = DateFormat('yyyy-MM-dd').format(jobDate);
      return notificationDate == today;
    }).toList();
  }

  List<Issues> get yesterdayNotifications {
    final now = DateTime.now();
    final yesterday =
        DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1)));
    return jobController.jobList.where((notification) {
      final jobDate = formatDateTimeString(notification.dueDate ?? '');

      final notificationDate = DateFormat('yyyy-MM-dd').format(jobDate);
      return notificationDate == yesterday;
    }).toList();
  }

  Future<void> fetchNotifySubJobSparePartId(
      String jobId, String bugId, String projectId) async {
    try {
      jobController.subJobSparePart.refresh();
      subJobSparePart.clear();
      List<SubJobSparePart> filteredSpareParts = [];

      if (projectId == '1') {
        filteredSpareParts = jobController.subJobSparePart
            .where((element) => element.id == jobId)
            .toList();
      } else {
        filteredSpareParts = jobController.subJobSparePart
            .where((element) => element.bugId == bugId)
            .toList();
      }

      subJobSparePart.value = filteredSpareParts;
      subJobSparePart.refresh();
    } catch (e) {
      print(e);
    }
  }
}
