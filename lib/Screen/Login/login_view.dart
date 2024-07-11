import 'package:toyotamobile/Screen/ForgetPassword/forgetpassword_view.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/login_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

// ignore: use_key_in_widget_constructors
class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Image.asset(
              'assets/toyotalogo.png',
              width: 150,
              height: 100,
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                    child: Image.asset(
                  'assets/toyota.png',
                  width: 180,
                  height: 180,
                )),
                30.kH,
                TextFieldBar(
                  label: 'Username',
                  onChanged: controller.setEmail,
                ),
                20.kH,
                TextFieldBar(
                  label: 'Password',
                  onChanged: controller.setPassword,
                  hidetext: true,
                ),
                20.kH,
                AppButton(
                  title: 'Login',
                  onPressed: controller.login,
                ),
                10.kH,
                InkWell(
                  onTap: () {
                    Get.to(() => ForgetPasswordView());
                  },
                  child: Text(
                    'Forget Password',
                    style: TextStyleList.text9,
                  ),
                ),
                20.kH,
                const Spacer(),
                Footer(onTap: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
