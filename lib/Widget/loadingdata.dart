import 'package:flutter/material.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: Colors.transparent,
      child: Center(child: DataCircleLoading()),
    );
  }
}
