import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

//Using [ Login ]
class TextFieldLogin extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool hidetext;

  const TextFieldLogin({
    Key? key,
    required this.label,
    required this.onChanged,
    this.hidetext = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        obscureText: hidetext,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: '$label',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
      ),
    );
  }
}

//Using [ Login ]
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: const Color.fromARGB(255, 53, 53, 53),
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

  const Footer({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'By using T-Service Connect, you agree and consent to our ',
        style: TextStyle(
          fontSize: 14,
          color: const Color.fromARGB(255, 18, 18, 18),
        ),
        children: [
          TextSpan(
            text: 'Terms and Condition, Privacy Policy.',
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(255, 33, 32, 32),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
