class Subjob {
  List<Subjobs>? subjobs;

  Subjob({this.subjobs});

  Subjob.fromJson(Map<String, dynamic> json) {
    if (json['subjobs'] != null) {
      subjobs = <Subjobs>[];
      json['subjobs'].forEach((v) {
        subjobs!.add(Subjobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjobs != null) {
      data['subjobs'] = subjobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjobs {
  int? id;
  int? projectId;
  Reporter? reporter;
  int? handlerId;
  int? duplicateId;
  int? priority;
  int? severity;
  int? reproducibility;
  Status? status;
  String? techStatus;
  String? techRemark;
  int? resolution;
  int? projection;
  int? categoryId;
  String? createdAt;
  int? viewState;
  String? summary;
  bool? sticky;
  int? dueDate;
  int? profileId;
  String? description;

  Subjobs(
      {this.id,
      this.projectId,
      this.reporter,
      this.handlerId,
      this.duplicateId,
      this.priority,
      this.severity,
      this.reproducibility,
      this.status,
      this.techStatus,
      this.techRemark,
      this.resolution,
      this.projection,
      this.categoryId,
      this.createdAt,
      this.viewState,
      this.summary,
      this.sticky,
      this.dueDate,
      this.profileId,
      this.description});

  Subjobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    reporter =
        json['reporter'] != null ? Reporter.fromJson(json['reporter']) : null;
    handlerId = json['handler_id'];
    duplicateId = json['duplicate_id'];
    priority = json['priority'];
    severity = json['severity'];
    reproducibility = json['reproducibility'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    techStatus = json['tech_status'];
    techRemark = json['tech_remark'];
    resolution = json['resolution'];
    projection = json['projection'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    viewState = json['view_state'];
    summary = json['summary'];
    sticky = json['sticky'];
    dueDate = json['due_date'];
    profileId = json['profile_id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    if (reporter != null) {
      data['reporter'] = reporter!.toJson();
    }
    data['handler_id'] = handlerId;
    data['duplicate_id'] = duplicateId;
    data['priority'] = priority;
    data['severity'] = severity;
    data['reproducibility'] = reproducibility;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['tech_status'] = techStatus;
    data['tech_remark'] = techRemark;
    data['resolution'] = resolution;
    data['projection'] = projection;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['view_state'] = viewState;
    data['summary'] = summary;
    data['sticky'] = sticky;
    data['due_date'] = dueDate;
    data['profile_id'] = profileId;
    data['description'] = description;
    return data;
  }
}

class Reporter {
  int? id;
  String? name;
  String? realName;
  String? email;

  Reporter({this.id, this.name, this.realName, this.email});

  Reporter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    realName = json['real_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['real_name'] = realName;
    data['email'] = email;
    return data;
  }
}

class Status {
  int? id;
  String? name;
  String? label;
  String? color;

  Status({this.id, this.name, this.label, this.color});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['label'] = label;
    data['color'] = color;
    return data;
  }
}
