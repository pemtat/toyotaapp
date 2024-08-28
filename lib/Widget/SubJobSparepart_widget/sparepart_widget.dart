import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Function/checkquantity.dart';
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
  final String techLevel;
  final String leadTechStatus;
  final List<Sparepart> sparepart;
  final List<Sparepart> additionalSparepart;
  const SparePartDetail(
      {super.key,
      required this.additionalSparepart,
      required this.sparepart,
      required this.jobId,
      required this.techLevel,
      required this.leadTechStatus});

  @override
  Widget build(BuildContext context) {
    return (sparepart.isEmpty || sparepart.first.quantity == '0') &&
            (additionalSparepart.isEmpty ||
                additionalSparepart.first.quantity == '0')
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
                if (techLevel == '1' &&
                    (leadTechStatus == '0' || leadTechStatus == '3'))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EditButton(onTap: () {
                        Get.to(() => EditSparePartView(
                            sparepart: sparepart,
                            additionalSparepart: additionalSparepart,
                            jobId: jobId));
                      }),
                      6.kH,
                    ],
                  ),
                if (techLevel == '2' && leadTechStatus == '1')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EditButton(onTap: () {
                        Get.to(() => EditSparePartView(
                            sparepart: sparepart,
                            additionalSparepart: additionalSparepart,
                            jobId: jobId));
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
                                columns: const [
                                  DataColumn(label: Text('Item')),
                                  DataColumn(label: Text('Unit')),
                                  DataColumn(label: Text('Store')),
                                  DataColumn(label: Text('Status')),
                                ],
                                rows: sparepart.map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Center(
                                        child: Text(data.quantity ?? '0'))),
                                    DataCell(FutureBuilder<String>(
                                      future: fetchProductsReturnString(
                                          data.partNumber ?? ''),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child: DataCircleLoading()));
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        } else if (snapshot.hasData) {
                                          return Center(
                                              child:
                                                  Text(snapshot.data ?? '-'));
                                        } else {
                                          return const Center(
                                              child: Text('No data available'));
                                        }
                                      },
                                    )),
                                    DataCell(
                                      Center(
                                          child: FutureBuilder<String>(
                                        future: fetchProductsReturnString(
                                            data.partNumber ?? ''),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child: SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child:
                                                        DataCircleLoading()));
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'));
                                          } else if (snapshot.hasData) {
                                            return Center(
                                                child: Text(checkQuantityStatus(
                                                    data.quantity,
                                                    snapshot.data)));
                                          } else {
                                            return const Center(
                                                child:
                                                    Text('No data available'));
                                          }
                                        },
                                      )),
                                    ),
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
                                columns: const [
                                  DataColumn(label: Text('Item')),
                                  DataColumn(label: Text('Unit')),
                                  DataColumn(label: Text('Store')),
                                  DataColumn(label: Text('Status')),
                                ],
                                rows: additionalSparepart.map((data) {
                                  return DataRow(cells: [
                                    DataCell(Text(data.partNumber ?? '')),
                                    DataCell(Center(
                                        child: Text(data.quantity ?? '0'))),
                                    DataCell(FutureBuilder<String>(
                                      future: fetchProductsReturnString(
                                          data.partNumber ?? ''),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child: DataCircleLoading()));
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        } else if (snapshot.hasData) {
                                          return Center(
                                              child:
                                                  Text(snapshot.data ?? '-'));
                                        } else {
                                          return const Center(
                                              child: Text('No data available'));
                                        }
                                      },
                                    )),
                                    DataCell(Center(
                                        child: FutureBuilder<String>(
                                      future: fetchProductsReturnString(
                                          data.partNumber ?? ''),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child: DataCircleLoading()));
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        } else if (snapshot.hasData) {
                                          return Center(
                                              child: Text(checkQuantityStatus(
                                                  data.quantity,
                                                  snapshot.data)));
                                        } else {
                                          return const Center(
                                              child: Text('No data available'));
                                        }
                                      },
                                    ))),
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
