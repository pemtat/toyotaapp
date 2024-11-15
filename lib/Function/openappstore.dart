import 'package:url_launcher/url_launcher_string.dart';

Future<void> openAppStore() async {
  String googleUrl = "https://apps.apple.com/us/app/t-service/id6612022588";
  try {
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      print('Could not launch $googleUrl');
    }
  } catch (e) {}
}
