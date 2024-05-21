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
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(paddingCustom ?? 16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children ?? [],
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => this,
    );
  }
}
