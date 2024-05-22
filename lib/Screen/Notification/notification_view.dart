import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    BottomBarView();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('แจ้งเตือน'),
      ),
      body: Container(),
    );
  }
}
