import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/base64pdf.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class WarrantyBox extends StatelessWidget {
  final String model;
  final String serial;
  final int status;
  final RxList<Map<String, dynamic>>? filePdf;
  const WarrantyBox(
      {required this.model,
      required this.serial,
      required this.status,
      required this.filePdf,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      children: [
        TitleApp(text: context.tr('machine_details')),
        8.kH,
        BoxInfo(
          title: context.tr('model'),
          value: model,
        ),
        3.kH,
        BoxInfo(
          title: context.tr('serial_number'),
          value: serial,
        ),
        3.kH,
        // BoxInfo(
        //   title: "Warranty Status",
        //   value: status.toString(),
        //   trailing: CheckStatus(
        //     status: status,
        //   ),
        // ),
        3.kH,
        if (filePdf != null)
          Column(
            children: [
              const BoxInfo(
                title: "Attachment File",
                value: '',
              ),
              4.kH,
              Row(
                children: [AttachmentsListPdfWidget(filePdf ?? [])],
              ),
            ],
          ),
      ],
    );
  }
}
