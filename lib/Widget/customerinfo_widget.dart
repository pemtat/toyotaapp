import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/openmap.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class CustomerInformation extends StatelessWidget {
  final String contactName;
  final String email;
  final String phoneNumber;
  final String location;
  final String companyName;
  final BuildContext context;
  final VoidCallback onTap;
  const CustomerInformation(
      {super.key,
      required this.contactName,
      required this.email,
      required this.phoneNumber,
      required this.location,
      required this.companyName,
      required this.context,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      children: [
        TitleApp(text: context.tr('customer_information')),
        8.kH,
        BoxInfo(
          title: context.tr('contact_name'),
          value: contactName,
        ),
        3.kH,
        BoxInfo(
          title: context.tr('email'),
          value: email,
        ),
        3.kH,
        BoxInfo(
          title: context.tr('phone_number'),
          value: phoneNumber,
        ),
        5.kH,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    context.tr('location'),
                    style: TextStyleList.text3,
                  ),
                ),
                Flexible(
                  child: Text(
                    location,
                    style: TextStyleList.text3,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: GoogleMapButton(
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
            ),
          ],
        )
      ],
    );
  }
}
