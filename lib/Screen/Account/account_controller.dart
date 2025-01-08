import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Screen/Login/login_view.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class AccountController extends GetxController {
  final BottomBarController controller = Get.put(BottomBarController());
  final HomeController jobController = Get.put(HomeController());
  final UserController userController = Get.put(UserController());
  var version = ''.obs;
  var buildVersion = ''.obs;
  @override
  void onInit() {
    super.onInit();
    userController.fetchData();
    getDataApp();
  }

  Future<void> getDataApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    buildVersion.value = packageInfo.buildNumber;
  }

  void showLogoutDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          rightColor: red1,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            logout();
          },
        );
      },
    );
  }

  void showDeleteDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            deleteAccount();
          },
          rightColor: red1,
        );
      },
    );
  }

  Future<void> deleteToken(String accessToken) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? 'Unknown';
    } else {
      deviceId = 'Unknown';
    }

    Map<String, dynamic> body = {
      "device_id": deviceId,
    };
    try {
      final response = await http.post(
        Uri.parse(deleteTokenNotification()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('Deleted Token');
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching token data: $e');
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await getToken();
    deleteToken(token ?? '');
    prefs.setString('access_token', "");
    prefs.setString('token_response', "");
    prefs.setString('token', "");
    prefs.setString('verify', "");
    controller.currentIndex.value = 0;
    jobController.mostRecentNewJob.value = null;
    jobController.mostRecentCompleteJob.value = null;
    Get.offAll(() => LoginView());
  }

  Future<void> deleteAccount() async {
    String? token = await getToken();
    print(token);
    Map<String, dynamic> body = {
      "user_id": userController.userInfo.first.id,
    };
    print(body);
    try {
      final response = await http.post(
        Uri.parse(userDisbled()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print(response);
        print('Deleted Users');
        await logout();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching token data: $e');
    }
  }
}
