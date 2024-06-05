import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Screen/ForgetPassword/VerifyEmail/verifyemail_controller.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/login_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class VerifyEmailView extends StatelessWidget {
  final VerifyEmailController controller = Get.put(VerifyEmailController());

  VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCodeInputField(controller.code1, context),
                  _buildCodeInputField(controller.code2, context),
                  _buildCodeInputField(controller.code3, context),
                  _buildCodeInputField(controller.code4, context),
                ],
              ),
              16.kH,
              AppButton(
                title: 'Verify',
                onPressed: controller.verifyCode,
              ),
              36.kH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Resend Code',
                      style: TextStyleList.text18,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeInputField(RxString code, BuildContext context) {
    return SizedBox(
      width: 70,
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            code.value = value;
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
