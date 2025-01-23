import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toyotamobile/Function/fillform.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/EditSparePart/editsparepart_view.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/ReturnSparepart_widget/sparepart_details_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/divider_widget.dart';
import 'package:toyotamobile/Widget/loadingcircle_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class ReturnSparePartDetail extends StatelessWidget {
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
  final List<Sparepart> pvtSparepartIc;
  const ReturnSparePartDetail(
      {super.key,
      required this.additionalSparepart,
      required this.sparepart,
      required this.btrSparepart,
      required this.pvtSparepart,
      required this.pvtSparepartIc,
      required this.jobId,
      required this.bugId,
      required this.projectId,
      required this.techLevel,
      required this.techManagerStatus,
      required this.estimateStatus});

  @override
  Widget build(BuildContext context) {
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
              'ไม่มี Spare Part',
              style: TextStyleList.text5,
            )),
          )
        : SizedBox(
            width: double.infinity,
            child: Column(
              children: [
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
                          SparepartDetailsWidget(sparepart: filteredSparepart)
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
                          SparepartDetailsWidget(
                              sparepart: filteredAdditionalSparepart)
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
                          SparepartDetailsWidget(
                              sparepart: filteredBtrSparepart)
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
                          SparepartDetailsWidget(
                              sparepart: filteredPvtSparepart)
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
                          SparepartDetailsWidget(
                              sparepart: filteredPvtIcSparepart)
                        ],
                      )
                    : Container()
              ],
            ),
          );
  }
}
