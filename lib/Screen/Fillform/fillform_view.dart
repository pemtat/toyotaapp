import 'package:flutter/material.dart';
import 'package:toyotamobile/Screen/Fillform/adddetail/rcode_controller.dart';
import 'package:toyotamobile/Screen/Fillform/fillform_controller.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/boxdetail_widget.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/icon_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/title_widget.dart';
import 'package:get/get.dart';

class FillFormView extends StatelessWidget {
  const FillFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final RcodeController rcodeController = Get.put(RcodeController());

    int space = 8;
    int space2 = 20;

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
                space.kH,
                FillFormCheckbox(text: "Inspection"),
                space.kH,
                FillFormCheckbox(text: "Repairing"),
                space.kH,
                FillFormCheckbox(text: "Re-repairing"),
                space.kH,
                FillFormCheckbox(text: "Comission"),
                space.kH,
                FillFormCheckbox(text: "Other"),
                space.kH,
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                CustomTextField(text: 'Fault'),
                space2.kH,
                CustomTextField(text: 'Error Code'),
                space2.kH,
                CustomTextField(text: 'Work Order Number(Order No.)')
              ],
            ),
            14.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'R Code',
                  button: AddButton(
                    onTap: () {
                      rcodeController.rCodeModal(context);
                    },
                  ),
                ),
              ],
            ),
            space.kH,
            BoxContainer(
              children: [
                TitleWithButton(
                  titleText: 'W Code',
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
                  titleText: 'Repair prodecure',
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

class FillFormCheckbox extends StatelessWidget {
  final String text;
  final FillformController controller = Get.put(FillformController());

  FillFormCheckbox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            controller.fieldService(text);
          },
          child: Obx(
            () => Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: !controller.fieldServiceReport.contains(text)
                    ? Border.all(color: Colors.grey)
                    : Border.all(color: Colors.transparent),
                color: controller.fieldServiceReport.contains(text)
                    ? Colors.red
                    : Colors.transparent,
              ),
              child: Center(
                child: controller.fieldServiceReport.contains(text)
                    ? Icon(Icons.check, color: Colors.white, size: 16)
                    : SizedBox(),
              ),
            ),
          ),
        ),
        8.wH,
        Expanded(
          child: Text(text, style: TextStyleList.subdetail),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String text;
  final FillformController controller = Get.put(FillformController());

  CustomTextField({required this.text});
  @override
  Widget build(BuildContext context) {
    final TextEditingController? textFieldController =
        controller.getTextFieldController(text);
    return TextField(
      controller: textFieldController,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyleList.texttitle,
        filled: true,
        fillColor: search,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: border2,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 19.0),
      ),
    );
  }
}
