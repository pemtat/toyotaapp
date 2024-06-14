import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class Intruction extends StatelessWidget {
  final String phoneNumber;
  final String location;
  const Intruction(
      {super.key, required this.phoneNumber, required this.location});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      children: [
        const TitleApp(text: 'Intruction'),
        Row(
          children: [
            Text(
              'Step 1: Contact reporter',
              style: TextStyleList.text4,
            ),
            3.wH,
            Text('($phoneNumber)', style: TextStyleList.subtext3),
          ],
        ),
        3.kH,
        Wrap(
          children: [
            RichText(
                text: TextSpan(
              text: 'Step 2 ',
              style: TextStyleList.text4,
              children: [
                TextSpan(text: 'Go to the machine', style: TextStyleList.text4),
                TextSpan(
                    text: ' (Location: $location)   ',
                    style: TextStyleList.subtext3),
                WidgetSpan(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GoogleMapButton(
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
        3.kH,
        Text(
          'Step 3: Report to admin about machine',
          style: TextStyleList.text4,
        ),
        3.kH,
        Text(
          'Step 4: Complete investigation',
          style: TextStyleList.text4,
        ),
      ],
    );
  }
}
