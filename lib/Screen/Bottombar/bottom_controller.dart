import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String version = packageInfo.version;
    String deviceId = '';
    String deviceType;
    if (Platform.isAndroid) {
      deviceType = 'Android';
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      deviceType = 'iOS';
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? 'Unknown';
    } else {
      deviceType = 'Unknown';
    }
    Map<String, dynamic> versionData = {};
    versionData = await getVersions(deviceType, version);
    String versionBase = versionData['version'] ?? '';
    bool versionStatus = versionData['status'] ?? true;
    String versionUser = await getUserVersion(deviceId);

    if (versionStatus == true) {
      if (versionUser != versionBase && versionUser != '') {
        if (version == versionBase) {
          updateTokenNotification(deviceId, version);
        }
      }

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
}
