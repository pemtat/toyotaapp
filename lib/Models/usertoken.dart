class UserToken {
  String? id;
  String? userId;
  String? token;
  String? deviceId;
  String? createdAt;
  String? deviceType;
  String? appVersion;

  UserToken(
      {this.id,
      this.userId,
      this.token,
      this.deviceId,
      this.createdAt,
      this.deviceType,
      this.appVersion});

  UserToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    token = json['token'];
    deviceId = json['device_id'];
    createdAt = json['created_at'];
    deviceType = json['device_type'];
    appVersion = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['token'] = token;
    data['device_id'] = deviceId;
    data['created_at'] = createdAt;
    data['device_type'] = deviceType;
    data['app_version'] = appVersion;
    return data;
  }
}
