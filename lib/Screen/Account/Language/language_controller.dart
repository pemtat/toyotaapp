import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Function/gettoken.dart';
import 'package:toyotamobile/Screen/Account/account_controller.dart';
import 'package:toyotamobile/Screen/User/user_controller.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class LanguageController extends GetxController {
  RxString languageCode = 'th'.obs;
  UserController userController = Get.put(UserController());
  void showConfirmDialog(BuildContext context, String title, String left,
      String right, String languageCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () async {
            await changeLanguage(languageCode, context);
            showMessage('บันทึกการเปลี่ยนแปลง');
          },
        );
      },
    );
  }

  Future<void> changeLanguage(String languageCode, context) async {
    Locale newLocale;

    if (languageCode == 'th') {
      newLocale = Locale('th', 'TH');
    } else {
      newLocale = Locale('en', 'US');
    }

    // เปลี่ยนภาษาโดยใช้ Get.updateLocale
    Get.updateLocale(newLocale);
    String? token = await getToken();
    Map<String, dynamic> body = {
      "user_id": userController.userInfo.first.id,
      "locale": languageCode
    };
    try {
      final response = await http.post(
        Uri.parse(userUpdateLocale()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        await userController.fetchData();

        print(response);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Error fetching token data: $e');
    }
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('language', languageCode);
  }

  Future<String> getLanguage() async {
    await userController.fetchData();
    if (userController.userInfo.isNotEmpty) {
      return userController.userInfo.first.locale;
    }
    return 'th';
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getString('language') ?? 'th';
  }
}
