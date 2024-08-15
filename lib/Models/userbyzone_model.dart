class UserByZone {
  List<UsersZone>? users;

  UserByZone({this.users});

  UserByZone.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <UsersZone>[];
      json['users'].forEach((v) {
        users!.add(new UsersZone.fromJson(v));
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

class UsersZone {
  String? username;
  String? realname;
  String? zone;

  UsersZone({this.username, this.realname, this.zone});

  UsersZone.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    realname = json['realname'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['realname'] = this.realname;
    data['zone'] = this.zone;
    return data;
  }
}
