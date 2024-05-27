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
  const ArrowDown({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(black7, BlendMode.srcIn),
      child: Image.asset(
        'assets/arrowdown.png',
        width: 24,
        height: 24,
      ),
    );
  }
}

class ArrowUp extends StatelessWidget {
  const ArrowUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(black7, BlendMode.srcIn),
      child: Image.asset(
        'assets/arrowup.png',
        width: 24,
        height: 24,
      ),
    );
  }
}
