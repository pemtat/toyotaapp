import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/ReturnSparePartShow/return_sparepart_show_controller.dart';
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
              label: Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Return'),
                ),
              ),
            ),
          ],
          rows: sparepart.where((data) => data.quantity != '0').map((data) {
            int index = sparepart.indexOf(data);
            return DataRow(cells: [
              DataCell(Text(data.partNumber ?? '')),
              DataCell(Text(data.description ?? '')),
              DataCell(Text(data.quantity ?? '0')),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: () {
                        int current = int.tryParse(data.returnNo.value) ?? 0;
                        if (current > 0) {
                          returnSparepartController.updateReturnNo(
                              index, (current - 1).toString(), sparepart);
                        }
                      },
                    ),
                    Obx(() => SizedBox(
                          width: 30,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                                text: data.returnNo.value),
                            onSubmitted: (value) {
                              int current = int.tryParse(value) ?? 0;
                              int quantityValue =
                                  int.tryParse(data.quantity ?? '0') ?? 0;

                              if (current > 0 && current <= quantityValue) {
                                returnSparepartController.updateReturnNo(
                                    index, value, sparepart);
                              } else {
                                data.returnNo.value = '0';
                                data.returnNo.refresh();
                              }
                            },
                          ),
                        )),
                    IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: () {
                        int current = int.tryParse(data.returnNo.value) ?? 0;
                        if (current < int.parse(data.quantity ?? '0')) {
                          returnSparepartController.updateReturnNo(
                              index, (current + 1).toString(), sparepart);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ]);
          }).toList()),
    );
  }
}
