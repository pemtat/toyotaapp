import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyotamobile/Styles/color.dart'; // Assuming this file defines the 'link' and 'warranty' colors

class TextStyleList {
  static final TextStyle headline = GoogleFonts.kanit(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final TextStyle topbar = GoogleFonts.kanit(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static final TextStyle titlebar = GoogleFonts.kanit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xff707070),
  );
  static final TextStyle detail1 = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xff545454),
  );

  static final TextStyle detail2 = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xff323232),
  );

  static final TextStyle detail3 = GoogleFonts.kanit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xff707070),
  );
  static final TextStyle fileattacth = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xff707070),
  );

  static final TextStyle detail5 = GoogleFonts.kanit(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(140, 112, 112, 112),
  );

  static final TextStyle detail4 = GoogleFonts.kanit(
    color: link,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
    decorationColor: link,
  );

  static final TextStyle warrantytitle = GoogleFonts.kanit(
    color: warranty,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle warrantytitle2 = GoogleFonts.kanit(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle searchtext = GoogleFonts.kanit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xff545454),
  );
  static final TextStyle intruction = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xff000000),
  );
  static final TextStyle footer = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xff000000),
    decoration: TextDecoration.underline,
  );
  static final TextStyle intructionDetail = GoogleFonts.kanit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xff545454),
  );
  static final TextStyle title = GoogleFonts.kanit(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xff323232),
  );
  static final TextStyle textbutton = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xffEB0A1E),
  );
  static final TextStyle subdetail = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xff323232),
  );
  static final TextStyle namenote = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xff272727),
  );
  static final TextStyle texttitle = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xff5A5A5A),
  );
  static final TextStyle buttontext = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(124, 29, 27, 32),
  );
  static final TextStyle buttontext2 = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: buttontextcolor,
  );
  static final TextStyle buttontext3 = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: buttontextcolor2,
  );
  static final TextStyle dialogbutton = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: dialogbuttoncolor,
  );
  static final TextStyle dialogbutton2 = GoogleFonts.kanit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: buttontextcolor,
  );
  static final TextStyle headmodal = GoogleFonts.kanit(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: textmodal,
  );
}
