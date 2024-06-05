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

class AppIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final Color color;
  final Color backgroundColor;

  const AppIcon({
    Key? key,
    required this.assetPath,
    this.size = 24.0,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  factory AppIcon.block({
    double size = 24.0,
    Color color = Colors.black,
    Color backgroundColor = Colors.white,
    Color borderColor = Colors.grey,
    double borderWidth = 1.0,
  }) {
    return AppIcon(
      assetPath: 'assets/icon/box-3d.png',
      size: size,
      color: color,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Center(
        child: ImageIcon(
          AssetImage(assetPath),
          size: size,
          color: color,
        ),
      ),
    );
  }
}
