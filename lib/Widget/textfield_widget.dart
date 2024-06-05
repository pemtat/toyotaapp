import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final TextInputType? number;
  final TextEditingController textSet;
  final String? addtionalText;
  const TextFieldWidget({
    super.key,
    required this.text,
    required this.textSet,
    this.number,
    this.addtionalText,
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
              keyboardType: number ?? TextInputType.text,
              controller: textSet,
              decoration: InputDecoration(
                hintText: text,
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
                          color: Colors.blue,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
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

class TextFieldEditWidget extends StatelessWidget {
  final String text;
  final TextEditingController textSet;
  final TextInputType? number;
  final String? addtionalText;

  const TextFieldEditWidget({
    super.key,
    required this.text,
    required this.textSet,
    this.number,
    this.addtionalText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: TextField(
              controller: textSet,
              keyboardType: number ?? TextInputType.text,
              decoration: InputDecoration(
                hintText: text,
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
                          color: Colors.blue,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 19.0),
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
