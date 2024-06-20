class User {
  // ignore: non_constant_identifier_names
  List<User>? Users;

  final int id;
  final String name;
  final String realName;
  final String email;
  final String language;
  final String timezone;
  final AccessLevel accessLevel;
  final DateTime createdAt;
  final List<Project> projects;
  final String companyId;
  final String resourceNo;
  User(
      {required this.id,
      required this.name,
      required this.realName,
      required this.email,
      required this.language,
      required this.timezone,
      required this.accessLevel,
      required this.createdAt,
      required this.projects,
      required this.companyId,
      required this.resourceNo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      realName: json['real_name'] ?? '',
      email: json['email'] ?? '',
      language: json['language'] ?? '',
      timezone: json['timezone'] ?? '',
      accessLevel: AccessLevel.fromJson(json['access_level'] ?? {}),
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      projects: (json['projects'] as List<dynamic>?)
              ?.map((projectJson) => Project.fromJson(projectJson))
              .toList() ??
          [],
      companyId: json['company_id'] ?? '',
      resourceNo: json['resource_no'] ?? '',
    );
  }
}

class AccessLevel {
  final int id;
  final String name;
  final String label;

  AccessLevel({
    required this.id,
    required this.name,
    required this.label,
  });

  factory AccessLevel.fromJson(Map<String, dynamic> json) {
    return AccessLevel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      label: json['label'] ?? '',
    );
  }
}

class Project {
  final int id;
  final String name;

  Project({
    required this.id,
    required this.name,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
