import 'package:intl/intl.dart';

class Home {
  final String jobid;
  final String ticketid;
  final String summary;
  final String description;
  final DateTime date;
  final String location;
  final String status;

  Home({
    required this.jobid,
    required this.ticketid,
    required this.summary,
    required this.description,
    required this.date,
    required this.location,
    required this.status,
  });

  String getFormattedDate() {
    final DateFormat formatter = DateFormat('dd MMMM yyyy HH:mm');
    return formatter.format(date);
  }

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
        jobid: json['id'].toString(),
        summary: json['summary'] ?? '',
        ticketid:
            json['id'] != null ? json['id'].toString().padLeft(6, '0') : '',
        description: json['description'] ?? '',
        date: json['due_date'] != null
            ? DateTime.parse(json['due_date'])
            : DateTime.now(),
        location: 'Bangkok',
        status: json['status'] != null ? json['status']['name'] : 'Unknown');
  }
}
