import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/progressbar_widget.dart.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';

class ReportTitle extends StatelessWidget {
  final String title;
  final int total;
  final int intime;
  final int late;
  final int inProgress;
  final int pending;
  final int closed;
  final int waitingPart;
  final int waitingFsr;
  final String type;
  const ReportTitle({
    super.key,
    required this.title,
    required this.total,
    required this.intime,
    required this.late,
    required this.inProgress,
    required this.pending,
    required this.closed,
    required this.waitingPart,
    required this.waitingFsr,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    int space = 8;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyleList.detail2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 6),
            child: Column(
              children: [
                BoxInfo(
                    title: 'TOTAL',
                    value: '',
                    trailing: ProgressBarWithText(
                        value: total, total: total, label: total)),
                space.kH,
                BoxInfo(
                    title: 'INTIME',
                    value: '',
                    trailing: ProgressBarWithText(
                        value: intime, total: total, label: intime)),
                space.kH,
                BoxInfo(
                    title: 'LATE',
                    value: '',
                    trailing: ProgressBarWithText(
                        value: late, total: total, label: late)),
                space.kH,
                BoxInfo(
                    title: 'IN PROGRESS',
                    value: '',
                    trailing: ProgressBarWithText(
                        value: inProgress, total: total, label: inProgress)),
                space.kH,
                BoxInfo(
                    title: 'PENDING',
                    value: '',
                    trailing: ProgressBarWithText(
                        value: pending, total: total, label: pending)),
                space.kH,
                if (type == 'repairjobs')
                  Column(
                    children: [
                      BoxInfo(
                          title: 'WAITING PART',
                          value: '',
                          trailing: ProgressBarWithText(
                              value: waitingPart,
                              total: total,
                              label: waitingPart)),
                      space.kH,
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReportMiddle extends StatelessWidget {
  final String title;
  final int total;
  final int intime;
  final int late;
  final int pending;
  final int finished;
  final String type;
  const ReportMiddle(
      {super.key,
      required this.title,
      required this.total,
      required this.intime,
      required this.late,
      required this.pending,
      required this.type,
      required this.finished});

  @override
  Widget build(BuildContext context) {
    int space = 8;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyleList.detail2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 6),
            child: Column(
              children: [
                BoxInfo(
                    title: 'TOTAL',
                    value: '',
                    trailing: ProgressBarWithText(
                        value: total, total: total, label: total)),
                space.kH,
                type == 'foc'
                    ? Column(
                        children: [
                          BoxInfo(
                              title: 'FINISHED',
                              value: '',
                              trailing: ProgressBarWithText(
                                  value: finished,
                                  total: total,
                                  label: intime)),
                          space.kH,
                        ],
                      )
                    : Column(
                        children: [
                          BoxInfo(
                              title: 'INTIME',
                              value: '',
                              trailing: ProgressBarWithText(
                                  value: intime, total: total, label: intime)),
                          space.kH,
                          BoxInfo(
                              title: 'LATE',
                              value: '',
                              trailing: ProgressBarWithText(
                                  value: late, total: total, label: intime)),
                          space.kH,
                        ],
                      ),
                BoxInfo(
                    title: 'PENDING',
                    value: '',
                    trailing: ProgressBarWithText(
                        value: pending, total: total, label: intime)),
                space.kH,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReportGraph extends StatelessWidget {
  final String? title;
  final String type;
  const ReportGraph({
    super.key,
    this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    int space = 8;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title ?? '',
              style: TextStyleList.detail2,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 6),
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
