import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class TableShowData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          headingRowColor: WidgetStatePropertyAll(white1),
          dataRowColor: WidgetStatePropertyAll(white4),
          columnSpacing: 6,
          dataTextStyle: TextStyleList.text9.copyWith(fontSize: 12),
          headingTextStyle: TextStyleList.detail2.copyWith(fontSize: 12),
          horizontalMargin: 10,
          columns: [
            DataColumn(
                label: Text(
              'ZONE',
              style: TextStyleList.text6,
            )),
            DataColumn(
                label: Text(
              'CO',
              style: TextStyleList.text6,
            )),
            DataColumn(
                label: Text(
              'INSPECT',
              style: TextStyleList.text6,
            )),
            DataColumn(
                label: Text(
              'OTHER',
              style: TextStyleList.text6,
            )),
            DataColumn(
                label: Text(
              'PM',
              style: TextStyleList.text6,
            )),
            DataColumn(
                label: Text(
              'REPAIR',
              style: TextStyleList.text6,
            )),
            DataColumn(
                label: Text(
              'STD-BY',
              style: TextStyleList.text6,
            )),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('A')),
              DataCell(Text('4.00')),
              DataCell(Text('1.51')),
              DataCell(Text('1.50')),
              DataCell(Text('3.58')),
              DataCell(Text('3.61')),
              DataCell(Text('5.15')),
            ]),
            DataRow(color: WidgetStatePropertyAll(black), cells: [
              DataCell(Text(
                'Average',
                style: TextStyleList.text22,
              )),
              DataCell(Text(
                '2.86',
                style: TextStyleList.text22,
              )),
              DataCell(Text(
                '1.77',
                style: TextStyleList.text22,
              )),
              DataCell(Text(
                '2.45',
                style: TextStyleList.text22,
              )),
              DataCell(Text(
                '1.62',
                style: TextStyleList.text22,
              )),
              DataCell(Text(
                '1.84',
                style: TextStyleList.text22,
              )),
              DataCell(Text(
                '5.15',
                style: TextStyleList.text22,
              )),
            ]),
          ],
        ),
      ),
    );
  }
}
