class Versions {
  String? id;
  String? appVersionPlaystore;
  String? appVersionAppstore;
  String? mantisVersion;
  String? webVersion;
  bool? status;
  bool? priorityLevel;
  String? createdAt;

  Versions(
      {this.id,
      this.appVersionPlaystore,
      this.appVersionAppstore,
      this.mantisVersion,
      this.webVersion,
      this.status,
      this.priorityLevel,
      this.createdAt});

  Versions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appVersionPlaystore = json['app_version_playstore'];
    appVersionAppstore = json['app_version_appstore'];
    mantisVersion = json['mantis_version'];
    webVersion = json['web_version'];
    status = json['status'];
    priorityLevel = json['priority_level'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['app_version_playstore'] = appVersionPlaystore;
    data['app_version_appstore'] = appVersionAppstore;
    data['mantis_version'] = mantisVersion;
    data['web_version'] = webVersion;
    data['status'] = status;
    data['priority_level'] = priorityLevel;
    data['created_at'] = createdAt;
    return data;
  }
}
