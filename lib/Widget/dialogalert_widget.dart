import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';

class DialogAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Color(0xffFFFFFF),
      contentPadding: EdgeInsets.all(25.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Successfully finished job on investigating!',
              textAlign: TextAlign.center,
              style: TextStyleList.detail2,
            ),
          ),
          20.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildButton(
                  context,
                  'Not yet',
                  Colors.white,
                  TextStyleList.dialogbutton,
                  dialogbuttoncolor,
                  () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              10.wH,
              Expanded(
                child: _buildButton(
                  context,
                  'Yes, Completed',
                  Colors.black,
                  TextStyleList.dialogbutton2,
                  buttontextcolor,
                  () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color bgColor,
      TextStyle style, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
