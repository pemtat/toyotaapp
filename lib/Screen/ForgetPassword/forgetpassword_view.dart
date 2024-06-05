import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Screen/ForgetPassword/forgetpassword_controller.dart';
import 'package:toyotamobile/Screen/Login/login_view.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/login_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class ForgetPasswordView extends StatelessWidget {
  final ForgetPasswordController controller =
      Get.put(ForgetPasswordController());

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
                  "Forget Password?",
                  style: GoogleFonts.kanit(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                16.kH,
                TextFieldLogin(
                  label: 'Email',
                  onChanged: controller.setEmail,
                ),
                10.kH,
                AppButton(
                  title: 'Send',
                  onPressed: controller.sendEmail,
                ),
                10.kH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => LoginView());
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyleList.text9,
                      ),
                    ),
                  ],
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
