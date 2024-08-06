import 'package:intl/intl.dart';

String formatDateTime(String dateTime, String option) {
  DateTime parsedDate = DateTime.parse(dateTime);
  if (option == 'time') {
    return DateFormat('dd MMMM yyyy HH:mm').format(parsedDate);
  } else {
    return DateFormat('dd MMMM yyyy').format(parsedDate);
  }
}

String formatDateTimePlus(String dateTime) {
  DateTime parsedDate = DateTime.parse(dateTime).add(const Duration(hours: 7));
  return DateFormat('dd MMMM yyyy HH:mm').format(parsedDate);
}

String formatDateTimeCut(String dateTimeString) {
  int offsetIndex = dateTimeString.indexOf('+');
  String formattedDateTime = offsetIndex != -1
      ? dateTimeString.substring(0, offsetIndex)
      : dateTimeString;

  return formattedDateTime;
}

DateTime formatDateTimeString(String dateTime) {
  try {
    DateTime parsedDate = DateTime.parse(dateTime);
    return parsedDate;
  } catch (e) {
    return DateTime.now();
  }
}

String getFormattedDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  return formatter.format(date);
}

String getFormattedDate2(DateTime date) {
  final DateFormat formatter = DateFormat('MMMM dd, yyyy');
  return formatter.format(date);
}
