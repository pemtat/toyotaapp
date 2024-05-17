import 'package:toyotamobile/Screen/Logout/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appbar extends StatelessWidget {
  final String title;
  final LogoutController controller = Get.put(LogoutController());

  Appbar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
    );
  }
}
