class PmJobComment {
  String? comment;

  PmJobComment({this.comment});

  PmJobComment.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    return data;
  }
}
