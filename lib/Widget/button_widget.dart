import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toyotamobile/Styles/color.dart';
import 'package:toyotamobile/Styles/text.dart';

class GoogleMapButton extends StatelessWidget {
  final VoidCallback onTap;

  const GoogleMapButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/send.png',
          width: 12.0,
          height: 12.0,
        ),
        const SizedBox(width: 4.0),
        InkWell(
          onTap: onTap,
          child: Text(
            'Google Map',
            style: TextStyleList.subtext2,
          ),
        ),
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/plus.png',
            width: 20.0,
            height: 20.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            'Add',
            style: TextStyleList.text8,
          ),
        ],
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/edit.png',
            width: 20.0,
            height: 20.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            'Edit',
            style: TextStyleList.text8,
          ),
        ],
      ),
    );
  }
}

class EditButton2 extends StatelessWidget {
  final VoidCallback onTap;

  const EditButton2({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/profileedit.png',
            width: 12.0,
            height: 12.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            'Edit Profile',
            style: TextStyleList.text8,
          ),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffFFFFFF),
        side: const BorderSide(color: Color.fromARGB(112, 158, 158, 158)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Adjust border radius here
        ),
      ),
      child: Text(text, style: TextStyleList.text12),
    );
  }
}

class EndButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const EndButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: red1,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyleList.text13,
        ),
      ),
    );
  }
}

class EndButton2 extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const EndButton2({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: black3,
          foregroundColor: black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyleList.text5,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color background;
  final TextStyle textStyle;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.background,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Colors.red, width: 1.0),
          ),
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}

class ButtonTime extends StatelessWidget {
  final void Function(Rx<String>) saveTime;
  final Rx<String> time;
  final title;
  const ButtonTime(
      {super.key,
      required this.saveTime,
      required this.time,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              saveTime(time);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            child: Text(
              title,
              style: TextStyleList.text7.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonRed extends StatelessWidget {
  final title;
  final VoidCallback onTap;
  const ButtonRed({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            child: Text(
              title,
              style: TextStyleList.text7.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
