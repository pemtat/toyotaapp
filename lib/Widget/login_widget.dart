import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/text.dart';

//Using [ Login ]
class TextFieldBar extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool hidetext;

  const TextFieldBar({
    super.key,
    required this.label,
    required this.onChanged,
    this.hidetext = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          obscureText: hidetext,
          style: TextStyleList.text11,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyleList.text11,
            floatingLabelStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          ),
        ),
      ),
    );
  }
}

class TextFieldBarVisible extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final RxBool isTextHidden;
  final Function hiddenChange;

  const TextFieldBarVisible({
    super.key,
    required this.label,
    required this.onChanged,
    required this.isTextHidden,
    required this.hiddenChange,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextField(
              obscureText: !isTextHidden.value,
              style: TextStyleList.text11,
              onChanged: onChanged,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    isTextHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    hiddenChange();
                  },
                ),
                labelText: label,
                labelStyle: TextStyleList.text11,
                floatingLabelStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
            ),
          ),
        ));
  }
}

//Using [ Login ]
class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const AppButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: const Color.fromARGB(255, 53, 53, 53),
            ),
            child: Text(
              title,
              style: TextStyleList.text7,
            ),
          ),
        ),
      ],
    );
  }
}

//Using [ Login ]
class Footer extends StatelessWidget {
  final VoidCallback onTap;

  const Footer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'By using T-Service Connect, you agree and consent to our ',
        style: TextStyleList.text1,
        children: [
          TextSpan(
            text: 'Terms and Condition, Privacy Policy.',
            style: TextStyleList.text14,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
