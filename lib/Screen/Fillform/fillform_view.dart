import 'package:flutter/material.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/rcode_controller.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/repairproc_controller.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/wcode_controller.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/addeditbox_widget.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

class FillFormView extends StatelessWidget {
  const FillFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final RcodeController rcodeController = Get.put(RcodeController());
    final WcodeController wcodeController = Get.put(WcodeController());
    final RepairProcControllerController rPController =
        Get.put(RepairProcControllerController());

    final FillformController fillFormController = Get.put(FillformController());

    int space = 8;

    return Scaffold(
      backgroundColor: backgroundapp,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Column(
          children: [
            AppBar(
                backgroundColor: buttontextcolor,
                title: Text('Repair Report', style: TextStyleList.topbar),
                leading: CloseIcon()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            6.kH,
            BoxContainer(
              children: [
                TitleApp(text: 'Field Service Report'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: fillFormController.fieldServiceReportList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CheckBoxWidget(
                          text:
                              fillFormController.fieldServiceReportList[index],
                          listItem: fillFormController.fieldServiceReport,
                          itemSet: (label) =>
                              fillFormController.fieldService(label)),
                    );
                  },
                ),
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                TextFieldWidget(
                    text: 'Fault', textSet: fillFormController.fault.value),
                20.kH,
                TextFieldWidget(
                    text: 'Error Code',
                    textSet: fillFormController.errorCode.value),
                20.kH,
                TextFieldWidget(
                    text: 'Work Order Number(Order No.)',
                    textSet: fillFormController.workorderNumber.value)
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      titleText: 'R Code',
                      list: rcodeController.rCode,
                      onTap: () => rcodeController.rCodeModal(context),
                      moreText: rcodeController.getDisplayString()),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                Obx(
                  () => AddEditBox(
                      titleText: 'W Code',
                      list: wcodeController.wCode,
                      onTap: () => wcodeController.wCodeModal(context),
                      moreText: wcodeController.getDisplayString()),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'Repair prodecure',
                  button: AddButton(
                    onTap: () {
                      rPController.rPModal(context);
                    },
                  ),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'Spare part list',
                  button: AddButton(
                    onTap: () {},
                  ),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'Additional spare part list',
                  button: AddButton(
                    onTap: () {},
                  ),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'Repair Result',
                  button: AddButton(
                    onTap: () {},
                  ),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'Process staff',
                  button: AddButton(
                    onTap: () {},
                  ),
                ),
              ],
            ),
            130.kH,
            BoxContainer(paddingCustom: 10, children: [
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: buttonsave,
                    foregroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyleList.buttontext3,
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
