class SubJobsAll {
  List<Jobs>? jobs;

  SubJobsAll({this.jobs});

  SubJobsAll.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? bugId;
  String? summary;
  String? description;
  String? reporterId;

  Jobs({this.id, this.bugId, this.summary, this.description, this.reporterId});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bugId = json['bug_id'];
    summary = json['summary'];
    description = json['description'];
    reporterId = json['reporter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bug_id'] = bugId;
    data['summary'] = summary;
    data['description'] = description;
    data['reporter_id'] = reporterId;
    return data;
  }
}
