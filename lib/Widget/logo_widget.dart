import 'package:flutter/material.dart';

//Using [ Splash ]
class SplashImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Image.asset(
        'assets/chevron.png',
        width: 40,
        height: 40,
      ),
    );
  }
}
