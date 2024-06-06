class SubTicketModel {
  List<Jobs>? jobs;

  SubTicketModel({this.jobs});

  SubTicketModel.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  String? bugId;
  String? jobId;
  String? summary;
  String? description;
  Reporter? reporter;
  Status? status;
  Priority? priority;

  Jobs(
      {this.bugId,
      this.jobId,
      this.summary,
      this.description,
      this.reporter,
      this.status,
      this.priority});

  Jobs.fromJson(Map<String, dynamic> json) {
    bugId = json['bug_id'];
    jobId = json['job_id'];
    summary = json['summary'];
    description = json['description'];
    reporter =
        json['reporter'] != null ? Reporter.fromJson(json['reporter']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    priority =
        json['priority'] != null ? Priority.fromJson(json['priority']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bug_id'] = bugId;
    data['job_id'] = jobId;
    data['summary'] = summary;
    data['description'] = description;
    if (reporter != null) {
      data['reporter'] = reporter!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (priority != null) {
      data['priority'] = priority!.toJson();
    }
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

class Priority {
  int? id;
  String? name;
  String? label;

  Priority({this.id, this.name, this.label});

  Priority.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['label'] = label;
    return data;
  }
}
