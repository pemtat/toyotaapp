import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController textSet;

  const TextFieldWidget({
    super.key,
    required this.text,
    required this.textSet,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textSet,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyleList.text11,
        filled: true,
        fillColor: black5,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: white2,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 19.0),
      ),
    );
  }
}

class TextFieldEditWidget extends StatelessWidget {
  final String text;
  final TextEditingController textSet;
  const TextFieldEditWidget({
    super.key,
    required this.text,
    required this.textSet,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textSet,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyleList.text11,
        filled: true,
        fillColor: black5,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: white2,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 19.0),
      ),
    );
  }
}
