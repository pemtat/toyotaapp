import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Service/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/firebase_options.dart';
import 'Screen/Login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  NotificationService().initNotification();
  // final NotificationService notificationService = NotificationService();
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   notificationService.showNotification(
  //     id: 1,
  //     title: 'Hello!',
  //     body: 'This is a test notification',
  //     payload: 'Notification Payload',
  //   );
  // });
  runApp(MyApp(home: await getHomeWidget(prefs)));
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
