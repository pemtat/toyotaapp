import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await _requestNotificationPermissions();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  bool _isRequestingPermission = false;
  Future<void> _requestNotificationPermissions() async {
    if (_isRequestingPermission) {
      return;
    }

    _isRequestingPermission = true;

    try {
      PermissionStatus permissionStatus =
          await Permission.notification.request();

      if (permissionStatus != PermissionStatus.granted) {
        print('Notification permission denied.');
      }
    } catch (e) {
      print('Error requesting permission: $e');
    } finally {
      _isRequestingPermission = false;
    }
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin
        .show(id, title, body, await notificationDetails(), payload: payload);
  }
}
