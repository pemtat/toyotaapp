import 'package:get/get.dart';
import 'package:toyotamobile/Screen/ForgetPassword/VerifyEmail/verifyemail_view.dart';

class ForgetPasswordController extends GetxController {
  var email = ''.obs;

  void setEmail(String username) {
    email.value = username;
  }

  void clearUsernameAndPassword() {
    email.value = "";
  }

  Future<void> sendEmail() async {
    Get.to(() => VerifyEmailView());
  }
}
