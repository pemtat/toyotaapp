// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/repair_procedure.dart';
import 'package:toyotamobile/Screen/FillForm/adddetail/repair_procedure.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class RepairProdecureWidget extends StatelessWidget {
  final RepairProcedureModel part;
  final RepairProcedure repairProcedureController;
  final int index;

  const RepairProdecureWidget({
    super.key,
    required this.part,
    required this.index,
    required this.repairProcedureController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr('repair_prodecure'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  part.repairProcedure,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('cause_problem'),
                  style: TextStyleList.subtext1,
                ),
                Text(
                  part.causeProblem,
                  style: TextStyleList.text15,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Theme(
              data: Theme.of(context).copyWith(
                popupMenuTheme: const PopupMenuThemeData(
                  color: white3,
                ),
              ),
              child: PopupMenuButton(
                offset: const Offset(0, 30),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'edit',
                    child: Text(
                      context.tr('edit'),
                      style: TextStyleList.text9,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child:
                        Text(context.tr('delete'), style: TextStyleList.text9),
                  ),
                ],
                child: Image.asset(
                  'assets/boxedit.png',
                  width: 24,
                  height: 24,
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    repairProcedureController.rPEditModal(context, part);
                  } else if (value == 'delete') {
                    repairProcedureController.repairProcedureList
                        .removeAt(index);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
