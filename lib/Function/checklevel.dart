import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:http/http.dart' as http;

Future<String> checkLevel(int userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String getUserInfo = getUserInfoById(userId.toString());
  String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse(getUserInfo),
    headers: {
      'Authorization': '$token',
    },
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    var user = data['users'].firstWhere((user) => user['id'] == userId);
    var accessLevel = user['access_level'];
    if (accessLevel['name'] == 'administrator') {
      return 'A';
    } else {
      return 'R';
    }
  } else {
    throw Exception('Failed to load user data');
  }
}
