import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:toyotamobile/Service/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'Screen/Login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  NotificationService().initNotification();
  runApp(MyApp(home: await getHomeWidget(prefs)));
}

Future<Widget> getHomeWidget(SharedPreferences prefs) async {
  String? getStr = prefs.getString('access_token');
  return getStr != "" ? BottomBarView() : LoginView();
}

class MyApp extends StatelessWidget {
  final Widget? home;
  MyApp({this.home});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: buttontextcolor,
        appBarTheme: AppBarTheme(
          backgroundColor: buttontextcolor,
        ),
      ),
      home: home,
    );
  }
}
