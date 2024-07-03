class PMJobInfoModel {
  String? id;
  String? tStart;
  String? tEnd;
  String? comment;
  String? timeStart;
  String? timeEnd;
  List<JobImage>? jobImage;
  List<JobImageStart>? jobImageStart;
  List<JobImageEnd>? jobImageEnd;

  PMJobInfoModel(
      {this.id,
      this.tStart,
      this.tEnd,
      this.comment,
      this.timeStart,
      this.timeEnd,
      this.jobImage,
      this.jobImageStart,
      this.jobImageEnd});

  PMJobInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tStart = json['t_start'];
    tEnd = json['t_end'];
    comment = json['comment'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    if (json['job_image'] != null) {
      jobImage = <JobImage>[];
      json['job_image'].forEach((v) {
        jobImage!.add(JobImage.fromJson(v));
      });
    }
    if (json['job_image_start'] != null) {
      jobImageStart = <JobImageStart>[];
      json['job_image_start'].forEach((v) {
        jobImageStart!.add(JobImageStart.fromJson(v));
      });
    }
    if (json['job_image_end'] != null) {
      jobImageEnd = <JobImageEnd>[];
      json['job_image_end'].forEach((v) {
        jobImageEnd!.add(JobImageEnd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['t_start'] = tStart;
    data['t_end'] = tEnd;
    data['comment'] = comment;
    data['time_start'] = timeStart;
    data['time_end'] = timeEnd;
    if (jobImage != null) {
      data['job_image'] = jobImage!.map((v) => v.toJson()).toList();
    }
    if (jobImageStart != null) {
      data['job_image_start'] = jobImageStart!.map((v) => v.toJson()).toList();
    }
    if (jobImageEnd != null) {
      data['job_image_end'] = jobImageEnd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobImage {
  String? id;
  String? jobCode;
  String? name;
  String? content;
  String? status;
  String? createdBy;
  String? lastUpdated;

  JobImage(
      {this.id,
      this.jobCode,
      this.name,
      this.content,
      this.status,
      this.createdBy,
      this.lastUpdated});

  JobImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobCode = json['job_code'];
    name = json['name'];
    content = json['content'];
    status = json['status'];
    createdBy = json['created_by'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_code'] = jobCode;
    data['name'] = name;
    data['content'] = content;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['last_updated'] = lastUpdated;
    return data;
  }
}

class JobImageStart {
  String? id;
  String? jobCode;
  String? name;
  String? content;
  String? status;
  String? createdBy;
  String? lastUpdated;

  JobImageStart(
      {this.id,
      this.jobCode,
      this.name,
      this.content,
      this.status,
      this.createdBy,
      this.lastUpdated});

  JobImageStart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobCode = json['job_code'];
    name = json['name'];
    content = json['content'];
    status = json['status'];
    createdBy = json['created_by'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_code'] = jobCode;
    data['name'] = name;
    data['content'] = content;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['last_updated'] = lastUpdated;
    return data;
  }
}

class JobImageEnd {
  String? id;
  String? jobCode;
  String? name;
  String? content;
  String? status;
  String? createdBy;
  String? lastUpdated;

  JobImageEnd(
      {this.id,
      this.jobCode,
      this.name,
      this.content,
      this.status,
      this.createdBy,
      this.lastUpdated});

  JobImageEnd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobCode = json['job_code'];
    name = json['name'];
    content = json['content'];
    status = json['status'];
    createdBy = json['created_by'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_code'] = jobCode;
    data['name'] = name;
    data['content'] = content;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
