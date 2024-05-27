import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/text.dart';

class AttachmentFile extends StatelessWidget {
  final String name;

  const AttachmentFile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/pdf.png'),
        const SizedBox(height: 4),
        Text(name, style: TextStyleList.subtext3),
      ],
    );
  }
}
