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
  Null? os;
  Null? osBuild;
  Null? platform;
  Null? version;
  Null? fixedInVersion;
  Null? build;
  Null? sponsorshipTotal;
  bool? sticky;
  Null? targetVersion;
  String? categoryId;
  String? projectId;
  String? handlerId;
  String? duplicateId;
  String? reproducibility;
  String? dueDate;
  String? lastUpdated;
  String? description;

  SubJobByTicketModel(
      {this.id,
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
      this.description});

  SubJobByTicketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporterId = json['reporter_id'];
    priority = json['priority'];
    severity = json['severity'];
    bugTextId = json['bug_text_id'];
    profileId = json['profile_id'];
    viewState = json['view_state'];
    summary = json['summary'];
    dateSubmitted = json['date_submitted'];
    bugId = json['bug_id'];
    status = json['status'];
    resolution = json['resolution'];
    projection = json['projection'];
    eta = json['eta'];
    os = json['os'];
    osBuild = json['os_build'];
    platform = json['platform'];
    version = json['version'];
    fixedInVersion = json['fixed_in_version'];
    build = json['build'];
    sponsorshipTotal = json['sponsorship_total'];
    sticky = json['sticky'];
    targetVersion = json['target_version'];
    categoryId = json['category_id'];
    projectId = json['project_id'];
    handlerId = json['handler_id'];
    duplicateId = json['duplicate_id'];
    reproducibility = json['reproducibility'];
    dueDate = json['due_date'];
    lastUpdated = json['last_updated'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reporter_id'] = this.reporterId;
    data['priority'] = this.priority;
    data['severity'] = this.severity;
    data['bug_text_id'] = this.bugTextId;
    data['profile_id'] = this.profileId;
    data['view_state'] = this.viewState;
    data['summary'] = this.summary;
    data['date_submitted'] = this.dateSubmitted;
    data['bug_id'] = this.bugId;
    data['status'] = this.status;
    data['resolution'] = this.resolution;
    data['projection'] = this.projection;
    data['eta'] = this.eta;
    data['os'] = this.os;
    data['os_build'] = this.osBuild;
    data['platform'] = this.platform;
    data['version'] = this.version;
    data['fixed_in_version'] = this.fixedInVersion;
    data['build'] = this.build;
    data['sponsorship_total'] = this.sponsorshipTotal;
    data['sticky'] = this.sticky;
    data['target_version'] = this.targetVersion;
    data['category_id'] = this.categoryId;
    data['project_id'] = this.projectId;
    data['handler_id'] = this.handlerId;
    data['duplicate_id'] = this.duplicateId;
    data['reproducibility'] = this.reproducibility;
    data['due_date'] = this.dueDate;
    data['last_updated'] = this.lastUpdated;
    data['description'] = this.description;
    return data;
  }
}
