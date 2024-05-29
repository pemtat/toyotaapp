import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Service/api.dart';

Future<void> tokenCreate() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? '';

    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {
        'Access-Token': accessToken,
      },
    );

    if (response.statusCode == 201) {
      final tokenResponseData = json.decode(response.body);

      prefs.setString('token_response', json.encode(tokenResponseData));
      String? tokenResponse = prefs.getString('token_response');
      Map<String, dynamic> tokenData = json.decode(tokenResponse ?? '');
      prefs.setString('token', tokenData['token']);
    } else {}
  } catch (e) {
    // ignore: avoid_print
    print('Error fetching token data: $e');
  }
}
