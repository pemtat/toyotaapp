import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class ChartData {
  final String category;
  final double amount;

  ChartData(this.category, this.amount);
}

class DoughnutChartWithConnectorLines extends StatelessWidget {
  final List<ChartData>? chartData;
  final String title;

  DoughnutChartWithConnectorLines(
      {super.key, required this.title, required this.chartData});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 250,
      child: SfCircularChart(
        title: ChartTitle(
            text: title,
            textStyle: TextStyleList.detail2.copyWith(fontSize: 13),
            alignment: ChartAlignment.near),
        legend: Legend(
          isVisible: true,
          textStyle: TextStyle(fontSize: 13),
          padding: 2,
          itemPadding: 6,
        ),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) =>
                (data.amount / totalAmount) * 100,
            dataLabelMapper: (ChartData data, _) =>
                '${data.category}: ${(data.amount / totalAmount * 100).toStringAsFixed(1)}%',
            dataLabelSettings: DataLabelSettings(
              textStyle: TextStyleList.subdetail1
                  .copyWith(color: black8, fontSize: 12),
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              connectorLineSettings: ConnectorLineSettings(
                length: '10%',
                type: ConnectorType.line,
              ),
            ),
          )
        ],
      ),
    );
  }

  double get totalAmount =>
      chartData!.fold(0, (sum, item) => sum + item.amount); // หาผลรวมทั้งหมด
}

class HorizontalBarChart extends StatelessWidget {
  final List<ChartData>? chartData;
  HorizontalBarChart({super.key, required this.chartData});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 250,
      child: SfCartesianChart(
        // title: ChartTitle(text: 'Monthly Expenses'),
        primaryXAxis: CategoryAxis(
          labelStyle: TextStyleList.subtext3,
          // title: AxisTitle(text: 'Category'),
        ),
        primaryYAxis: NumericAxis(
          labelStyle: TextStyleList.subtext3,
          // title: AxisTitle(text: 'Amount'),
        ),
        series: <CartesianSeries>[
          BarSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.amount,
              dataLabelSettings: DataLabelSettings(
                textStyle: TextStyleList.subdetail1,
                isVisible: true,
              ),
              color: Color.fromARGB(255, 73, 73, 73)),
        ],
      ),
    );
  }
}

class CombinedChart extends StatelessWidget {
  final List<ChartData2> chartData;

  const CombinedChart({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,##0");
    return SfCartesianChart(
      // title: ChartTitle(text: 'Monthly Performance'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      series: <CartesianSeries>[
        // Stacked Column Chart: #OF JOB
        StackedColumnSeries<ChartData2, String>(
          name: '#OF JOB',
          dataSource: chartData,
          xValueMapper: (ChartData2 data, _) => data.month,
          yValueMapper: (ChartData2 data, _) => data.totalJobs,
          color: Colors.black87,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyleList.detailtext1.copyWith(color: white3)),
        ),
        // Stacked Column Chart: HOUR
        StackedColumnSeries<ChartData2, String>(
          name: 'HOUR',
          dataSource: chartData,
          xValueMapper: (ChartData2 data, _) => data.month,
          yValueMapper: (ChartData2 data, _) => data.hour,
          color: Colors.amberAccent,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyleList.detailtext1.copyWith(color: black2)),
        ),
        // Line Chart: Design Capacity Hour
        LineSeries<ChartData2, String>(
          name: 'DESIGN CAPACITY HOUR',
          dataSource: chartData,
          xValueMapper: (ChartData2 data, _) => data.month,
          yValueMapper: (ChartData2 data, _) => data.designCapacityHour,
          markerSettings: MarkerSettings(isVisible: true),
          dataLabelMapper: (ChartData2 data, _) =>
              numberFormat.format(data.designCapacityHour),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
            ),
          ),
          color: Colors.red,
          width: 2,
        ),
        // Line Chart: Target Hour
        LineSeries<ChartData2, String>(
          name: 'TARGET HOUR',
          dataSource: chartData,
          xValueMapper: (ChartData2 data, _) => data.month,
          yValueMapper: (ChartData2 data, _) => data.targetHour,
          markerSettings: MarkerSettings(isVisible: true),
          dataLabelMapper: (ChartData2 data, _) =>
              numberFormat.format(data.targetHour),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
          dashArray: [5, 5],
          color: Colors.grey,
          width: 2,
        ),
        // Line Chart: Actual Hour
        LineSeries<ChartData2, String>(
          name: 'ACTUAL HOUR',
          dataSource: chartData,
          xValueMapper: (ChartData2 data, _) => data.month,
          yValueMapper: (ChartData2 data, _) => data.actualHour,
          markerSettings: MarkerSettings(isVisible: true),
          dashArray: [5, 5],
          color: const Color.fromARGB(255, 169, 132, 1),
          width: 2,
        ),
      ],
    );
  }
}

class ChartData2 {
  ChartData2(this.month, this.totalJobs, this.hour, this.designCapacityHour,
      this.targetHour, this.actualHour);
  final String month;
  final int totalJobs; // Stacked Bar 1
  final int hour; // Stacked Bar 2
  final int designCapacityHour; // Line 1
  final int targetHour; // Line 2
  final int actualHour; // Line 3
}
