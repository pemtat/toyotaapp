class NotificationHistory {
  String? id;
  String? title;
  String? details;
  String? bugId;
  String? userId;
  String? reportBy;
  String? groupNotify;
  String? status;
  String? datetimeNotify;
  String? groupReportBy;
  String? referenceCode;
  String? jobId;

  NotificationHistory(
      {this.id,
      this.title,
      this.details,
      this.bugId,
      this.userId,
      this.reportBy,
      this.groupNotify,
      this.status,
      this.datetimeNotify,
      this.groupReportBy,
      this.referenceCode,
      this.jobId});

  NotificationHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    bugId = json['bug_id'];
    userId = json['user_id'];
    reportBy = json['report_by'];
    groupNotify = json['group_notify'];
    status = json['status'];
    datetimeNotify = json['datetime_notify'];
    groupReportBy = json['group_report_by'];
    referenceCode = json['reference_code'];
    jobId = json['job_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['details'] = details;
    data['bug_id'] = bugId;
    data['user_id'] = userId;
    data['report_by'] = reportBy;
    data['group_notify'] = groupNotify;
    data['status'] = status;
    data['datetime_notify'] = datetimeNotify;
    data['group_report_by'] = groupReportBy;
    data['reference_code'] = referenceCode;
    data['job_id'] = jobId;
    return data;
  }
}
