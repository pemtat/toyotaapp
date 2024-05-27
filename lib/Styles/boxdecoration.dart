import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';

class Decoration1 extends BoxDecoration {
  Decoration1(
      {required Color sideBorderColor,
      Color borderColor = white1,
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
    Color borderColor = white2,
    double width = 2,
    Color backgroundColor = black5,
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

class Decoration3 extends BoxDecoration {
  Decoration3({
    Color borderColor = white5,
    double width = 1,
    Color backgroundColor = white3,
  }) : super(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(10),
          ),
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
    Color borderColor = white2,
    double width = 0,
    Color backgroundColor = white3,
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
    Color borderColor = white6,
    double width = 1,
    Color backgroundColor = white3,
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
