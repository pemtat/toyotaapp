import 'package:intl/intl.dart';

class Home {
  final String jobid;
  final String ticketid;
  final String problem;
  final String detail;
  final DateTime date;
  final String location;
  final String status;

  Home({
    required this.jobid,
    required this.ticketid,
    required this.detail,
    required this.problem,
    required this.date,
    required this.location,
    required this.status,
  });

  String getFormattedDate() {
    final DateFormat formatter = DateFormat('dd MMMM yyyy HH:mm');
    return formatter.format(date);
  }
}
