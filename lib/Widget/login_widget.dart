import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:toyotamobile/Styles/text.dart';

//Using [ Login ]
class TextFieldLogin extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool hidetext;

  const TextFieldLogin({
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
          style: TextStyleList.texttitle,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          ),
        ),
      ),
    );
  }
}

//Using [ Login ]
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

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
              'Login',
              style: TextStyleList.dialogbutton2,
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
        style: TextStyleList.fileattacth,
        children: [
          TextSpan(
            text: 'Terms and Condition, Privacy Policy.',
            style: TextStyleList.footer,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
