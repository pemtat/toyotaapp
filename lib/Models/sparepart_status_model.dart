class SparepartStatusModel {
  int? pending;
  int? onProcess;
  int? reject;

  SparepartStatusModel({this.pending, this.onProcess, this.reject});

  SparepartStatusModel.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    onProcess = json['on_process'];
    reject = json['reject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = pending;
    data['on_process'] = onProcess;
    data['reject'] = reject;
    return data;
  }
}
