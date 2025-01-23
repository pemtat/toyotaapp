import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toyotamobile/Function/openappstore.dart';
import 'package:toyotamobile/Service/api.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';
import 'package:toyotamobile/Widget/sizedbox_widget.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

class DialogAlert extends StatelessWidget {
  final String title;
  final String leftButton;
  final String rightButton;
  final VoidCallback onRightButtonPressed;
  final Color? rightColor;

  const DialogAlert({
    super.key,
    required this.title,
    required this.leftButton,
    required this.rightButton,
    required this.onRightButtonPressed,
    this.rightColor,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: const Color(0xffFFFFFF),
      contentPadding: const EdgeInsets.all(25.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyleList.text15,
            ),
          ),
          20.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildButton(
                  context,
                  leftButton,
                  Colors.white,
                  TextStyleList.text6,
                  black2,
                  const Color(0xff000000),
                  () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              10.wH,
              Expanded(
                child: _buildButton(
                  context,
                  rightButton,
                  rightColor ?? Colors.black,
                  TextStyleList.text7,
                  white3,
                  Colors.transparent,
                  () {
                    Navigator.of(context).pop();
                    onRightButtonPressed();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context,
      String text,
      Color bgColor,
      TextStyle style,
      Color textColor,
      Color borderColor,
      VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: borderColor, width: 1.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

class AlertDialog1 extends StatelessWidget {
  const AlertDialog1({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white3,
      title: Center(
          child: Text(
        context.tr('warning'),
        style: TextStyleList.subtitle1,
      )),
      content: Row(
        children: [
          Text(
            context.tr('warning_message_1'),
            style: TextStyleList.text2,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            context.tr('warning_yes'),
            style: TextStyleList.subtext3,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class AlertDialogPickImage extends StatelessWidget {
  const AlertDialogPickImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white3,
      title: Center(
          child: Text(
        context.tr('warning'),
        style: TextStyleList.title1,
      )),
      content: Row(
        children: [
          Expanded(
            child: Text(
              context.tr('warning_file'),
              style: TextStyleList.text2,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            context.tr('warning_yes'),
            style: TextStyleList.subtext3,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class AlertDialogVersions extends StatelessWidget {
  String deviceType;
  AlertDialogVersions({super.key, required this.deviceType});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white3,
      title: Center(
          child: Text(
        context.tr('warning'),
        style: TextStyleList.title1,
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.tr('warning_update'),
                  style: TextStyleList.text2,
                ),
              ),
            ],
          ),
          if (deviceType == 'Android') 8.kH,
          if (deviceType == 'Android')
            GestureDetector(
              onTap: () {
                Clipboard.setData(const ClipboardData(text: apkUrl));
                Fluttertoast.showToast(
                    msg: context.tr('copy_text'),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    fontSize: 12.0);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    context.tr('copy_apk_link'),
                    style: TextStyleList.text21,
                  ),
                  2.wH,
                  Image.asset('assets/ticketblock.png'),
                ],
              ),
            )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            context.tr('warning_yes'),
            style: TextStyleList.subtext3,
          ),
          onPressed: () {
            if (deviceType == 'iOS') {
              openAppStore();
            } else {}
          },
        ),
      ],
    );
  }
}

class AlertDialogNotComplete extends StatelessWidget {
  const AlertDialogNotComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white3,
      title: Center(
          child: Text(
        context.tr('warning'),
        style: TextStyleList.subtitle1,
      )),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.tr('warning_message_2'),
            style: TextStyleList.text2,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            context.tr('warning_yes'),
            style: TextStyleList.subtext3,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
