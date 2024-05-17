import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Widget/login_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Center(
                    child: Text(
                  "T-Service Connect",
                  style: GoogleFonts.kanit(
                      fontSize: 25, fontWeight: FontWeight.w500),
                )),
                25.kH,
                TextFieldLogin(
                  label: 'Email',
                  onChanged: controller.setEmail,
                ),
                20.kH,
                TextFieldLogin(
                  label: 'Password',
                  onChanged: controller.setPassword,
                  hidetext: true,
                ),
                20.kH,
                LoginButton(
                  onPressed: controller.login,
                ),
                Spacer(),
                Footer(onTap: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
