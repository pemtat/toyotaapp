import 'package:intl/intl.dart';

class Home {
  final String jobid;
  final String ticketid;
  final String summary;
  final String description;
  final DateTime date;
  final String location;
  final String serialnumber;
  final String status;

  Home({
    required this.jobid,
    required this.ticketid,
    required this.summary,
    required this.description,
    required this.date,
    required this.location,
    required this.status,
    required this.serialnumber,
  });

  String getFormattedDate() {
    final DateFormat formatter = DateFormat('dd MMMM yyyy hh:mm a');
    return formatter.format(date);
  }

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
        jobid: json['id'].toString(),
        summary: json['summary'] ?? '',
        ticketid: json['id'] != null ? json['id'].toString() : '',
        description: json['description'] ?? '',
        date: json['due_date'] != null
            ? DateTime.parse(json['due_date'])
            : DateTime.now(),
        location: 'Bangkok',
        serialnumber: 'CE429424',
        status: json['status'] != null ? json['status']['name'] : 'Unknown');
  }
}
