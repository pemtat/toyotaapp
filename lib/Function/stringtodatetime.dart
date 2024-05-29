import 'package:intl/intl.dart';

String formatDateTime(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  return DateFormat('dd MMMM yyyy, hh:mm a').format(parsedDate);
}
