import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Widget/dashedborder_widget.dart';

class UploadImageWidget extends StatelessWidget {
  final VoidCallback pickImage;
  const UploadImageWidget({super.key, required this.pickImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pickImage,
      child: Container(
        color: white8,
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: CustomPaint(
          painter: DashedBorderPainter(),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload, size: 18, color: Colors.black),
                SizedBox(height: 2),
                Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 8, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
