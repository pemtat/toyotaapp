import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackIcon({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/arrowleft.png'),
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}

class CloseIcon extends StatelessWidget {
  final VoidCallback? onPressed;

  const CloseIcon({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/x.png'),
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}
