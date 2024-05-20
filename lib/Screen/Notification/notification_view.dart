import 'package:toyotamobile/Screen/Bottombar/bottom_controller.dart';
import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomBarController controller = Get.put(BottomBarController());
    BottomBarView();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('แจ้งเตือน'),
      ),
      body: Container(),
    );
  }
}
