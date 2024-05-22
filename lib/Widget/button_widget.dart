import 'package:flutter/material.dart';
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
            style: TextStyleList.detail4,
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
            style: TextStyleList.textbutton,
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
            style: TextStyleList.textbutton,
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
            style: TextStyleList.textbutton,
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
      child: Text(text, style: TextStyleList.buttontext),
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
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyleList.buttontext2,
        ),
      ),
    );
  }
}
