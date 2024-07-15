import 'package:flutter/material.dart';
import 'package:toyotamobile/Function/openmap.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

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
        const TitleApp(text: "Customer Information"),
        8.kH,
        BoxInfo(
          title: "Contact name",
          value: contactName,
        ),
        3.kH,
        BoxInfo(
          title: "Email",
          value: email,
        ),
        3.kH,
        BoxInfo(
          title: "Phone number",
          value: phoneNumber,
        ),
        BoxInfo(
          title: "Location",
          value: location,
        ),
        5.kH,
        Row(
          children: [
            const Spacer(),
            GoogleMapButton(
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
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
      ],
    );
  }
}
