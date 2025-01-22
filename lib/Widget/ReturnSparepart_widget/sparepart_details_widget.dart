import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/ReturnSparePart/return_sparepart_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class SparepartDetailsWidget extends StatelessWidget {
  final List<Sparepart> sparepart;
  final ReturnSparepartController returnSparepartController =
      Get.put(ReturnSparepartController());
  SparepartDetailsWidget({super.key, required this.sparepart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
          columnSpacing: 10,
          dataTextStyle: TextStyleList.text9.copyWith(fontSize: 13),
          headingTextStyle: TextStyleList.detail2.copyWith(fontSize: 14),
          horizontalMargin: 0,
          columns: const [
            DataColumn(label: Text('Item')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Unit')),
            DataColumn(
              label: Text('Return'),
            ),
            DataColumn(
              label: Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(''),
                ),
              ),
            ),
          ],
          rows: sparepart.where((data) => data.quantity != '0').map((data) {
            return DataRow(cells: [
              DataCell(Text(data.partNumber ?? '')),
              DataCell(Text(data.description ?? '')),
              DataCell(Text(data.quantity ?? '0')),
              DataCell(Text(data.returnNo.value)),
              DataCell(
                data.lineNo != '' && data.lineNo != null
                    ? Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                  (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.red;
                                }
                                return white3;
                              }),
                              value: returnSparepartController
                                  .selectedSpareParts
                                  .contains(data),
                              onChanged: (bool? selected) {
                                if (selected == true) {
                                  returnSparepartController.selectedSpareParts
                                      .add(data);
                                } else {
                                  returnSparepartController.selectedSpareParts
                                      .remove(data);
                                }
                              },
                            ),
                          ],
                        ))
                    : Container(),
              ),
            ]);
          }).toList()),
    );
  }
}
