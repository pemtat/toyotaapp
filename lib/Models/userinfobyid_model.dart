class UserById {
  List<Users>? users;

  UserById({this.users});

  UserById.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
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
  String? phoneNo;
  String? zone;
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
      this.resourceNo,
      this.phoneNo,
      this.zone});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    realName = json['real_name'];
    email = json['email'];
    language = json['language'];
    timezone = json['timezone'];
    accessLevel = json['access_level'] != null
        ? AccessLevel.fromJson(json['access_level'])
        : null;
    createdAt = json['created_at'];
    companyId = json['company_id'];
    resourceNo = json['resource_no'];
    phoneNo = json['phone_no'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['real_name'] = realName;
    data['email'] = email;
    data['language'] = language;
    data['timezone'] = timezone;
    if (accessLevel != null) {
      data['access_level'] = accessLevel!.toJson();
    }
    data['created_at'] = createdAt;
    data['company_id'] = companyId;
    data['resource_no'] = resourceNo;
    data['phone_no'] = phoneNo;
    data['zone'] = zone;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['label'] = label;
    return data;
  }
}
