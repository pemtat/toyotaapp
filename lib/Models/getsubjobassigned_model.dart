class SubJobAssgined {
  String? id;
  String? reporterId;
  String? priority;
  String? severity;
  String? profileId;
  String? viewState;
  String? summary;
  String? dateSubmitted;
  String? bugId;
  String? status;
  String? resolution;
  String? projection;
  String? categoryId;
  String? projectId;
  String? handlerId;
  String? reproducibility;
  String? dueDate;
  String? lastUpdated;
  String? description;
  String? timeStart;
  String? timeEnd;
  String? comment;
  String? contentBefore;
  String? imageBefore;
  String? imageAfter;
  String? contentAfter;
  String? location;
  String? serialNo;
  String? summaryBug;
  String? realName;

  SubJobAssgined(
      {this.id,
      this.reporterId,
      this.priority,
      this.severity,
      this.profileId,
      this.viewState,
      this.summary,
      this.dateSubmitted,
      this.bugId,
      this.status,
      this.resolution,
      this.projection,
      this.categoryId,
      this.projectId,
      this.handlerId,
      this.reproducibility,
      this.dueDate,
      this.lastUpdated,
      this.description,
      this.timeStart,
      this.timeEnd,
      this.comment,
      this.contentBefore,
      this.imageBefore,
      this.imageAfter,
      this.contentAfter,
      this.location,
      this.serialNo,
      this.summaryBug,
      this.realName});

  SubJobAssgined.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporterId = json['reportjob_id'];
    priority = json['priority'];
    severity = json['severity'];
    profileId = json['profile_id'];
    viewState = json['view_state'];
    summary = json['summary'];
    dateSubmitted = json['date_submitted'];
    bugId = json['bug_id'];
    status = json['status'];
    resolution = json['resolution'];
    projection = json['projection'];
    categoryId = json['category_id'];
    projectId = json['project_id'];
    handlerId = json['handler_id'];
    reproducibility = json['reproducibility'];
    dueDate = json['due_date'];
    lastUpdated = json['last_updated'];
    description = json['description'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    comment = json['comment'];
    contentBefore = json['content_before'];
    imageBefore = json['image_before'];
    imageAfter = json['image_after'];
    contentAfter = json['content_after'];
    summaryBug = json['summary_bug'];
    realName = json['realname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reporter_id'] = reporterId;
    data['priority'] = priority;
    data['severity'] = severity;
    data['profile_id'] = profileId;
    data['view_state'] = viewState;
    data['summary'] = summary;
    data['date_submitted'] = dateSubmitted;
    data['bug_id'] = bugId;
    data['status'] = status;
    data['resolution'] = resolution;
    data['projection'] = projection;
    data['category_id'] = categoryId;
    data['project_id'] = projectId;
    data['handler_id'] = handlerId;
    data['reproducibility'] = reproducibility;
    data['due_date'] = dueDate;
    data['last_updated'] = lastUpdated;
    data['description'] = description;
    data['time_start'] = timeStart;
    data['time_end'] = timeEnd;
    data['comment'] = comment;
    data['content_before'] = contentBefore;
    data['image_before'] = imageBefore;
    data['image_after'] = imageAfter;
    data['content_after'] = contentAfter;
    data['summary_bug'] = summaryBug;
    data['realname'] = realName;
    return data;
  }
}
