import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart'; // Adjust the import path as needed
import 'package:toyotamobile/Styles/text.dart'; // Adjust the import path as needed

class TextFieldType extends StatelessWidget {
  final String hintText;
  final TextEditingController textSet;

  const TextFieldType(
      {super.key, required this.hintText, required this.textSet});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textSet,
      maxLines: 3,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyleList.text12,
        contentPadding: const EdgeInsets.only(
          left: 12.0,
          top: 0.0,
          right: 12.0,
          bottom: 20.0,
        ),
      ),
    );
  }
}

class TextFieldEditType extends StatelessWidget {
  final String hintText;
  final TextEditingController textSet;

  const TextFieldEditType({
    super.key,
    required this.hintText,
    required this.textSet,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textSet,
      maxLines: 3,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyleList.text12,
        contentPadding: const EdgeInsets.only(
          left: 12.0,
          top: 0.0,
          right: 12.0,
          bottom: 20.0,
        ),
      ),
    );
  }
}
