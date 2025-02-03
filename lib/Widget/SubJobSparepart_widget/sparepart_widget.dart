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
import 'package:toyotamobile/extensions/context_extension.dart';

class SparePartDetail extends StatelessWidget {
  final String jobId;
  final String bugId;
  final String techLevel;
  final String techManagerStatus;
  final String? estimateStatus;
  final String projectId;
  final String? returnStatus;
  final List<Sparepart> sparepart;
  final List<Sparepart> additionalSparepart;
  final List<Sparepart> btrSparepart;
  final List<Sparepart> pvtSparepart;
  final List<Sparepart> pvtSparepartIc;
  const SparePartDetail(
      {super.key,
      required this.additionalSparepart,
      required this.sparepart,
      required this.btrSparepart,
      required this.pvtSparepart,
      required this.pvtSparepartIc,
      required this.jobId,
      required this.bugId,
      required this.projectId,
      this.returnStatus,
      required this.techLevel,
      required this.techManagerStatus,
      required this.estimateStatus});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
    final filteredSparepart = sparepart.isNotEmpty
        ? sparepart.where((item) => item.quantity != '0').toList()
        : sparepart;
    final filteredAdditionalSparepart = additionalSparepart.isNotEmpty
        ? additionalSparepart.where((item) => item.quantity != '0').toList()
        : additionalSparepart;
    final filteredBtrSparepart = btrSparepart.isNotEmpty
        ? btrSparepart.where((item) => item.quantity != '0').toList()
        : btrSparepart;
    final filteredPvtSparepart = pvtSparepart.isNotEmpty
        ? pvtSparepart.where((item) => item.quantity != '0').toList()
        : pvtSparepart;
    final filteredPvtIcSparepart = pvtSparepartIc.isNotEmpty
        ? pvtSparepartIc.where((item) => item.quantity != '0').toList()
        : pvtSparepartIc;

