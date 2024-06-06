import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePickerWidget extends StatelessWidget {
  final VoidCallback pickImage;
  final RxList<Map<String, String>> images;

  const ImagePickerWidget(
      {super.key, required this.pickImage, required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: pickImage,
          child: const Text('Pick Image'),
        ),
        Obx(() {
          if (images.isEmpty) {
            return const Text('No images selected');
          } else {
            return Container();
            // return Column(
            //   children: images.map((image) {
            //     return ListTile(
            //       title: Text(image['filename']!),
            //       subtitle:
            //           Text('Content: ${image['content']!.substring(0, 20)}...'),
            //     );
            //   }).toList(),
            // );
          }
        }),
      ],
    );
  }
}
