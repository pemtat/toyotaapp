import 'package:flutter/material.dart';

class ImageRow extends StatelessWidget {
  final List<String> imageUrls;

  const ImageRow({
    Key? key,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < imageUrls.length; i++)
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Column(
              children: [
                _buildImageWidget(imageUrls[i]),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildImageWidget(String url) {
    return Container(
      width: 58.0,
      height: 58.0,
      child: Image.asset(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}
