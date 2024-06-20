class Subjob {
  List<Subjobs>? subjobs;

  Subjob({this.subjobs});

  Subjob.fromJson(Map<String, dynamic> json) {
    if (json['subjobs'] != null) {
      subjobs = <Subjobs>[];
      json['subjobs'].forEach((v) {
        subjobs!.add(new Subjobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjobs != null) {
      data['subjobs'] = this.subjobs!.map((v) => v.toJson()).toList();
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
    reporter = json['reporter'] != null
        ? new Reporter.fromJson(json['reporter'])
        : null;
    handlerId = json['handler_id'];
    duplicateId = json['duplicate_id'];
    priority = json['priority'];
    severity = json['severity'];
    reproducibility = json['reproducibility'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    if (this.reporter != null) {
      data['reporter'] = this.reporter!.toJson();
    }
    data['handler_id'] = this.handlerId;
    data['duplicate_id'] = this.duplicateId;
    data['priority'] = this.priority;
    data['severity'] = this.severity;
    data['reproducibility'] = this.reproducibility;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['resolution'] = this.resolution;
    data['projection'] = this.projection;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['view_state'] = this.viewState;
    data['summary'] = this.summary;
    data['sticky'] = this.sticky;
    data['due_date'] = this.dueDate;
    data['profile_id'] = this.profileId;
    data['description'] = this.description;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['real_name'] = this.realName;
    data['email'] = this.email;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['label'] = this.label;
    data['color'] = this.color;
    return data;
  }
}
