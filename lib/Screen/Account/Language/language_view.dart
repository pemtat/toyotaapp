import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Screen/Account/Language/language_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

// ignore: must_be_immutable
class LanguageView extends StatelessWidget {
  LanguageView({super.key});

  LanguageController languageController = Get.put(LanguageController());

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
              title: Text('Language', style: TextStyleList.title1),
            ),
            Container(
              height: 0.5,
              color: white5,
            ),
            const AppDivider()
          ],
        ),
      ),
      body: Column(children: [
        InkWell(
          onTap: () {
            languageController.showConfirmDialog(
              context,
              'Are you confirm to change?',
              'Cancel',
              'Yes',
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/thailand.png',
                  width: 21,
                  height: 15,
                ),
                8.wH,
                Text(
                  'Thai',
                  style: TextStyleList.text9,
                )
              ],
            ),
          ),
        ),
        const AppDivider(),
        InkWell(
          onTap: () {
            languageController.showConfirmDialog(
              context,
              'Are you confirm to change?',
              'Cancel',
              'Yes',
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/english.png',
                  width: 21,
                  height: 15,
                ),
                8.wH,
                Text(
                  'English',
                  style: TextStyleList.text9,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
