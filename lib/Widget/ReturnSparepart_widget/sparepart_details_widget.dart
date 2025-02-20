import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Models/subjobsparepart_model.dart';
import 'package:toyotamobile/Screen/ReturnSparePartShow/return_sparepart_show_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class SparepartDetailsWidget extends StatelessWidget {
  final List<Sparepart> sparepart;
  final SubJobSparePart subJobSparePart;
  final bool? edit;
  final ReturnSparepartController returnSparepartController =
      Get.put(ReturnSparepartController());
  SparepartDetailsWidget(
      {super.key,
      required this.sparepart,
      required this.subJobSparePart,
      this.edit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
          columnSpacing: 0,
          dataTextStyle: TextStyleList.text9.copyWith(fontSize: 13),
          headingTextStyle: TextStyleList.detail2.copyWith(fontSize: 13),
          columns: const [
            DataColumn(
              label: SizedBox(width: 0, child: Text('')),
            ),
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
              DataCell(
                ((data.lineNo != '' && data.lineNo != null) &&
                            data.returnRef == '0') ||
                        (edit == true &&
                            (subJobSparePart.adminStatus == '2' ||
                                subJobSparePart.techManagerStatus == '2'))
                    ? Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
              DataCell(
                SingleChildScrollView(
                  child: SizedBox(
                    width: 70,
                    child: Text(
                      data.partNumber ?? '',
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
              DataCell(
                SingleChildScrollView(
                  child: SizedBox(
                    width: 70,
                    child: Text(
                      data.description ?? '',
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
              DataCell(Center(
                child: Text(
                  data.quantity ?? '0',
                  style: TextStyleList.text9,
                ),
              )),
              DataCell(
                Obx(() {
                  bool isChecked = returnSparepartController.selectedSpareParts
                          .contains(data) ||
                      data.lineNo == null ||
                      data.lineNo == '' ||
                      data.returnRef != '0';
                  if (edit == true) {
                    isChecked = data.returnRef == '0' ||
                        returnSparepartController.selectedSpareParts
                            .contains(data);
                  }

                  return Row(
                    mainAxisAlignment: !isChecked
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      if (!isChecked)
                        IconButton(
                          icon: const Icon(Icons.remove, size: 15),
                          onPressed: isChecked
                              ? null
                              : () {
                                  int current =
                                      int.tryParse(data.returnNo.value) ?? 0;
                                  if (current > 0) {
                                    returnSparepartController.updateReturnNo(
                                        index,
                                        (current - 1).toString(),
                                        sparepart);
                                  }
                                },
                        ),
                      SizedBox(
                        width: 30,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          enabled: !isChecked,
                          style: TextStyleList.text9,
                          controller:
                              TextEditingController(text: data.returnNo.value),
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
                      ),
                      if (!isChecked)
                        IconButton(
                          icon: const Icon(Icons.add, size: 15),
                          onPressed: isChecked
                              ? null
                              : () {
                                  int current =
                                      int.tryParse(data.returnNo.value) ?? 0;
                                  if (current <
                                      int.parse(data.quantity ?? '0')) {
                                    returnSparepartController.updateReturnNo(
                                        index,
                                        (current + 1).toString(),
                                        sparepart);
                                  }
                                },
                        ),
                    ],
                  );
                }),
              ),
            ]);
          }).toList()),
    );
  }
}
