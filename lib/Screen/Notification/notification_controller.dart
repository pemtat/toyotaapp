import 'package:get/get.dart';
import 'package:toyotamobile/Models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    notifications.addAll([
      NotificationModel(
        jobId: '0001',
        ticketId: '00000098',
        summary: 'Customer wrote a note!',
        description: 'Water is also leaking and we don’t know how to do it...',
        date: DateTime.parse('2024-06-07T13:00:00'),
      ),
      NotificationModel(
        jobId: '00002',
        ticketId: '00000098',
        summary: 'New Job Assigned',
        description: 'Please check the new job assigned to you.',
        date: DateTime.parse('2024-06-07T13:00:00'),
      ),
      NotificationModel(
        jobId: '00003',
        ticketId: '00000099',
        summary: 'Reminder: Job Deadline Approaching',
        description: 'Your job deadline is approaching soon.',
        date: DateTime.parse('2024-06-06T13:00:00'),
      ),
    ]);

    notifications.sort((a, b) => b.date.compareTo(a.date));
  }

  List<NotificationModel> get todayNotifications {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    return notifications.where((notification) {
      final notificationDate =
          DateFormat('yyyy-MM-dd').format(notification.date);
      return notificationDate == today;
    }).toList();
  }

  List<NotificationModel> get yesterdayNotifications {
    final now = DateTime.now();
    final yesterday =
        DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1)));
    return notifications.where((notification) {
      final notificationDate =
          DateFormat('yyyy-MM-dd').format(notification.date);
      return notificationDate == yesterday;
    }).toList();
  }
}
