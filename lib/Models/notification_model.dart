// lib/models/notification_model.dart

import 'package:intl/intl.dart';

class NotificationModel {
  final String jobId;
  final String ticketId;
  final String summary;
  final String description;
  final DateTime date;

  NotificationModel({
    required this.jobId,
    required this.ticketId,
    required this.summary,
    required this.description,
    required this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      jobId: json['jobId'],
      ticketId: json['ticketId'],
      summary: json['summary'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobId,
      'ticketId': ticketId,
      'summary': summary,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  String getFormattedDate() {
    final DateFormat formatter = DateFormat('dd MMMM yyyy hh:mm a');
    return formatter.format(date);
  }
}
