import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Color(0xFF6B38FB);

class Gap {
  static const double zero = 0;
  static const double xxs = 2;
  static const double xs = 4;
  static const double s = 8;
  static const double m = 16;
  static const double l = 32;
  static const double xl = 48;
}

final TextTheme projectTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    fontSize: 92,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.poppins(
    fontSize: 57,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.poppins(
    fontSize: 46,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.poppins(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.poppins(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.quicksand(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.quicksand(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

ThemeData projectTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: primaryColor,
  accentColor: secondaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: projectTextTheme,
  buttonTheme: ButtonThemeData(
    buttonColor: secondaryColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
  ),
);
