class TechReportModel {
  String? inspectionTotal;
  String? inspectionIntime;
  String? inspectionLate;
  String? inspectionInprogress;
  String? inspectionPending;
  String? poTotal;
  String? poIntime;
  String? poLate;
  String? poInprogress;
  String? poPending;
  String? poWaitingPart;
  String? focTotal;
  String? focFinished;
  String? focPending;
  String? pmTotal;
  String? pmIntime;
  String? pmLate;
  String? pmPending;
  String? workloadInspect;
  String? workloadRepair;
  String? workloadOther;
  String? workloadCommissioning;
  String? workloadPm;
  String? workloadStdBy;
  String? workloadLtr;
  String? workloadStr;
  String? workloadSa;
  String? workloadFs;
  String? workloadWarr;
  List<DataHoursJobs>? dataHoursJobs;
  List<HistoryHoursJobs>? historyHoursJobs;

  TechReportModel(
      {this.inspectionTotal,
      this.inspectionIntime,
      this.inspectionLate,
      this.inspectionInprogress,
      this.inspectionPending,
      this.poTotal,
      this.poIntime,
      this.poLate,
      this.poInprogress,
      this.poPending,
      this.poWaitingPart,
      this.focTotal,
      this.focFinished,
      this.focPending,
      this.pmTotal,
      this.pmIntime,
      this.pmLate,
      this.pmPending,
      this.workloadInspect,
      this.workloadRepair,
      this.workloadOther,
      this.workloadCommissioning,
      this.workloadPm,
      this.workloadStdBy,
      this.workloadLtr,
      this.workloadStr,
      this.workloadSa,
      this.workloadFs,
      this.workloadWarr,
      this.dataHoursJobs,
      this.historyHoursJobs});

  TechReportModel.fromJson(Map<String, dynamic> json) {
    inspectionTotal = json['inspection_total'];
    inspectionIntime = json['inspection_intime'];
    inspectionLate = json['inspection_late'];
    inspectionInprogress = json['inspection_inprogress'];
    inspectionPending = json['inspection_pending'];
    poTotal = json['po_total'];
    poIntime = json['po_intime'];
    poLate = json['po_late'];
    poInprogress = json['po_inprogress'];
    poPending = json['po_pending'];
    poWaitingPart = json['po_waiting_part'];
    focTotal = json['foc_total'];
    focFinished = json['foc_finished'];
    focPending = json['foc_pending'];
    pmTotal = json['pm_total'];
    pmIntime = json['pm_intime'];
    pmLate = json['pm_late'];
    pmPending = json['pm_pending'];
    workloadInspect = json['workload_inspect'];
    workloadRepair = json['workload_repair'];
    workloadOther = json['workload_other'];
    workloadCommissioning = json['workload_commissioning'];
    workloadPm = json['workload_pm'];
    workloadStdBy = json['workload_std_by'];
    workloadLtr = json['workload_ltr'];
    workloadStr = json['workload_str'];
    workloadSa = json['workload_sa'];
    workloadFs = json['workload_fs'];
    workloadWarr = json['workload_warr'];
    if (json['data_hours_jobs'] != null) {
      dataHoursJobs = <DataHoursJobs>[];
      json['data_hours_jobs'].forEach((v) {
        dataHoursJobs!.add(DataHoursJobs.fromJson(v));
      });
    }
    if (json['history_hours_jobs'] != null) {
      historyHoursJobs = <HistoryHoursJobs>[];
      json['history_hours_jobs'].forEach((v) {
        historyHoursJobs!.add(HistoryHoursJobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inspection_total'] = inspectionTotal;
    data['inspection_intime'] = inspectionIntime;
    data['inspection_late'] = inspectionLate;
    data['inspection_inprogress'] = inspectionInprogress;
    data['inspection_pending'] = inspectionPending;
    data['po_total'] = poTotal;
    data['po_intime'] = poIntime;
    data['po_late'] = poLate;
    data['po_inprogress'] = poInprogress;
    data['po_pending'] = poPending;
    data['po_waiting_part'] = poWaitingPart;
    data['foc_total'] = focTotal;
    data['foc_finished'] = focFinished;
    data['foc_pending'] = focPending;
    data['pm_total'] = pmTotal;
    data['pm_intime'] = pmIntime;
    data['pm_late'] = pmLate;
    data['pm_pending'] = pmPending;
    data['workload_inspect'] = workloadInspect;
    data['workload_repair'] = workloadRepair;
    data['workload_other'] = workloadOther;
    data['workload_commissioning'] = workloadCommissioning;
    data['workload_pm'] = workloadPm;
    data['workload_std_by'] = workloadStdBy;
    data['workload_ltr'] = workloadLtr;
    data['workload_str'] = workloadStr;
    data['workload_sa'] = workloadSa;
    data['workload_fs'] = workloadFs;
    data['workload_warr'] = workloadWarr;
    if (dataHoursJobs != null) {
      data['data_hours_jobs'] = dataHoursJobs!.map((v) => v.toJson()).toList();
    }
    if (historyHoursJobs != null) {
      data['history_hours_jobs'] =
          historyHoursJobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataHoursJobs {
  String? id;
  String? designCapacityHour;
  String? targetHour;
  String? createdAt;
  String? lastUpdated;
  String? year;

  DataHoursJobs(
      {this.id,
      this.designCapacityHour,
      this.targetHour,
      this.createdAt,
      this.lastUpdated,
      this.year});

  DataHoursJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designCapacityHour = json['design_capacity_hour'];
    targetHour = json['target_hour'];
    createdAt = json['created_at'];
    lastUpdated = json['last_updated'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['design_capacity_hour'] = designCapacityHour;
    data['target_hour'] = targetHour;
    data['created_at'] = createdAt;
    data['last_updated'] = lastUpdated;
    data['year'] = year;
    return data;
  }
}

class HistoryHoursJobs {
  String? month;
  String? totalJobs;
  String? totalDurationHours;

  HistoryHoursJobs({this.month, this.totalJobs, this.totalDurationHours});

  HistoryHoursJobs.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalJobs = json['total_jobs'];
    totalDurationHours = json['total_duration_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['total_jobs'] = totalJobs;
    data['total_duration_hours'] = totalDurationHours;
    return data;
  }
}
