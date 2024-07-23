// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';

class ArrowRight extends StatelessWidget {
  const ArrowRight({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(black7, BlendMode.srcIn),
      child: Image.asset(
        'assets/arrowright.png',
        width: 24,
        height: 24,
      ),
    );
  }
}

class ArrowLeft extends StatelessWidget {
  const ArrowLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(black7, BlendMode.srcIn),
      child: Image.asset(
        'assets/arrowleft.png',
        width: 24,
        height: 24,
      ),
    );
  }
}

class ArrowDown extends StatelessWidget {
  final double? width;
  final double? height;
  const ArrowDown({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(black7, BlendMode.srcIn),
      child: Image.asset(
        'assets/arrowdown.png',
        width: width ?? 24,
        height: height ?? 24,
      ),
    );
  }
}

class ArrowUp extends StatelessWidget {
  final double? width;
  final double? height;
  const ArrowUp({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        black7,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        'assets/arrowup.png',
        width: width ?? 24,
        height: height ?? 24,
      ),
    );
  }
}
