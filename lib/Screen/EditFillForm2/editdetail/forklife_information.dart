import 'package:flutter/material.dart';
import 'package:toyotamobile/Models/forkliftinformation.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/Widget/textfield_widget.dart';

class ForklifeInformation extends GetxController {
  int space = 24;
  void forklifeInformationModal(BuildContext context) {
    forklifeClear();
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Forklife Information",
              style: TextStyleList.subheading,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset("assets/x.png"),
            ),
          ],
        ),
        space.kH,
        TextFieldWidget(
          text: 'Forklife Brand',
          textSet: forklifeBrand.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Forklife Model',
          textSet: forklifeModel.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'Serial No',
          textSet: serialNo.value,
        ),
        space.kH,
        TextFieldWidget(
          text: 'ForkLife Operation',
          textSet: forklifeOperation.value,
          number: TextInputType.number,
          addtionalText: 'Hrs',
        ),
        space.kH,
        EndButton(
          onPressed: () {
            forklifeWrite();
            forklifeClear();
            Navigator.pop(context);
          },
          text: 'Save',
        ),
      ],
    ).showModal(context);
  }

  void forklifeEditModal(
      BuildContext context, ForkliftInformationModel forklife) {
    forklifeRead(forklife);
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Forklife Information",
              style: TextStyleList.subheading,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/x.png"))
          ],
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Forklife Brand',
          textSet: forklifeBrand.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Forklife Model',
          textSet: forklifeModel.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'Serial No',
          textSet: serialNo.value,
        ),
        space.kH,
        TextFieldEditWidget(
          text: 'ForkLife Operation',
          textSet: forklifeOperation.value,
          number: TextInputType.number,
          addtionalText: 'Hrs',
        ),
        space.kH,
        EndButton(
            onPressed: () {
              forklifeUpdate(forklife);
              forklifeList.refresh();
              forklifeClear();
              Navigator.pop(context);
            },
            text: 'Save')
      ],
    ).showModal(context);
  }

  var forklifeList = <ForkliftInformationModel>[].obs;
  final forklifeBrand = TextEditingController().obs;
  final forklifeModel = TextEditingController().obs;
  final serialNo = TextEditingController().obs;
  final forklifeOperation = TextEditingController().obs;

  void forklifeRead(ForkliftInformationModel forklife) {
    forklifeBrand.value.text = forklife.forkLifeBrand;
    forklifeModel.value.text = forklife.forkLifeModel;
    serialNo.value.text = forklife.serialNo;
    forklifeOperation.value.text = forklife.forkLifeOperation.toString();
  }

  void forklifeClear() {
    forklifeBrand.value.clear();
    forklifeModel.value.clear();
    serialNo.value.clear();
    forklifeOperation.value.clear();
  }

  void forklifeWrite() {
    final newForklife = ForkliftInformationModel(
      forkLifeBrand:
          forklifeBrand.value.text.isNotEmpty ? forklifeBrand.value.text : '-',
      forkLifeModel:
          forklifeModel.value.text.isNotEmpty ? forklifeModel.value.text : '-',
      serialNo: serialNo.value.text.isNotEmpty ? serialNo.value.text : '-',
      forkLifeOperation: double.tryParse(forklifeOperation.value.text) ?? 0,
    );
    forklifeList.add(newForklife);
  }

  void forklifeUpdate(ForkliftInformationModel forklife) {
    forklife.forkLifeBrand =
        forklifeBrand.value.text.isNotEmpty ? forklifeBrand.value.text : '-';
    forklife.forkLifeModel =
        forklifeModel.value.text.isNotEmpty ? forklifeModel.value.text : '-';
    forklife.serialNo =
        serialNo.value.text.isNotEmpty ? serialNo.value.text : '-';

    forklife.forkLifeOperation =
        double.tryParse(forklifeOperation.value.text) ?? 0;
  }
}
