import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    fontSize: 12.0,
  );
}

void showMessageLong(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
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

void showSignatureSaveMessage() {
  Fluttertoast.showToast(
    msg: "บันทึกลายเซ็นสำเร็จ",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    fontSize: 12.0,
  );
}
