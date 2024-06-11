import 'package:flutter/material.dart';

class ShowModalWidget extends StatelessWidget {
  final List<Widget>? children;
  final double? paddingCustom;

  const ShowModalWidget({
    super.key,
    this.children,
    this.paddingCustom,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
