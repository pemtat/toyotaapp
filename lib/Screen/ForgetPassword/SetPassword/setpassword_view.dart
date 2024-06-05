import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Screen/ForgetPassword/SetPassword/setpassword_controller.dart';

import 'package:toyotamobile/Widget/login_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class SetPasswordView extends StatelessWidget {
  final SetPasswordController controller = Get.put(SetPasswordController());

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  "Set Password",
                  style: GoogleFonts.kanit(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                16.kH,
                TextFieldLogin(
                  label: 'Email',
                  onChanged: controller.setEmail,
                  hidetext: true,
                ),
                20.kH,
                TextFieldLogin(
                  label: 'Password',
                  onChanged: controller.setPassword,
                  hidetext: true,
                ),
                10.kH,
                AppButton(
                  title: 'Save',
                  onPressed: controller.savePassword,
                ),
                20.kH,
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
