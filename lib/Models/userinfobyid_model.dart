class UserById {
  List<Users>? users;

  UserById({this.users});

  UserById.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? realName;
  String? email;
  String? language;
  String? timezone;
  AccessLevel? accessLevel;
  String? createdAt;
  String? companyId;
  String? resourceNo;

  Users(
      {this.id,
      this.name,
      this.realName,
      this.email,
      this.language,
      this.timezone,
      this.accessLevel,
      this.createdAt,
      this.companyId,
      this.resourceNo});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    realName = json['real_name'];
    email = json['email'];
    language = json['language'];
    timezone = json['timezone'];
    accessLevel = json['access_level'] != null
        ? new AccessLevel.fromJson(json['access_level'])
        : null;
    createdAt = json['created_at'];
    companyId = json['company_id'];
    resourceNo = json['resource_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['real_name'] = this.realName;
    data['email'] = this.email;
    data['language'] = this.language;
    data['timezone'] = this.timezone;
    if (this.accessLevel != null) {
      data['access_level'] = this.accessLevel!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['company_id'] = this.companyId;
    data['resource_no'] = this.resourceNo;
    return data;
  }
}

class AccessLevel {
  int? id;
  String? name;
  String? label;

  AccessLevel({this.id, this.name, this.label});

  AccessLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['label'] = this.label;
    return data;
  }
}
