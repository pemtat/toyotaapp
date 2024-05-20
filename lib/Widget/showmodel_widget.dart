import 'package:flutter/material.dart';

class ShowModalWidget extends StatelessWidget {
  final List<Widget>? children;
  final double? paddingCustom;

  const ShowModalWidget({
    Key? key,
    this.children,
    this.paddingCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingCustom ?? 16),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children ?? [],
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => this,
    );
  }
}
