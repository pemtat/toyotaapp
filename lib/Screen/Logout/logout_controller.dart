import 'package:toyotamobile/Screen/Login/login_controller.dart';
import 'package:toyotamobile/Screen/Login/login_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController {
  final LoginController controller = LoginController();

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', "");
    controller.clearUsernameAndPassword();
    Get.offAll(() => LoginView());
  }
}
