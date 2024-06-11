import 'package:get/get.dart';
import 'package:toyotamobile/Models/home_model.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';

class NotificationController extends GetxController {
  final HomeController jobController = Get.put(HomeController());

  List<Home> get todayNotifications {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    return jobController.jobList.where((notification) {
      final notificationDate =
          DateFormat('yyyy-MM-dd').format(notification.date);
      return notificationDate == today;
    }).toList();
  }

  List<Home> get yesterdayNotifications {
    final now = DateTime.now();
    final yesterday =
        DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1)));
    return jobController.jobList.where((notification) {
      final notificationDate =
          DateFormat('yyyy-MM-dd').format(notification.date);
      return notificationDate == yesterday;
    }).toList();
  }
}
