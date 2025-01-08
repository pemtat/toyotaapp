import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

void sparePartRemarkEditModal(
    BuildContext context, Rx<TextEditingController> remark, String title) {
  Rx<TextEditingController> remarkNow =
      Rx<TextEditingController>(TextEditingController(text: remark.value.text));

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: white4,
        title: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: white4,
          title: Text(title, style: TextStyleList.title1),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: remarkNow.value,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'หมายเหตุ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              remark.value = remarkNow.value;
              Navigator.pop(context);
            },
            child: Text(
              'บันทึก',
              style: TextStyleList.text5,
            ),
          ),
          TextButton(
            onPressed: () {
              remarkNow.value.clear();
              Navigator.pop(context);
            },
            child: Text(
              'ยกเลิก',
              style: TextStyleList.text5,
            ),
          ),
        ],
      );
    },
  );
}
