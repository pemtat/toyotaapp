import 'package:get/get.dart';
import 'package:toyotamobile/Screen/ForgetPassword/SetPassword/setpassword_view.dart';

class VerifyEmailController extends GetxController {
  var code1 = ''.obs;
  var code2 = ''.obs;
  var code3 = ''.obs;
  var code4 = ''.obs;

  String get completeCode =>
      code1.value + code2.value + code3.value + code4.value;

  void verifyCode() {
    String code = completeCode;

    if (code.length == 4) {
      Get.to(() => SetPasswordView());
    } else {
      Get.snackbar(
        "Error",
        "Please enter the complete verification code",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
