import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Widget/button_widget.dart';
import 'package:toyotamobile/Widget/checkbox_widget.dart';
import 'package:toyotamobile/Widget/showmodal_widget.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class BatteryCondition extends GetxController {
  int space = 24;
  int space2 = 8;

  void batteryConditionModal(BuildContext context) {
    chooseClear();
    chooseAdd();
    ShowModalWidget(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Battery Condition",
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
        16.kH,
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                CheckBoxWidget2(
                  text: "Tray",
                  listItem: trayChoose,
                  itemSet: trayChoose,
                  optionList: optionList,
                  description: trayDescriptionChoose,
                ),
                space2.kH,
                CheckBoxWidget2(
                    text: "Container",
                    listItem: containerChoose,
                    itemSet: containerChoose,
                    optionList: optionList,
                    description: containerDescriptionChoose),
                space2.kH,
                CheckBoxWidget2(
                    text: "Connector",
                    listItem: connectorChoose,
                    itemSet: connectorChoose,
                    optionList: optionList,
                    description: connectorDescriptionChoose),
                space2.kH,
                CheckBoxWidget2(
                  text: "Vent Plug",
                  listItem: ventPugChoose,
                  itemSet: ventPugChoose,
                  optionList: optionList,
                  description: ventPlugDescriptionChoose,
                  moreOptionList: ventPlugOptionList,
                  moreItemSet: ventPugOptionChoose,
                  more: true,
                ),
                space2.kH,
                CheckBoxWidget2(
                    text: "Cover",
                    listItem: coverChoose,
                    itemSet: coverChoose,
                    optionList: optionList,
                    description: covertDescriptionChoose),
                space2.kH,
                CheckBoxWidget2(
                  text: "Terminal",
                  listItem: terminalChoose,
                  itemSet: terminalChoose,
                  optionList: optionList,
                  description: terminalDescriptionChoose,
                ),
                space2.kH,
                CheckBoxWidget2(
                  text: "Cable+Plug",
                  listItem: cablePlugChoose,
                  itemSet: cablePlugChoose,
                  optionList: optionList,
                  description: cablePlugChooseDescription,
                ),
                space2.kH,
                CheckBoxWidget2(
                  text: "Voltage",
                  listItem: voltageChoose,
                  itemSet: voltageChoose,
                  optionList: optionList,
                  description: voltageChooseDescription,
                ),
                space2.kH,
                CheckBoxWidget2(
                  text: "Sp.Gr.",
                  listItem: spGrChoose,
                  itemSet: spGrChoose,
                  optionList: optionList,
                  description: spGrDescriptionChoose,
                ),
                space2.kH,
                CheckBoxWidget2(
                  text: "Temperature",
                  listItem: temperatureChoose,
                  itemSet: temperatureChoose,
                  optionList: optionList,
                  description: temperatureDescriptionChoose,
                ),
                space2.kH,
                CheckBoxWidget2(
                    text: "Acid",
                    listItem: acidChoose,
                    itemSet: acidChoose,
                    optionList: optionList,
                    description: acidDescriptionChoose),
                space2.kH,
                CheckBoxWidget2(
                  text: "Plates",
                  listItem: platesChoose,
                  itemSet: platesChoose,
                  optionList: optionList,
                  description: platesDescriptionChoose,
                ),
                space2.kH,
              ],
            )),
        space.kH,
        EndButton(
          onPressed: () {
            if (checkAllFieldsFilled()) {
              listClear();
              descriptionAdd();
              listAdd();
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(
                        child: Text(
                      'เเจ้งเตือน',
                      style: TextStyleList.subtitle1,
                    )),
                    content: Row(
                      children: [
                        Text(
                          'โปรดกรอกข้อมูลให้ครบถ้วน',
                          style: TextStyleList.text2,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'ตกลง',
                          style: TextStyleList.subtext3,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          text: 'Confirm',
        ),
      ],
    ).showModal(context);
  }

  bool checkAllFieldsFilled() {
    return isAllFieldsFilled.value =
        trayDescriptionChoose.value.text.isNotEmpty &&
            containerDescriptionChoose.value.text.isNotEmpty &&
            ventPlugDescriptionChoose.value.text.isNotEmpty &&
            connectorDescriptionChoose.value.text.isNotEmpty &&
            covertDescriptionChoose.value.text.isNotEmpty &&
            terminalDescriptionChoose.value.text.isNotEmpty &&
            cablePlugChooseDescription.value.text.isNotEmpty &&
            voltageChooseDescription.value.text.isNotEmpty &&
            spGrDescriptionChoose.value.text.isNotEmpty &&
            temperatureDescriptionChoose.value.text.isNotEmpty &&
            acidDescriptionChoose.value.text.isNotEmpty &&
            platesDescriptionChoose.value.text.isNotEmpty &&
            trayChoose.isNotEmpty &&
            containerChoose.isNotEmpty &&
            ventPugChoose.isNotEmpty &&
            ventPugOptionChoose.isNotEmpty &&
            connectorChoose.isNotEmpty &&
            coverChoose.isNotEmpty &&
            terminalChoose.isNotEmpty &&
            cablePlugChoose.isNotEmpty &&
            voltageChoose.isNotEmpty &&
            spGrChoose.isNotEmpty &&
            temperatureChoose.isNotEmpty &&
            acidChoose.isNotEmpty &&
            platesChoose.isNotEmpty;
  }

  void chooseAdd() {
    trayChoose.addAll(tray);
    containerChoose.addAll(container);
    ventPugChoose.addAll(ventPug);
    ventPugOptionChoose.addAll(ventPugOption);
    connectorChoose.addAll(connector);
    coverChoose.addAll(cover);
    terminalChoose.addAll(terminal);
    coverChoose.addAll(cover);
    terminalChoose.addAll(terminal);
    cablePlugChoose.addAll(cablePlug);
    voltageChoose.addAll(voltage);
    spGrChoose.addAll(spGr);
    temperatureChoose.addAll(temperature);
    acidChoose.addAll(acid);
    platesChoose.addAll(plates);
  }

  void chooseClear() {
    trayChoose.clear();
    containerChoose.clear();
    ventPugChoose.clear();
    ventPugOptionChoose.clear();
    connectorChoose.clear();
    coverChoose.clear();
    terminalChoose.clear();
    coverChoose.clear();
    terminalChoose.clear();
    cablePlugChoose.clear();
    voltageChoose.clear();
    spGrChoose.clear();
    temperatureChoose.clear();
    acidChoose.clear();
    platesChoose.clear();
  }

  void descriptionAdd() {
    trayDescription.value = trayDescriptionChoose.value;
    containerDescription.value = containerDescriptionChoose.value;
    connectorDescription.value = connectorDescriptionChoose.value;
    ventPlugDescription.value = ventPlugDescriptionChoose.value;
    covertDescription.value = covertDescriptionChoose.value;
    terminalDescription.value = terminalDescriptionChoose.value;
    cablePlugDescriptionPlug.value = cablePlugChooseDescription.value;
    voltageDescription.value = voltageChooseDescription.value;
    spGrDescription.value = spGrDescriptionChoose.value;
    temperatureDescription.value = temperatureDescriptionChoose.value;
    acidDescription.value = acidDescriptionChoose.value;
    platesDescription.value = platesDescriptionChoose.value;
    description.value = descriptionChoose.value;
  }

  void descriptionClear() {
    trayDescription.value.clear();
    containerDescription.value.clear();
    connectorDescription.value.clear();
    ventPlugDescription.value.clear();
    covertDescription.value.clear();
    terminalDescription.value.clear();
    cablePlugDescriptionPlug.value.clear();
    voltageDescription.value.clear();
    spGrDescription.value.clear();
    temperatureDescription.value.clear();
    acidDescription.value.clear();
    platesDescription.value.clear();
    description.value.clear();
  }

  void listAdd() {
    tray.addAll(trayChoose);
    container.addAll(containerChoose);
    ventPug.addAll(ventPugChoose);
    ventPugOption.addAll(ventPugOptionChoose);
    connector.addAll(connectorChoose);
    cover.addAll(coverChoose);
    terminal.addAll(terminalChoose);
    cover.addAll(coverChoose);
    terminal.addAll(terminalChoose);
    cablePlug.addAll(cablePlugChoose);
    voltage.addAll(voltageChoose);
    spGr.addAll(spGrChoose);
    temperature.addAll(temperatureChoose);
    acid.addAll(acidChoose);
    plates.addAll(platesChoose);
  }

  void listClear() {
    tray.clear();
    container.clear();
    ventPug.clear();
    ventPugOption.clear();
    connector.clear();
    cover.clear();
    terminal.clear();
    cover.clear();
    terminal.clear();
    cablePlug.clear();
    voltage.clear();
    spGr.clear();
    temperature.clear();
    acid.clear();
    plates.clear();
  }

  var tray = <String>[].obs;
  var trayChoose = <String>[].obs;
  var container = <String>[].obs;
  var containerChoose = <String>[].obs;
  var ventPug = <String>[].obs;
  var ventPugChoose = <String>[].obs;
  var ventPugOption = <String>[].obs;
  var ventPugOptionChoose = <String>[].obs;
  var connector = <String>[].obs;
  var connectorChoose = <String>[].obs;
  var cover = <String>[].obs;
  var coverChoose = <String>[].obs;
  var terminal = <String>[].obs;
  var terminalChoose = <String>[].obs;
  var cablePlug = <String>[].obs;
  var cablePlugChoose = <String>[].obs;
  var voltage = <String>[].obs;
  var voltageChoose = <String>[].obs;
  var spGr = <String>[].obs;
  var spGrChoose = <String>[].obs;
  var temperature = <String>[].obs;
  var temperatureChoose = <String>[].obs;
  var acid = <String>[].obs;
  var acidChoose = <String>[].obs;
  var plates = <String>[].obs;
  var platesChoose = <String>[].obs;
  List<String> optionList = ['Normal/Good', 'Not normal/Poor'];
  List<String> ventPlugOptionList = ['Auto Filter', 'Manual'];
  var isAllFieldsFilled = false.obs;

  var trayDescription = TextEditingController().obs;
  var trayDescriptionChoose = TextEditingController().obs;
  var containerDescription = TextEditingController().obs;
  var containerDescriptionChoose = TextEditingController().obs;
  var ventPlugDescription = TextEditingController().obs;
  var ventPlugDescriptionChoose = TextEditingController().obs;
  var connectorDescription = TextEditingController().obs;
  var connectorDescriptionChoose = TextEditingController().obs;
  var covertDescription = TextEditingController().obs;
  var covertDescriptionChoose = TextEditingController().obs;
  var terminalDescription = TextEditingController().obs;
  var terminalDescriptionChoose = TextEditingController().obs;
  var cablePlugDescriptionPlug = TextEditingController().obs;
  var cablePlugChooseDescription = TextEditingController().obs;
  var voltageDescription = TextEditingController().obs;
  var voltageChooseDescription = TextEditingController().obs;
  var spGrDescription = TextEditingController().obs;
  var spGrDescriptionChoose = TextEditingController().obs;
  var temperatureDescription = TextEditingController().obs;
  var temperatureDescriptionChoose = TextEditingController().obs;
  var acidDescription = TextEditingController().obs;
  var acidDescriptionChoose = TextEditingController().obs;
  var platesDescription = TextEditingController().obs;
  var platesDescriptionChoose = TextEditingController().obs;
  final description = TextEditingController().obs;
  final descriptionChoose = TextEditingController().obs;
}
