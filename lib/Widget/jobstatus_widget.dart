import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobStatusItem extends StatelessWidget {
  final String count;
  final String title;
  final Color countColor;
  final Color titleColor;
  final Color containerColor;
  final String? imagePath;
  final int flexValue;
  final bool? center;

  const JobStatusItem({
    super.key,
    required this.count,
    required this.title,
    required this.countColor,
    required this.titleColor,
    required this.containerColor,
    this.imagePath,
    required this.flexValue,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexValue,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          image: imagePath != null
              ? DecorationImage(
                  image: AssetImage(imagePath!),
                  alignment: Alignment.bottomRight,
                )
              : null,
          color: containerColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            center == false
                ? Text(
                    count,
                    style: GoogleFonts.kanit(
                      color: countColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Center(
                    child: Text(
                      count,
                      style: GoogleFonts.kanit(
                        color: countColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
            center == true
                ? Center(
                    child: Text(
                      title,
                      style: GoogleFonts.kanit(
                        color: titleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : Text(
                    title,
                    style: GoogleFonts.kanit(
                      color: titleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
