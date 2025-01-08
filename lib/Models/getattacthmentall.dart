class GetAttatchmentAllModel {
  List<Files>? files;

  GetAttatchmentAllModel({this.files});

  GetAttatchmentAllModel.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  int? id;
  Reporter? reporter;
  String? createdAt;
  String? filename;
  int? size;
  String? contentType;
  String? imageUrl;
  String? content;

  Files(
      {this.id,
      this.reporter,
      this.createdAt,
      this.filename,
      this.size,
      this.contentType,
      this.imageUrl,
      this.content});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporter =
        json['reporter'] != null ? Reporter.fromJson(json['reporter']) : null;
    createdAt = json['created_at'];
    filename = json['filename'];
    size = json['size'];
    contentType = json['content_type'];
    imageUrl = json['image_url'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (reporter != null) {
      data['reporter'] = reporter!.toJson();
    }
    data['created_at'] = createdAt;
    data['filename'] = filename;
    data['size'] = size;
    data['content_type'] = contentType;
    data['image_url'] = imageUrl;
    data['content'] = content;
    return data;
  }
}

class Reporter {
  int? id;
  String? name;
  String? realName;
  String? email;
  String? techLevel;
  String? companyId;

  Reporter(
      {this.id,
      this.name,
      this.realName,
      this.email,
      this.techLevel,
      this.companyId});

  Reporter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    realName = json['real_name'];
    email = json['email'];
    techLevel = json['tech_level'];
    companyId = json['company_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['real_name'] = realName;
    data['email'] = email;
    data['tech_level'] = techLevel;
    data['company_id'] = companyId;
    return data;
  }
}
