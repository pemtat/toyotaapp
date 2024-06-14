class SubJobByTicketModel {
  String? id;
  String? reporterId;
  String? priority;
  String? severity;
  String? bugTextId;
  String? profileId;
  String? viewState;
  String? summary;
  String? dateSubmitted;
  String? bugId;
  String? status;
  String? resolution;
  String? projection;
  String? eta;
  dynamic os;
  dynamic osBuild;
  dynamic platform;
  dynamic version;
  dynamic fixedInVersion;
  dynamic build;
  dynamic sponsorshipTotal;
  bool? sticky;
  dynamic targetVersion;
  String? categoryId;
  String? projectId;
  String? handlerId;
  String? duplicateId;
  String? reproducibility;
  String? dueDate;
  String? lastUpdated;
  String? description;

  SubJobByTicketModel({
    this.id,
    this.reporterId,
    this.priority,
    this.severity,
    this.bugTextId,
    this.profileId,
    this.viewState,
    this.summary,
    this.dateSubmitted,
    this.bugId,
    this.status,
    this.resolution,
    this.projection,
    this.eta,
    this.os,
    this.osBuild,
    this.platform,
    this.version,
    this.fixedInVersion,
    this.build,
    this.sponsorshipTotal,
    this.sticky,
    this.targetVersion,
    this.categoryId,
    this.projectId,
    this.handlerId,
    this.duplicateId,
    this.reproducibility,
    this.dueDate,
    this.lastUpdated,
    this.description,
  });

  factory SubJobByTicketModel.fromJson(Map<String, dynamic> json) {
    return SubJobByTicketModel(
      id: json['id'],
      reporterId: json['reporter_id'],
      priority: json['priority'],
      severity: json['severity'],
      bugTextId: json['bug_text_id'],
      profileId: json['profile_id'],
      viewState: json['view_state'],
      summary: json['summary'],
      dateSubmitted: json['date_submitted'],
      bugId: json['bug_id'],
      status: json['status'],
      resolution: json['resolution'],
      projection: json['projection'],
      eta: json['eta'],
      os: json['os'],
      osBuild: json['os_build'],
      platform: json['platform'],
      version: json['version'],
      fixedInVersion: json['fixed_in_version'],
      build: json['build'],
      sponsorshipTotal: json['sponsorship_total'],
      sticky: json['sticky'],
      targetVersion: json['target_version'],
      categoryId: json['category_id'],
      projectId: json['project_id'],
      handlerId: json['handler_id'],
      duplicateId: json['duplicate_id'],
      reproducibility: json['reproducibility'],
      dueDate: json['due_date'],
      lastUpdated: json['last_updated'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporter_id': reporterId,
      'priority': priority,
      'severity': severity,
      'bug_text_id': bugTextId,
      'profile_id': profileId,
      'view_state': viewState,
      'summary': summary,
      'date_submitted': dateSubmitted,
      'bug_id': bugId,
      'status': status,
      'resolution': resolution,
      'projection': projection,
      'eta': eta,
      'os': os,
      'os_build': osBuild,
      'platform': platform,
      'version': version,
      'fixed_in_version': fixedInVersion,
      'build': build,
      'sponsorship_total': sponsorshipTotal,
      'sticky': sticky,
      'target_version': targetVersion,
      'category_id': categoryId,
      'project_id': projectId,
      'handler_id': handlerId,
      'duplicate_id': duplicateId,
      'reproducibility': reproducibility,
      'due_date': dueDate,
      'last_updated': lastUpdated,
      'description': description,
    };
  }
}
