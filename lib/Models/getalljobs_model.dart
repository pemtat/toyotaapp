class GetAllJobs {
  List<ClosedIssues>? allIssues;

  GetAllJobs({this.allIssues});

  GetAllJobs.fromJson(Map<String, dynamic> json) {
    if (json['issues'] != null) {
      allIssues = <ClosedIssues>[];
      json['issues'].forEach((v) {
        allIssues!.add(ClosedIssues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allIssues != null) {
      data['issues'] = allIssues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClosedIssues {
  int? id;
  String? summary;
  String? description;
  Project? project;
  Project? category;
  Reporter? reporter;
  Status? status;
  Resolution? resolution;
  Resolution? viewState;
  Resolution? priority;
  Resolution? severity;
  Resolution? reproducibility;
  Resolution? eta;
  bool? sticky;
  String? createdAt;
  String? updatedAt;
  List<Attachments>? attachments;
  List<History>? history;
  Project? version;
  Reporter? handler;
  String? dueDate;
  List<Notes>? notes;
  Project? targetVersion;
  Project? fixedInVersion;

  ClosedIssues(
      {this.id,
      this.summary,
      this.description,
      this.project,
      this.category,
      this.reporter,
      this.status,
      this.resolution,
      this.viewState,
      this.priority,
      this.severity,
      this.reproducibility,
      this.eta,
      this.sticky,
      this.createdAt,
      this.updatedAt,
      this.attachments,
      this.history,
      this.version,
      this.handler,
      this.dueDate,
      this.notes,
      this.targetVersion,
      this.fixedInVersion});

  ClosedIssues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    summary = json['summary'];
    description = json['description'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    category =
        json['category'] != null ? Project.fromJson(json['category']) : null;
    reporter =
        json['reporter'] != null ? Reporter.fromJson(json['reporter']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    resolution = json['resolution'] != null
        ? Resolution.fromJson(json['resolution'])
        : null;
    viewState = json['view_state'] != null
        ? Resolution.fromJson(json['view_state'])
        : null;
    priority =
        json['priority'] != null ? Resolution.fromJson(json['priority']) : null;
    severity =
        json['severity'] != null ? Resolution.fromJson(json['severity']) : null;
    reproducibility = json['reproducibility'] != null
        ? Resolution.fromJson(json['reproducibility'])
        : null;
    eta = json['eta'] != null ? Resolution.fromJson(json['eta']) : null;
    sticky = json['sticky'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
    version =
        json['version'] != null ? Project.fromJson(json['version']) : null;
    handler =
        json['handler'] != null ? Reporter.fromJson(json['handler']) : null;
    dueDate = json['due_date'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(Notes.fromJson(v));
      });
    }
    targetVersion = json['target_version'] != null
        ? Project.fromJson(json['target_version'])
        : null;
    fixedInVersion = json['fixed_in_version'] != null
        ? Project.fromJson(json['fixed_in_version'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['summary'] = summary;
    data['description'] = description;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (reporter != null) {
      data['reporter'] = reporter!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (resolution != null) {
      data['resolution'] = resolution!.toJson();
    }
    if (viewState != null) {
      data['view_state'] = viewState!.toJson();
    }
    if (priority != null) {
      data['priority'] = priority!.toJson();
    }
    if (severity != null) {
      data['severity'] = severity!.toJson();
    }
    if (reproducibility != null) {
      data['reproducibility'] = reproducibility!.toJson();
    }
    if (eta != null) {
      data['eta'] = eta!.toJson();
    }
    data['sticky'] = sticky;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    if (version != null) {
      data['version'] = version!.toJson();
    }
    if (handler != null) {
      data['handler'] = handler!.toJson();
    }
    data['due_date'] = dueDate;
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    if (targetVersion != null) {
      data['target_version'] = targetVersion!.toJson();
    }
    if (fixedInVersion != null) {
      data['fixed_in_version'] = fixedInVersion!.toJson();
    }
    return data;
  }
}

class Project {
  int? id;
  String? name;

  Project({this.id, this.name});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Reporter {
  int? id;
  String? name;
  String? realName;
  String? email;

  Reporter({this.id, this.name, this.realName, this.email});

  Reporter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    realName = json['real_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['real_name'] = realName;
    data['email'] = email;
    return data;
  }
}

class Status {
  int? id;
  String? name;
  String? label;
  String? color;

  Status({this.id, this.name, this.label, this.color});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['label'] = label;
    data['color'] = color;
    return data;
  }
}

class Resolution {
  int? id;
  String? name;
  String? label;

  Resolution({this.id, this.name, this.label});

  Resolution.fromJson(Map<String, dynamic> json) {
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

class Attachments {
  int? id;
  Reporter? reporter;
  String? createdAt;
  String? filename;
  int? size;
  String? contentType;

  Attachments(
      {this.id,
      this.reporter,
      this.createdAt,
      this.filename,
      this.size,
      this.contentType});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporter =
        json['reporter'] != null ? Reporter.fromJson(json['reporter']) : null;
    createdAt = json['created_at'];
    filename = json['filename'];
    size = json['size'];
    contentType = json['content_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (reporter != null) {
      data['reporter'] = reporter!.toJson();
    }
    data['created_at'] = createdAt;
    data['filename'] = filename;
    data['size'] = size;
    data['content_type'] = contentType;
    return data;
  }
}

class History {
  String? createdAt;
  Reporter? user;
  Project? type;
  String? message;
  File? file;
  Field? field;
  OldValue? oldValue;
  OldValue? newValue;
  String? change;
  Note? note;

  History(
      {this.createdAt,
      this.user,
      this.type,
      this.message,
      this.file,
      this.field,
      this.oldValue,
      this.newValue,
      this.change,
      this.note});

  History.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    user = json['user'] != null ? Reporter.fromJson(json['user']) : null;
    type = json['type'] != null ? Project.fromJson(json['type']) : null;
    message = json['message'];
    file = json['file'] != null ? File.fromJson(json['file']) : null;
    field = json['field'] != null ? Field.fromJson(json['field']) : null;
    oldValue =
        json['old_value'] != null ? OldValue.fromJson(json['old_value']) : null;
    newValue =
        json['new_value'] != null ? OldValue.fromJson(json['new_value']) : null;
    change = json['change'];
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    data['message'] = message;
    if (file != null) {
      data['file'] = file!.toJson();
    }
    if (field != null) {
      data['field'] = field!.toJson();
    }
    if (oldValue != null) {
      data['old_value'] = oldValue!.toJson();
    }
    if (newValue != null) {
      data['new_value'] = newValue!.toJson();
    }
    data['change'] = change;
    if (note != null) {
      data['note'] = note!.toJson();
    }
    return data;
  }
}

class File {
  int? id;
  String? filename;

  File({this.id, this.filename});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filename'] = filename;
    return data;
  }
}

class Field {
  String? name;
  String? label;

  Field({this.name, this.label});

  Field.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['label'] = label;
    return data;
  }
}

class OldValue {
  int? id;
  String? name;
  String? label;
  String? color;
  String? realName;
  String? email;

  OldValue(
      {this.id, this.name, this.label, this.color, this.realName, this.email});

  OldValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
    color = json['color'];
    realName = json['real_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['label'] = label;
    data['color'] = color;
    data['real_name'] = realName;
    data['email'] = email;
    return data;
  }
}

class Note {
  int? id;

  Note({this.id});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Notes {
  int? id;
  Reporter? reporter;
  String? text;
  Resolution? viewState;
  List<Attachments>? attachments;
  String? type;
  String? createdAt;
  String? updatedAt;

  Notes(
      {this.id,
      this.reporter,
      this.text,
      this.viewState,
      this.attachments,
      this.type,
      this.createdAt,
      this.updatedAt});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporter =
        json['reporter'] != null ? Reporter.fromJson(json['reporter']) : null;
    text = json['text'];
    viewState = json['view_state'] != null
        ? Resolution.fromJson(json['view_state'])
        : null;
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (reporter != null) {
      data['reporter'] = reporter!.toJson();
    }
    data['text'] = text;
    if (viewState != null) {
      data['view_state'] = viewState!.toJson();
    }
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
