import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:toyotamobile/Models/user_model.dart';
import 'package:toyotamobile/Service/api.dart';

class UserController extends GetxController {
  var userInfo = <User>[].obs;

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse(getUserInfo()),
        headers: {
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is List) {
          List<User> userList =
              responseData.map((json) => User.fromJson(json)).toList();
          userInfo.value = userList;
          Locale newLocale;
          newLocale = Locale(userList.first.locale);
          Get.updateLocale(newLocale);
        } else if (responseData is Map<String, dynamic>) {
          User user = User.fromJson(responseData);
          userInfo.value = [user];
          Locale newLocale;
          newLocale = Locale(userInfo.first.locale);
          Get.updateLocale(newLocale);
        } else {
          print('Invalid data format');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
