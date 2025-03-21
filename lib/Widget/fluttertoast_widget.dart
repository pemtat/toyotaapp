import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toyotamobile/extensions/context_extension.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    fontSize: 12.0,
  );
}

void showMessageNew(String message, BuildContext context) {
  Fluttertoast.showToast(
    msg: context.tr(message),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    fontSize: 12.0,
  );
}

void showWaitMessage() {
  Fluttertoast.showToast(
    msg: "กำลังบันทึกข้อมูล...",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    fontSize: 12.0,
  );
}

void showSaveMessage() {
  Fluttertoast.showToast(
    msg: "บันทึกข้อมูลสำเร็จ",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    fontSize: 12.0,
  );
}

void showWaitMessageNew(BuildContext context) {
  Fluttertoast.showToast(
    msg: "กำลังบันทึกข้อมูล...",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    fontSize: 12.0,
  );
}

void showSaveMessageNew(BuildContext context) {
  Fluttertoast.showToast(
    msg: context.tr('save_successful'),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    fontSize: 12.0,
  );
}

void showSignatureSaveMessage(BuildContext context) {
  Fluttertoast.showToast(
    msg: context.tr('signature_save'),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    fontSize: 12.0,
  );
}
