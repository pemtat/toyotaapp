import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';
import 'package:toyotamobile/Widget/fluttertoast_widget.dart';

class LanguageController extends GetxController {
  RxString languageCode = 'th'.obs;
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', languageCode);
    Navigator.pop(context);
  }

  Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'th';
  }
}
