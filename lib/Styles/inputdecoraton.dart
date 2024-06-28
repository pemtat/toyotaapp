import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class InputDecoration1 extends InputDecoration {
  final String text;
  final bool addtionalText;

  InputDecoration1({
    required this.text,
    this.addtionalText = false,
  }) : super(
          hintText: text,
          hintStyle: TextStyleList.text11,
          filled: true,
          fillColor: black5,
          enabledBorder: addtionalText
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
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
          focusedBorder: addtionalText
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 135, 135, 135),
                    width: 1,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 153, 153, 153),
                    width: 1,
                  ),
                ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 19.0,
          ),
        );
}
