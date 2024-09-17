class UserAllSales {
  List<UsersSales>? users;

  UserAllSales({this.users});

  UserAllSales.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <UsersSales>[];
      json['users'].forEach((v) {
        users!.add(new UsersSales.fromJson(v));
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

class UsersSales {
  String? id;
  String? username;
  String? realname;
  String? zone;

  UsersSales({this.username, this.realname, this.zone});

  UsersSales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    realname = json['realname'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['realname'] = this.realname;
    data['zone'] = this.zone;
    return data;
  }
}
