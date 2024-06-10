import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final TextInputType? number;
  final TextEditingController textSet;
  final String? addtionalText;
  const TextFieldWidget({
    super.key,
    required this.text,
    required this.textSet,
    this.number,
    this.addtionalText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 8,
            child: TextField(
              keyboardType: number ?? TextInputType.text,
              controller: textSet,
              decoration: InputDecoration(
                hintText: text,
                hintStyle: TextStyleList.text11,
                filled: true,
                fillColor: black5,
                enabledBorder: addtionalText != null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        borderSide: BorderSide(
                          color: white2,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: white2,
                          width: 1,
                        ),
                      ),
                focusedBorder: addtionalText != null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 19.0,
                ),
              ),
            ),
          ),
          if (addtionalText != null)
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: white2),
                      bottom: BorderSide(color: white2),
                      top: BorderSide(color: white2),
                    ),
                    color: white6,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(6))),
                child: Center(
                  child: Text('$addtionalText', style: TextStyleList.text11),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TextFieldEditWidget extends StatelessWidget {
  final String text;
  final TextEditingController textSet;
  final TextInputType? number;
  final String? addtionalText;

  const TextFieldEditWidget({
    super.key,
    required this.text,
    required this.textSet,
    this.number,
    this.addtionalText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: TextField(
              controller: textSet,
              keyboardType: number ?? TextInputType.text,
              decoration: InputDecoration(
                hintText: text,
                hintStyle: TextStyleList.text11,
                filled: true,
                fillColor: black5,
                enabledBorder: addtionalText != null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        borderSide: BorderSide(
                          color: white2,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: white2,
                          width: 1,
                        ),
                      ),
                focusedBorder: addtionalText != null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 19.0),
              ),
            ),
          ),
          if (addtionalText != null)
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: white2),
                      bottom: BorderSide(color: white2),
                      top: BorderSide(color: white2),
                    ),
                    color: white6,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(6))),
                child: Center(
                  child: Text('$addtionalText', style: TextStyleList.text11),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TextFormFieldBar extends StatelessWidget {
  final String label;
  final bool hidetext;
  final TextInputType? type;
  final TextEditingController controller;

  const TextFormFieldBar({
    super.key,
    required this.label,
    required this.controller,
    this.hidetext = false,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hidetext,
      keyboardType: type ?? TextInputType.text,
      style: TextStyleList.text11,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyleList.text11,
        floatingLabelStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: black1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: black1),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    );
  }
}

class TextFormFieldVisible extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final RxBool isTextHidden;
  final Function hiddenChange;
  const TextFormFieldVisible({
    super.key,
    required this.label,
    required this.controller,
    required this.isTextHidden,
    required this.hiddenChange,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        obscureText: !isTextHidden.value,
        keyboardType: TextInputType.number,
        style: TextStyleList.text11,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyleList.text11,
          floatingLabelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: black1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: black1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          suffixIcon: IconButton(
            icon: Icon(
              !isTextHidden.value ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              hiddenChange();
            },
          ),
        ),
      );
    });
  }
}
