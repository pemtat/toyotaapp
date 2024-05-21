import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart'; // Adjust the import path as needed
import 'package:toyotamobile/Styles/text.dart'; // Adjust the import path as needed

class TextFieldType extends StatelessWidget {
  final String hintText;
  final TextEditingController textSet;

  TextFieldType({required this.hintText, required this.textSet});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textSet,
      maxLines: 3,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: border2,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: border2,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: border2,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyleList.texttitle,
        contentPadding: EdgeInsets.only(
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

  TextFieldEditType({
    required this.hintText,
    required this.textSet,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textSet,
      maxLines: 3,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: border2,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: border2,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: border2,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyleList.texttitle,
        contentPadding: EdgeInsets.only(
          left: 12.0,
          top: 0.0,
          right: 12.0,
          bottom: 20.0,
        ),
      ),
    );
  }
}
