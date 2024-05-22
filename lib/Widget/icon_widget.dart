import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackIcon({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const ImageIcon(
        AssetImage('assets/arrowleft.png'),
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}

class CloseIcon extends StatelessWidget {
  final VoidCallback? onPressed;

  const CloseIcon({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const ImageIcon(
        AssetImage('assets/x.png'),
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}
