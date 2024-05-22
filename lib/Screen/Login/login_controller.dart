import 'dart:convert';
import 'package:toyotamobile/Models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyotamobile/Service/api.dart';

class LoginController extends GetxController {
  final LoginModel _loginModel = LoginModel();

  void setEmail(String username) {
    _loginModel.email.value = username;
  }

  void setPassword(String password) {
    _loginModel.password.value = password;
  }

  void clearUsernameAndPassword() {
    _loginModel.email.value = "";
    _loginModel.password.value = "";
  }

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'User': _loginModel.email.value,
          'Password': _loginModel.password.value,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final accessToken = responseData['access_token'] as String;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', accessToken);

        Get.offAll(() => BottomBarView());
        Get.snackbar('Login Succesful', 'Welcome to T-Service');
      } else {
        Get.snackbar('Login Failed', 'Invalid username or password');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }
}
