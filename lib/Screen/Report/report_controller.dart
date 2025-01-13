import 'package:get/get.dart';
import 'package:toyotamobile/Function/ticketdata.dart';
import 'package:toyotamobile/Models/techreport_model.dart';
import 'package:toyotamobile/Models/userallsales_model.dart';
import 'package:toyotamobile/Screen/Home/home_controller.dart';
import 'package:toyotamobile/Widget/chart_widget.dart';

class ReportController extends GetxController {
  final HomeController jobController = Get.put(HomeController());
  var techReport = <TechReportModel>[].obs;
  var usersAllTech = <UsersSales>[].obs;
  var selectedYear = Rx<int?>(null);
  var selectedTech = Rx<int?>(null);
  late List<int> years;
  final chartData = <ChartData>[];
  final chartData2 = <ChartData>[];
  final chartData3 = <ChartData2>[];
  Map<int, String> months = {
    1: 'JAN',
    2: 'FEB',
    3: 'MAR',
    4: 'APR',
    5: 'MAY',
    6: 'JUN',
    7: 'JUL',
    8: 'AUG',
    9: 'SEP',
    10: 'OCT',
    11: 'NOV',
    12: 'DEC',
  };

  @override
  void onInit() async {
    super.onInit();
    int currentYear = DateTime.now().year;
    years = List.generate(6, (index) => currentYear - index);
    selectedYear.value = currentYear;
    await fetchAllTech(usersAllTech);
    await fetchTechReport(
        techReport, jobController.handlerIdTech.value, currentYear);
    if (techReport.isNotEmpty) {
      await fetchChart(techReport);
    }
  }

  Future<void> updateYear(int? year) async {
    selectedYear.value = year;
    if (selectedTech.value != null) {
      await fetchTechReport(
          techReport, selectedTech.value.toString(), selectedYear.value ?? 0);
    } else {
      await fetchTechReport(techReport, jobController.handlerIdTech.value,
          selectedYear.value ?? 0);
    }
    fetchChart(techReport);
    techReport.refresh();
  }

  Future<void> updateTech(int? techId) async {
    selectedTech.value = techId;
    await fetchTechReport(
        techReport, techId.toString(), selectedYear.value ?? 0);
    fetchChart(techReport);
    techReport.refresh();
  }

  Future<void> resetFilter() async {
    int currentYear = DateTime.now().year;
    selectedYear.value = currentYear;
    await fetchTechReport(
        techReport, jobController.handlerIdTech.value, selectedYear.value ?? 0);
    fetchChart(techReport);
    techReport.refresh();
    selectedTech.value = null;
  }

  Future<void> fetchChart(RxList<TechReportModel> techReport) async {
    if (techReport.isNotEmpty) {
      var reportData = techReport.first;
      chartData.assignAll([
        ChartData('OTHER', double.parse(reportData.workloadOther ?? '0')),
        ChartData('CO', double.parse(reportData.workloadCommissioning ?? '0')),
        ChartData('STD-BY', double.parse(reportData.workloadStdBy ?? '0')),
        ChartData('REPAIR', double.parse(reportData.workloadRepair ?? '0')),
        ChartData('INSPECT', double.parse(reportData.workloadInspect ?? '0')),
        ChartData('PM', double.parse(reportData.workloadPm ?? '0')),
      ]);
      chartData2.assignAll([
        ChartData('LTR', double.parse(reportData.workloadLtr ?? '0')),
        ChartData('STR', double.parse(reportData.workloadStr ?? '0')),
        ChartData('SA', double.parse(reportData.workloadSa ?? '0')),
        ChartData('FS', double.parse(reportData.workloadFs ?? '0')),
        ChartData('WARR', double.parse(reportData.workloadWarr ?? '0')),
        ChartData('OTHER', double.parse(reportData.workloadOther ?? '0')),
      ]);
      chartData3
          .assignAll(reportData.dataHoursJobs!.asMap().entries.map((entry) {
        int index = entry.key;
        var job = entry.value;

        String month = months[index + 1]!;
        int totalJobs =
            int.parse(reportData.historyHoursJobs![index].totalJobs ?? '0');
        int totalDurationHours = int.parse(
            reportData.historyHoursJobs![index].totalDurationHours ?? '0');
        int designCapacityHour = int.parse(job.designCapacityHour ?? '0');
        int targetHour = int.parse(job.targetHour ?? '0');
        int actualHour = int.parse(
                reportData.historyHoursJobs![index].totalJobs ?? '0') +
            int.parse(
                reportData.historyHoursJobs![index].totalDurationHours ?? '0');

        return ChartData2(
          '${job.year} $month',
          totalJobs,
          totalDurationHours,
          designCapacityHour,
          targetHour,
          actualHour,
        );
      }).toList());
    }
  }
}
