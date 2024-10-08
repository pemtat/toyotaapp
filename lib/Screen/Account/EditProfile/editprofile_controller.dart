import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dialogalert_widget.dart';

class EditProfileController extends GetxController {
  final HomeController jobController = Get.put(HomeController());
  final name = TextEditingController().obs;
  final email = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final password = TextEditingController().obs;
  final resourceNo = TextEditingController().obs;
  final serviceZone = TextEditingController().obs;
  var isTextHidden = false.obs;

  void toggleVisibility() {
    isTextHidden.value = !isTextHidden.value;
  }

  void showEditDialog(
      BuildContext context, String title, String left, String right) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAlert(
          title: title,
          leftButton: left,
          rightButton: right,
          onRightButtonPressed: () {
            logout();
          },
          rightColor: red1,
        );
      },
    );
  }

  Future<void> logout() async {}
}
