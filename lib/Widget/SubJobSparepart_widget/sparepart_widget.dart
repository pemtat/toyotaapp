import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/EditSparePart/editsparepart_view.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class SparePartDetail extends StatelessWidget {
  final String jobId;
  final String bugId;
  final String techLevel;
  final String techManagerStatus;
  final String? estimateStatus;
  final String projectId;
  final List<Sparepart> sparepart;
  final List<Sparepart> additionalSparepart;
  final List<Sparepart> btrSparepart;
  final List<Sparepart> pvtSparepart;
  const SparePartDetail(
      {super.key,
      required this.additionalSparepart,
      required this.sparepart,
      required this.btrSparepart,
      required this.pvtSparepart,
      required this.jobId,
      required this.bugId,
      required this.projectId,
      required this.techLevel,
      required this.techManagerStatus,
      required this.estimateStatus});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
    return (sparepart.isEmpty || sparepart.first.quantity == '0') &&
            (additionalSparepart.isEmpty ||
                additionalSparepart.first.quantity == '0') &&
            (btrSparepart.isEmpty || btrSparepart.first.quantity == '0') &&
            (pvtSparepart.isEmpty || pvtSparepart.first.quantity == '0')
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Text(
              'ไม่มี Spare Part',
              style: TextStyleList.text5,
            )),
          )
        : SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                // if (techLevel == '1' &&
                //     (estimateStatus == null ||
                //         estimateStatus == '0' ||
                //         estimateStatus == ''))
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       EditButton(onTap: () {
                //         Get.to(() => EditSparePartView(
                //               sparepart: sparepart,
                //               additionalSparepart: additionalSparepart,
                //               btrSparepart: btrSparepart,
                //               pvtSparepart: pvtSparepart,
                //               jobId: jobId,
                //               bugId: bugId,
                //               projectId: projectId,
                //             ));
                //       }),
                //       6.kH,
                //     ],
                //   ),
                if (techLevel == '2' &&
                    techManagerStatus == '0' &&
                    estimateStatus == '1')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EditButton(onTap: () {
                        Get.to(() => EditSparePartView(
                              sparepart: sparepart,
                              additionalSparepart: additionalSparepart,
                              btrSparepart: btrSparepart,
                              pvtSparepart: pvtSparepart,
                              jobId: jobId,
                              bugId: bugId,
                              projectId: projectId,
                            ));
                      }),
                      6.kH,
                    ],
                  ),
                sparepart.isNotEmpty && sparepart.first.quantity != '0'
                    ? Column(
                        children: [
                          6.kH,
                          const AppDivider(),
                          6.kH,
                          Row(
                            children: [
                              Text(
                                'Spare Part List',
                                style: TextStyleList.subtitle4,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                                dataTextStyle: TextStyleList.text9,
                                headingTextStyle: TextStyleList.detail2,
                                horizontalMargin: 0,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  const DataColumn(label: Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: sparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(data.quantity ?? '0'),
                                        const Text('/'),
                                        FutureBuilder<String>(
                                          future: fetchProductsReturnString2(
                                              data.partNumber ?? ''),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child: DataCircleLoading()),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            } else if (snapshot.hasData) {
                                              return Center(
                                                  child: Text(
                                                      snapshot.data ?? '-'));
                                            } else {
                                              return const Center(
                                                  child: Text(
                                                      'No data available'));
                                            }
                                          },
                                        ),
                                      ],
                                    ))),
                                    if (techLevel == '2')
                                      DataCell(Text(formatter.format(
                                          int.parse(data.salesPrice ?? '0')))),
                                  ]);
                                }).toList()),
                          ),
                        ],
                      )
                    : Container(),
                additionalSparepart.isNotEmpty &&
                        additionalSparepart.first.quantity != '0'
                    ? Column(
                        children: [
                          const AppDivider(),
                          10.kH,
                          Row(
                            children: [
                              Text(
                                'Additional Spare Part List',
                                style: TextStyleList.subtitle4,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                                horizontalMargin: 0,
                                dataTextStyle: TextStyleList.text9,
                                headingTextStyle: TextStyleList.detail2,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  const DataColumn(label: Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: additionalSparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(data.quantity ?? '0'),
                                        const Text('/'),
                                        FutureBuilder<String>(
                                          future: fetchProductsReturnString2(
                                              data.partNumber ?? ''),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child: DataCircleLoading()),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            } else if (snapshot.hasData) {
                                              return Center(
                                                  child: Text(
                                                      snapshot.data ?? '-'));
                                            } else {
                                              return const Center(
                                                  child: Text(
                                                      'No data available'));
                                            }
                                          },
                                        ),
                                      ],
                                    ))),
                                    if (techLevel == '2')
                                      DataCell(Text(formatter.format(
                                          int.parse(data.salesPrice ?? '0')))),
                                  ]);
                                }).toList()),
                          ),
                        ],
                      )
                    : Container(),
                btrSparepart.isNotEmpty && btrSparepart.first.quantity != '0'
                    ? Column(
                        children: [
                          const AppDivider(),
                          10.kH,
                          Row(
                            children: [
                              Text(
                                'Battery Spare Part List',
                                style: TextStyleList.subtitle4,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                                horizontalMargin: 0,
                                dataTextStyle: TextStyleList.text9,
                                headingTextStyle: TextStyleList.detail2,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  const DataColumn(label: Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: btrSparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(data.quantity ?? '0'),
                                        const Text('/'),
                                        FutureBuilder<String>(
                                          future: fetchProductsReturnString2(
                                              data.partNumber ?? ''),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child: DataCircleLoading()),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            } else if (snapshot.hasData) {
                                              return Center(
                                                  child: Text(
                                                      snapshot.data ?? '-'));
                                            } else {
                                              return const Center(
                                                  child: Text(
                                                      'No data available'));
                                            }
                                          },
                                        ),
                                      ],
                                    ))),
                                    DataCell(Text(data.description ?? '')),
                                    if (techLevel == '2')
                                      DataCell(Text(formatter.format(
                                          int.parse(data.salesPrice ?? '0')))),
                                  ]);
                                }).toList()),
                          ),
                        ],
                      )
                    : Container(),
                pvtSparepart.isNotEmpty && pvtSparepart.first.quantity != '0'
                    ? Column(
                        children: [
                          const AppDivider(),
                          10.kH,
                          Row(
                            children: [
                              Text(
                                'Periodic Spare Part List',
                                style: TextStyleList.subtitle4,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                                horizontalMargin: 0,
                                dataTextStyle: TextStyleList.text9,
                                headingTextStyle: TextStyleList.detail2,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  const DataColumn(label: Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: pvtSparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(data.quantity ?? '0'),
                                        const Text('/'),
                                        FutureBuilder<String>(
                                          future: fetchProductsReturnString2(
                                              data.partNumber ?? ''),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child: DataCircleLoading()),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            } else if (snapshot.hasData) {
                                              return Center(
                                                  child: Text(
                                                      snapshot.data ?? '-'));
                                            } else {
                                              return const Center(
                                                  child: Text(
                                                      'No data available'));
                                            }
                                          },
                                        ),
                                      ],
                                    ))),
                                    DataCell(Text(data.description ?? '')),
                                    if (techLevel == '2')
                                      DataCell(Text(formatter.format(
                                          int.parse(data.salesPrice ?? '0')))),
                                  ]);
                                }).toList()),
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          );
  }
}
