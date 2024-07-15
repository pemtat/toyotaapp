import 'package:url_launcher/url_launcher_string.dart';

Future<void> openGoogleMaps(String address) async {
  String query = Uri.encodeComponent(address);
  String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

  if (await canLaunchUrlString(googleUrl)) {
    await launchUrlString(googleUrl);
  } else {
    print('Could not launch $googleUrl');
  }
}
