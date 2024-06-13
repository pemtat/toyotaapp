import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';

class TaskHistoryView extends StatelessWidget {
  const TaskHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              backgroundColor: white3,
              title: Text('Task History', style: TextStyleList.title1),
            ),
            Container(
              height: 0.5,
              color: white5,
            ),
            const AppDivider()
          ],
        ),
      ),
      body: const Column(children: [
        InkWell(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [],
            ),
          ),
        ),
      ]),
    );
  }
}
