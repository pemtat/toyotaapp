import 'package:flutter/material.dart';

class UrlImageWidget extends StatelessWidget {
  final String urlString;

  const UrlImageWidget(this.urlString, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: NetworkImage(urlString),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
