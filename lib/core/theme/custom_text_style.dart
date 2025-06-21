import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle subtitleLarge = GoogleFonts.notoSans(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black,
  );
  static TextStyle subtitleMedium = GoogleFonts.notoSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle subtitleSmall = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle footNode =GoogleFonts.notoSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF7F8493),
  );


  static TextTheme defaultTextTheme = TextTheme(
    displayLarge: GoogleFonts.notoSans(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.notoSans(
      fontSize: 45,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.notoSans(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineLarge: GoogleFonts.notoSans(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.notoSans(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headlineSmall: GoogleFonts.notoSans(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.notoSans(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.notoSans(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.notoSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelLarge: GoogleFonts.notoSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelMedium: GoogleFonts.notoSans(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    labelSmall: GoogleFonts.notoSans(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.notoSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.notoSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodySmall: GoogleFonts.notoSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );
}