    return filteredSparepart.isEmpty &&
            filteredAdditionalSparepart.isEmpty &&
            filteredBtrSparepart.isEmpty &&
            filteredPvtSparepart.isEmpty &&
            filteredPvtIcSparepart.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Text(
              context.tr('no_spare_part'),
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
                              sparepart: filteredSparepart,
                              additionalSparepart: filteredAdditionalSparepart,
                              btrSparepart: filteredBtrSparepart,
                              pvtSparepart: filteredPvtSparepart,
                              pvtIcSparepart: filteredPvtIcSparepart,
                              jobId: jobId,
                              bugId: bugId,
                              projectId: projectId,
                            ));
                      }),
                      6.kH,
                    ],
                  ),
                filteredSparepart.isNotEmpty
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
                                columnSpacing: 10,
                                dataTextStyle:
                                    TextStyleList.text9.copyWith(fontSize: 13),
                                headingTextStyle: TextStyleList.detail2
                                    .copyWith(fontSize: 14),
                                horizontalMargin: 0,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  DataColumn(
                                      label: returnStatus != null
                                          ? const Text('Return/Unit')
                                          : const Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: filteredSparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(returnStatus != null
                                            ? data.returnNo.value
                                            : data.quantity ?? '0'),
                                        const Text('/'),
                                        returnStatus != null
                                            ? Text(data.quantity ?? '0')
                                            : FutureBuilder<String>(
                                                future:
                                                    fetchProductsReturnString(
                                                        data.partNumber ?? ''),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: SizedBox(
                                                          width: 10,
                                                          height: 10,
                                                          child:
                                                              DataCircleLoading()),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Error: ${snapshot.error}'));
                                                  } else if (snapshot.hasData) {
                                                    return Center(
                                                        child: Text(
                                                            snapshot.data ??
                                                                '-'));
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
                filteredAdditionalSparepart.isNotEmpty
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
                                columnSpacing: 10,
                                dataTextStyle:
                                    TextStyleList.text9.copyWith(fontSize: 13),
                                headingTextStyle: TextStyleList.detail2
                                    .copyWith(fontSize: 14),
                                horizontalMargin: 0,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  DataColumn(
                                      label: returnStatus != null
                                          ? const Text('Return/Unit')
                                          : const Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: filteredAdditionalSparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(returnStatus != null
                                            ? data.returnNo.value
                                            : data.quantity ?? '0'),
                                        const Text('/'),
                                        returnStatus != null
                                            ? Text(data.quantity ?? '0')
                                            : FutureBuilder<String>(
                                                future:
                                                    fetchProductsReturnString(
                                                        data.partNumber ?? ''),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: SizedBox(
                                                          width: 10,
                                                          height: 10,
                                                          child:
                                                              DataCircleLoading()),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Error: ${snapshot.error}'));
                                                  } else if (snapshot.hasData) {
                                                    return Center(
                                                        child: Text(
                                                            snapshot.data ??
                                                                '-'));
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
                filteredBtrSparepart.isNotEmpty
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
                                columnSpacing: 10,
                                dataTextStyle:
                                    TextStyleList.text9.copyWith(fontSize: 13),
                                headingTextStyle: TextStyleList.detail2
                                    .copyWith(fontSize: 14),
                                horizontalMargin: 0,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  DataColumn(
                                      label: returnStatus != null
                                          ? const Text('Return/Unit')
                                          : const Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: filteredBtrSparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(returnStatus != null
                                            ? data.returnNo.value
                                            : data.quantity ?? '0'),
                                        const Text('/'),
                                        returnStatus != null
                                            ? Text(data.quantity ?? '0')
                                            : FutureBuilder<String>(
                                                future:
                                                    fetchProductsReturnString(
                                                        data.partNumber ?? ''),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: SizedBox(
                                                          width: 10,
                                                          height: 10,
                                                          child:
                                                              DataCircleLoading()),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Error: ${snapshot.error}'));
                                                  } else if (snapshot.hasData) {
                                                    return Center(
                                                        child: Text(
                                                            snapshot.data ??
                                                                '-'));
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
                filteredPvtSparepart.isNotEmpty
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
                                columnSpacing: 10,
                                dataTextStyle:
                                    TextStyleList.text9.copyWith(fontSize: 13),
                                headingTextStyle: TextStyleList.detail2
                                    .copyWith(fontSize: 14),
                                horizontalMargin: 0,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  DataColumn(
                                      label: returnStatus != null
                                          ? const Text('Return/Unit')
                                          : const Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: filteredPvtSparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(returnStatus != null
                                            ? data.returnNo.value
                                            : data.quantity ?? '0'),
                                        const Text('/'),
                                        returnStatus != null
                                            ? Text(data.quantity ?? '0')
                                            : FutureBuilder<String>(
                                                future:
                                                    fetchProductsReturnString(
                                                        data.partNumber ?? ''),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: SizedBox(
                                                          width: 10,
                                                          height: 10,
                                                          child:
                                                              DataCircleLoading()),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Error: ${snapshot.error}'));
                                                  } else if (snapshot.hasData) {
                                                    return Center(
                                                        child: Text(
                                                            snapshot.data ??
                                                                '-'));
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
                filteredPvtIcSparepart.isNotEmpty
                    ? Column(
                        children: [
                          const AppDivider(),
                          10.kH,
                          Row(
                            children: [
                              Text(
                                'Periodic IC Spare Part List',
                                style: TextStyleList.subtitle4,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: DataTable(
                                columnSpacing: 10,
                                dataTextStyle:
                                    TextStyleList.text9.copyWith(fontSize: 13),
                                headingTextStyle: TextStyleList.detail2
                                    .copyWith(fontSize: 14),
                                horizontalMargin: 0,
                                columns: [
                                  const DataColumn(label: Text('Item')),
                                  const DataColumn(label: Text('Description')),
                                  DataColumn(
                                      label: returnStatus != null
                                          ? const Text('Return/Unit')
                                          : const Text('Unit/Store')),
                                  if (techLevel == '2')
                                    const DataColumn(label: Text('Price'))
                                ],
                                rows: filteredPvtIcSparepart
                                    .where((data) => data.quantity != '0')
                                    .map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Text(data.description ?? '')),
                                    DataCell(Center(
                                        child: Row(
                                      children: [
                                        Text(returnStatus != null
                                            ? data.returnNo.value
                                            : data.quantity ?? '0'),
                                        const Text('/'),
                                        returnStatus != null
                                            ? Text(data.quantity ?? '0')
                                            : FutureBuilder<String>(
                                                future:
                                                    fetchProductsReturnString(
                                                        data.partNumber ?? ''),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: SizedBox(
                                                          width: 10,
                                                          height: 10,
                                                          child:
                                                              DataCircleLoading()),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Error: ${snapshot.error}'));
                                                  } else if (snapshot.hasData) {
                                                    return Center(
                                                        child: Text(
                                                            snapshot.data ??
                                                                '-'));
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
                    : Container()
              ],
            ),
          );
  }
}
