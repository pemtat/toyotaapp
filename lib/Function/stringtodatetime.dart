import 'package:intl/intl.dart';

String formatDateTime(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  return DateFormat('dd MMMM yyyy, hh:mm a').format(parsedDate);
}

DateTime formatDateTimeString(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime);
  return parsedDate;
}

String getFormattedDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMMM yyyy hh:mm a');
  return formatter.format(date);
}

String getFormattedDate2(DateTime date) {
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');
  return formatter.format(date);
}
