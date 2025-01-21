import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/base64img.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/boxinfo_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class MoreDetail extends StatelessWidget {
  final RxList<Map<String, dynamic>>? file;
  final String description;
  final String category;
  final String relations;
  final String summary;
  final String severity;
  final RxBool moreDetail;
  final String? errorCode;
  final bool ediefile;
  const MoreDetail(
      {super.key,
      required this.file,
      required this.description,
      required this.moreDetail,
      required this.ediefile,
      required this.category,
      this.errorCode,
      required this.summary,
      required this.relations,
      required this.severity});

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      children: [
        Text(
          context.tr('summary_issue'),
          style: TextStyleList.text16,
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                summary,
                style: TextStyleList.text10,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                description,
                style: TextStyleList.text10,
              ),
            ),
          ],
        ),
        file != null
            ? Column(
                children: [
                  8.kH,
                  AttachmentsListWidget(
                    attachments: file ?? [],
                    edit: ediefile,
                  ),
                  8.kH,
                ],
              )
            : Container(),
        Obx(
          () => !moreDetail.value
              ? Container()
              : Column(
                  children: [
                    BoxInfo(
                      title: "Category",
                      value: category,
                    ),
                    BoxInfo(
                      title: "Severity",
                      value: severity,
                    ),
                    BoxInfo(
                      title: "Error Code",
                      value: errorCode ?? '-',
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class MoreDetailArrow extends StatelessWidget {
  final RxBool moreDetail;

  const MoreDetailArrow({super.key, required this.moreDetail});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        moreDetail.value = !moreDetail.value;
      },
      child: Obx(
        () => !moreDetail.value
            ? BoxContainer(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr('more_details'),
                        style: TextStyleList.text16,
                      ),
                      Image.asset('assets/arrowdown.png')
                    ],
                  ),
                ],
              )
            : BoxContainer(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr('less_details'),
                        style: TextStyleList.text16,
                      ),
                      Image.asset('assets/arrowup.png')
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
