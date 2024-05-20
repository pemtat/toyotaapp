import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController textSet;
  TextFieldWidget({
    required this.text,
    required this.textSet,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textSet,
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
