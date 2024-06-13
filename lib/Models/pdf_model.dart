class PdfModel {
  List<Pdfs>? pdfs;

  PdfModel({this.pdfs});

  PdfModel.fromJson(Map<String, dynamic> json) {
    if (json['pdfs'] != null) {
      pdfs = <Pdfs>[];
      json['pdfs'].forEach((v) {
        pdfs!.add(Pdfs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pdfs != null) {
      data['pdfs'] = pdfs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pdfs {
  int? id;
  String? bugId;
  String? createdAt;
  String? filename;
  String? filepath;
  String? fileType;
  String? content;

  Pdfs(
      {this.id,
      this.bugId,
      this.createdAt,
      this.filename,
      this.filepath,
      this.fileType,
      this.content});

  Pdfs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bugId = json['bug_id'];
    createdAt = json['created_at'];
    filename = json['filename'];
    filepath = json['filepath'];
    fileType = json['file_type'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bug_id'] = bugId;
    data['created_at'] = createdAt;
    data['filename'] = filename;
    data['filepath'] = filepath;
    data['file_type'] = fileType;
    data['content'] = content;
    return data;
  }
}
