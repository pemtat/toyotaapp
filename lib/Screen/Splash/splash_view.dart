import 'package:toyotamobile/Widget/logo_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenView(),
    );
  }
}

class SplashScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SplashImage(),
            20.kH,
            Text('Welcome to ', style: TextStyleList.headline),
            Text('Business point', style: TextStyleList.headline),
          ],
        ),
      ),
    );
  }
}
