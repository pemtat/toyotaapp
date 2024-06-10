class SubJobDetail {
  List<JobById>? jobById;

  SubJobDetail({this.jobById});

  SubJobDetail.fromJson(Map<String, dynamic> json) {
    if (json['jobById'] != null) {
      jobById = <JobById>[];
      json['jobById'].forEach((v) {
        jobById!.add(JobById.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobById != null) {
      data['jobById'] = jobById!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobById {
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
  Null os;
  Null osBuild;
  Null platform;
  Null version;
  Null fixedInVersion;
  Null build;
  Null sponsorshipTotal;
  bool? sticky;
  Null targetVersion;
  String? categoryId;
  String? projectId;
  String? handlerId;
  String? duplicateId;
  String? reproducibility;
  String? dueDate;
  String? lastUpdated;
  String? description;

  JobById(
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

  JobById.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reporter_id'] = reporterId;
    data['priority'] = priority;
    data['severity'] = severity;
    data['bug_text_id'] = bugTextId;
    data['profile_id'] = profileId;
    data['view_state'] = viewState;
    data['summary'] = summary;
    data['date_submitted'] = dateSubmitted;
    data['bug_id'] = bugId;
    data['status'] = status;
    data['resolution'] = resolution;
    data['projection'] = projection;
    data['eta'] = eta;
    data['os'] = os;
    data['os_build'] = osBuild;
    data['platform'] = platform;
    data['version'] = version;
    data['fixed_in_version'] = fixedInVersion;
    data['build'] = build;
    data['sponsorship_total'] = sponsorshipTotal;
    data['sticky'] = sticky;
    data['target_version'] = targetVersion;
    data['category_id'] = categoryId;
    data['project_id'] = projectId;
    data['handler_id'] = handlerId;
    data['duplicate_id'] = duplicateId;
    data['reproducibility'] = reproducibility;
    data['due_date'] = dueDate;
    data['last_updated'] = lastUpdated;
    data['description'] = description;
    return data;
  }
}
