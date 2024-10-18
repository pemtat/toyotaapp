import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Service/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/firebase_options.dart';
import 'Screen/Login/login_view.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'your_channel_id',
  'your_channel_name',
  description: 'your_channel_description',
  importance: Importance.high,
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    Firebase.app();
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();

  NotificationService().initNotification();

  await _requestPermissionToUser();
  await _setForegroundNotification();
  await _setupLocalNotifications();
  _setupForegroundNotificationListener();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);

  runApp(MyApp(home: await getHomeWidget(prefs)));
}

Future<void> _requestPermissionToUser() async {
  await Permission.notification.status;
  // var notificationStatus = await Permission.notification.status;
  // if (notificationStatus.isDenied) {
  //   await Permission.notification.request();
  // }
}

Future<void> _setForegroundNotification() async {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  await firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> _setupLocalNotifications() async {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('flutter_icon');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void _setupForegroundNotificationListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showNotification(message);
  });
}

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
  _showNotification(message);
}

Future<void> _showNotification(RemoteMessage message) async {
  final Map<String, dynamic> data = jsonDecode(message.data['default']);
  final Map<String, dynamic> gcmNotification = data['GCM']['notification'];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('notification', 'yes');
  bottomController.checkNotification();
  jobController.fetchDataFromAssignJob();
  // final Map<String, dynamic> gcmData = data['GCM']['data'];

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id, channel.name,
      channelDescription: channel.description,
      importance: Importance.high,
      priority: Priority.high,
      color: red1);

  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    gcmNotification['title'] ?? 'Title',
    gcmNotification['body'] ?? 'Body',
    platformChannelSpecifics,
    payload: 'Notification Payload',
  );
}

Future<Widget> getHomeWidget(SharedPreferences prefs) async {
  String? getStr = prefs.getString('verify');
  return getStr == "pass" ? BottomBarView() : LoginView();
}

class MyApp extends StatelessWidget {
  final Widget? home;
  const MyApp({super.key, this.home});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: white3,
        appBarTheme: const AppBarTheme(
          backgroundColor: white3,
        ),
      ),
      home: home,
    );
  }
}
