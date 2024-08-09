import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.red,
      backgroundColor: Colors.grey,
    );
  }
}

class DataCircleLoading extends StatelessWidget {
  const DataCircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Colors.grey,
      color: blue1,
    );
  }
}
