import 'package:toyotamobile/Screen/Bottombar/bottom_view.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
