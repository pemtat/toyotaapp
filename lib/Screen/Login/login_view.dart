import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/login_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOYOTA',
                    style: TextStyleList.subtitle5,
                  ),
                  1.kH,
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 2,
                    color: Colors.grey,
                  ),
                  5.kH,
                  Text(
                    'TOYOTA METERIAL HANDLING THAILAND',
                    style: TextStyleList.subdetail2,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: paddingApp, right: paddingApp, top: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/toyota.png',
                          width: 180,
                          height: 180,
                        ),
                      ),
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
                      // 10.kH,
                      // InkWell(
                      //   onTap: () {
                      //     Get.to(() => ForgetPasswordView());
                      //   },
                      //   child: Text(
                      //     'Forget Password',
                      //     style: TextStyleList.text9,
                      //   ),
                      // ),
                      20.kH,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Footer(onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
