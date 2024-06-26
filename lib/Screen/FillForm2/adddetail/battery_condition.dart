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
            listClear();
            descriptionAdd();
            listAdd();
            Navigator.pop(context);
          },
          text: 'Confirm',
        ),
      ],
    ).showModal(context);
  }

  void checkAllFieldsFilled() {
    isAllFieldsFilled.value = trayDescription.value.text.isNotEmpty ||
        containerDescription.value.text.isNotEmpty ||
        ventPlugDescription.value.text.isNotEmpty ||
        connectorDescription.value.text.isNotEmpty ||
        covertDescription.value.text.isNotEmpty ||
        terminalDescription.value.text.isNotEmpty ||
        cablePlugDescriptionPlug.value.text.isNotEmpty ||
        voltageDescription.value.text.isNotEmpty ||
        spGrDescription.value.text.isNotEmpty ||
        temperatureDescription.value.text.isNotEmpty ||
        acidDescription.value.text.isNotEmpty ||
        platesDescription.value.text.isNotEmpty ||
        trayChoose.isNotEmpty ||
        container.isNotEmpty ||
        ventPug.isNotEmpty ||
        connector.isNotEmpty ||
        cover.isNotEmpty ||
        terminal.isNotEmpty ||
        cablePlug.isNotEmpty ||
        voltage.isNotEmpty ||
        spGr.isNotEmpty ||
        temperature.isNotEmpty ||
        acid.isNotEmpty ||
        plates.isNotEmpty;
  }

  void chooseAdd() {
    trayChoose.addAll(tray);
    containerChoose.addAll(container);
    ventPugChoose.addAll(ventPug);
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
    cablePlugChooseDescription.value = cablePlugChooseDescription.value;
    voltageChooseDescription.value = voltageChooseDescription.value;
    spGrDescription.value = spGrDescriptionChoose.value;
    temperatureDescription.value = temperatureDescriptionChoose.value;
    acidDescription.value = acidDescriptionChoose.value;
    platesDescription.value = platesDescriptionChoose.value;
    description.value = descriptionChoose.value;
  }

  void listAdd() {
    tray.addAll(trayChoose);
    container.addAll(containerChoose);
    ventPug.addAll(ventPugChoose);
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

  @override
  void onInit() {
    super.onInit();
    trayDescription.value.addListener(checkAllFieldsFilled);
    containerDescription.value.addListener(checkAllFieldsFilled);
    ventPlugDescription.value.addListener(checkAllFieldsFilled);
    connectorDescription.value.addListener(checkAllFieldsFilled);
    covertDescription.value.addListener(checkAllFieldsFilled);
    terminalDescription.value.addListener(checkAllFieldsFilled);
    cablePlugDescriptionPlug.value.addListener(checkAllFieldsFilled);
    voltageDescription.value.addListener(checkAllFieldsFilled);
    spGrDescription.value.addListener(checkAllFieldsFilled);
    temperatureDescription.value.addListener(checkAllFieldsFilled);
    acidDescription.value.addListener(checkAllFieldsFilled);
    platesDescription.value.addListener(checkAllFieldsFilled);

    tray.listen((_) => checkAllFieldsFilled());
    container.listen((_) => checkAllFieldsFilled());
    ventPug.listen((_) => checkAllFieldsFilled());
    connector.listen((_) => checkAllFieldsFilled());
    cover.listen((_) => checkAllFieldsFilled());
    terminal.listen((_) => checkAllFieldsFilled());
    cablePlug.listen((_) => checkAllFieldsFilled());
    voltage.listen((_) => checkAllFieldsFilled());
    spGr.listen((_) => checkAllFieldsFilled());
    temperature.listen((_) => checkAllFieldsFilled());
    acid.listen((_) => checkAllFieldsFilled());
    plates.listen((_) => checkAllFieldsFilled());
  }
}
