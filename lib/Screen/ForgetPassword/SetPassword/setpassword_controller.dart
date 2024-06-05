import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Login/login_view.dart';

class SetPasswordController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  void setEmail(String username) {
    email.value = username;
  }

  void setPassword(String pass) {
    password.value = pass;
  }

  void clearUsernameAndPassword() {
    email.value = "";
  }

  Future<void> savePassword() async {
    Get.to(() => LoginView());
  }
}
