import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart'; // Adjust the import path as needed
import 'package:toyotamobile/Styles/text.dart'; // Adjust the import path as needed

class ShowTextFieldWidget extends StatelessWidget {
  final String text;
  final String hintText;
  final TextInputType? number;
  final String? addtionalText;
  const ShowTextFieldWidget({
    super.key,
    required this.text,
    this.number,
    this.addtionalText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 8,
            child: TextField(
              readOnly: true,
              keyboardType: number ?? TextInputType.text,
              decoration: InputDecoration(
                hintText: '$hintText',
                hintStyle: TextStyleList.text11,
                filled: true,
                fillColor: black5,
                enabledBorder: addtionalText != null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        borderSide: BorderSide(
                          color: white2,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: white2,
                          width: 1,
                        ),
                      ),
                focusedBorder: addtionalText != null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)),
                        borderSide: BorderSide(
                          color: black3,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: black3),
                      ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 19.0,
                ),
              ),
            ),
          ),
          if (addtionalText != null)
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: white2),
                      bottom: BorderSide(color: white2),
                      top: BorderSide(color: white2),
                    ),
                    color: white6,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(6))),
                child: Center(
                  child: Text('$addtionalText', style: TextStyleList.text11),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ShowTextFieldType extends StatelessWidget {
  final String hintText;

  const ShowTextFieldType({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      maxLines: 3,
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: white2,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyleList.text12,
        contentPadding: const EdgeInsets.only(
          left: 12.0,
          top: 0.0,
          right: 12.0,
          bottom: 20.0,
        ),
      ),
    );
  }
}
