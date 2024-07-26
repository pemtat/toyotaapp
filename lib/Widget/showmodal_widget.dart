import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';

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

class ShowModalWidget2 extends StatelessWidget {
  final List<Widget>? children;
  final VoidCallback onPressed;
  final double? paddingCustom;
  final String title;

  const ShowModalWidget2({
    super.key,
    this.children,
    this.paddingCustom,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: SafeArea(
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              title,
              style: TextStyleList.subheading,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset("assets/x.png"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EndButton(
          onPressed: onPressed,
          text: 'Save',
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => this,
    );
  }
}
