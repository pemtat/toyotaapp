import 'package:flutter/material.dart';
import 'package:toyotamobile/Screen/FillForm2/fillform2_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/margin.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/boxshowdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

class FillFormView2 extends StatelessWidget {
  const FillFormView2({super.key});

  @override
  Widget build(BuildContext context) {
    final FillformController2 fillformController2 =
        Get.put(FillformController2());
    int space = 8;

    return Scaffold(
      backgroundColor: white4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(preferredSize),
        child: Column(
          children: [
            AppBar(
                backgroundColor: white3,
                title: Text('Battery Information', style: TextStyleList.title1),
                leading: const CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            6.kH,
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'Bettery',
                  button: AddButton(
                    onTap: () {
                      fillformController2.aWrite();
                    },
                  ),
                ),
                fillformController2.batteryMaintenanceReports.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: fillformController2
                            .batteryMaintenanceReports.length,
                        itemBuilder: (context, index) {
                          final batteryModel = fillformController2
                              .batteryMaintenanceReports[index];

                          final partData = {
                            'Battery Brand': batteryModel.a,
                            'Battery Model': batteryModel.b,
                            'Mfg.no': batteryModel.c,
                            'Serial. No': batteryModel.d,
                            'Battery Lifespan': batteryModel.e,
                            'Voltage': batteryModel.f,
                            'Capacity': batteryModel.g,
                          };

                          return BoxShowDetail(
                            reportItems: fillformController2
                                .batteryMaintenanceReportShow,
                            partData: partData,
                          );
                        },
                      )
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
