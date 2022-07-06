import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// we will create the class where we will add all the app style

class AppStyle {
  static Color bgColor = const Color(0xFFF5F5F5);
  static Color primaryColor = const Color(0xFF1e283e);

  //Now we will create the font style

  static TextStyle mainTitleStyle = GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle subTitleStyle = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF808080),
  );
  static TextStyle priceStyle = GoogleFonts.nunito(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );
}
