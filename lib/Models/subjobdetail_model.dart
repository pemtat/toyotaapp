class SubJobDetail {
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
  String? imageBefore;
  String? contentBefore;
  String? imageAfter;
  String? contentAfter;

  String? comment;

  SubJobDetail(
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
      this.contentBefore,
      this.contentAfter,
      this.imageBefore,
      this.imageAfter,
      this.comment});

  SubJobDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporterId = json['reporter_id'];
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
    imageBefore = json['image_before'];
    contentBefore = json['content_before'];
    imageAfter = json['image_after'];
    contentAfter = json['content_after'];
    comment = json['comment'];
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
    data['image_before'] = imageBefore;
    data['content_before'] = contentBefore;
    data['content_after'] = contentAfter;
    data['image_after'] = imageAfter;
    data['comment'] = comment;
    return data;
  }
}
