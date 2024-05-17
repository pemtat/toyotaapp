import 'package:toyotamobile/Models/login_model.dart';
import 'package:toyotamobile/Data/user.dart';
import 'package:toyotamobile/Screen/Home/home_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void login() async {
    try {
      bool isValidUser = sampleUsers.any((user) =>
          user.email == _loginModel.email.value &&
          user.password == _loginModel.password.value);

      if (isValidUser) {
        String userId = sampleUsers
            .firstWhere((user) =>
                user.email == _loginModel.email.value &&
                user.password == _loginModel.password.value)
            .id;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_id', userId);

        Get.offAll(() => HomeView());
      } else {
        Get.snackbar('เข้าสู่ระบบ', 'ชื่อผู้ใช้หรือรหัสผ่านผิดพลาด');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred during login $e');
    }
  }
}
