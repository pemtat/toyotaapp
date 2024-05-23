import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';

class CustomBoxDecoration extends BoxDecoration {
  CustomBoxDecoration(
      {required Color sideBorderColor,
      Color borderColor = border,
      double width = 1})
      : super(
          border: Border(
            left: BorderSide(width: 3.0, color: sideBorderColor),
            right: BorderSide(width: width, color: borderColor),
            bottom: BorderSide(width: width, color: borderColor),
            top: BorderSide(width: width, color: borderColor),
          ),
        );
}

class Decoration2 extends BoxDecoration {
  Decoration2({
    Color borderColor = border2,
    double width = 2,
    Color backgroundColor = search,
  }) : super(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
          border: Border(
            left: BorderSide(width: width, color: borderColor),
            right: BorderSide(width: width, color: borderColor),
            bottom: BorderSide(width: width, color: borderColor),
            top: BorderSide(width: width, color: borderColor),
          ),
        );
}

class BoxDetail extends BoxDecoration {
  BoxDetail({
    Color borderColor = border2,
    double width = 0,
    Color backgroundColor = buttontextcolor,
  }) : super(
          color: backgroundColor,
          border: Border(
            left: BorderSide(width: width, color: borderColor),
            right: BorderSide(width: width, color: borderColor),
            bottom: BorderSide(width: width, color: borderColor),
            top: BorderSide(width: width, color: borderColor),
          ),
        );
}

class BoxText extends BoxDecoration {
  BoxText({
    Color borderColor = boxtextfield,
    double width = 1,
    Color backgroundColor = buttontextcolor,
  }) : super(
          borderRadius: BorderRadius.circular(6),
          color: backgroundColor,
          border: Border(
            left: BorderSide(width: width, color: borderColor),
            right: BorderSide(width: width, color: borderColor),
            bottom: BorderSide(width: width, color: borderColor),
            top: BorderSide(width: width, color: borderColor),
          ),
        );
}
