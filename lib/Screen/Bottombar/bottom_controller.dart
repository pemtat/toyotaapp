import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class BottomBarController extends GetxController {
  var currentIndex = 0.obs;
  var hasNotification = false.obs;
  final PageController pageController = PageController();

  Future<bool> checkNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notification = prefs.getString('notification');
    if (currentIndex.value != 4) {
      hasNotification.value = true;
      return notification == 'yes';
    }
    return notification == 'no';
  }

  Future<void> clearNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('notification');
    hasNotification.value = false;
  }

  Future<void> checkAppVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String deviceType;
    if (Platform.isAndroid) {
      deviceType = 'Android';
    } else if (Platform.isIOS) {
      deviceType = 'iOS';
    } else {
      deviceType = 'Unknown';
    }
    String versionBase = await getVersions(deviceType, version);
    if (version != versionBase) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialogVersions(
            deviceType: deviceType,
          );
        },
      );
    }
  }
}
