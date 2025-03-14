import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/openmap.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class Intruction extends StatelessWidget {
  final String phoneNumber;
  final String location;
  final BuildContext context;
  final String? fetchLocation;
  const Intruction(
      {super.key,
      required this.context,
      required this.phoneNumber,
      required this.location,
      this.fetchLocation});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      children: [
        TitleApp(text: context.tr('intruction')),
        Row(
          children: [
            Text(
              '${context.tr('step_1')}: ${context.tr('contact_reporter')}',
              style: TextStyleList.text4,
            ),
            3.wH,
            Text('($phoneNumber)', style: TextStyleList.subtext3),
          ],
        ),
        3.kH,
        fetchLocation == null
            ? Wrap(
                children: [
                  RichText(
                      text: TextSpan(
                    text: '${context.tr('step_2')}: ',
                    style: TextStyleList.text4,
                    children: [
                      TextSpan(
                          text: context.tr('go_to_machine'),
                          style: TextStyleList.text4),
                      TextSpan(
                          text: ' (${context.tr('location')}: $location)   ',
                          style: TextStyleList.subtext3),
                      WidgetSpan(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GoogleMapButton(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return const Center(
                                      child: DataCircleLoading(),
                                    );
                                  },
                                );

                                try {
                                  await openGoogleMaps(location);
                                } catch (e) {
                                  print(e);
                                } finally {
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              )
            : Wrap(
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${context.tr('step_2')}: ',
                      style: TextStyleList.text4,
                      children: [
                        TextSpan(
                            text: context.tr('go_to_machine'),
                            style: TextStyleList.text4),
                        TextSpan(
                          text: ' (${context.tr('location')}: $location)   ',
                          style: TextStyleList.subtext3,
                        ),
                        WidgetSpan(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GoogleMapButton(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return const Center(
                                        child: DataCircleLoading(),
                                      );
                                    },
                                  );

                                  try {
                                    await openGoogleMaps(location);
                                  } catch (e) {
                                    print(e);
                                  } finally {
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        3.kH,
        Text(
          '${context.tr('step_3')}: ${context.tr('report_to_admin')}',
          style: TextStyleList.text4,
        ),
        3.kH,
        Text(
          '${context.tr('step_4')}: ${context.tr('complete_investigation')}',
          style: TextStyleList.text4,
        ),
      ],
    );
  }
}
