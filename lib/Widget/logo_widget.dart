import 'package:flutter/material.dart';

//Using [ Splash ]
class SplashImage extends StatelessWidget {
  const SplashImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Image.asset(
        'assets/chevron.png',
        width: 40,
        height: 40,
      ),
    );
  }
}
