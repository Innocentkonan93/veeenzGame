import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  static const red = Color(0xffd64e4e);
  static const blue = Color(0xff5663ff);
  static const green = Color(0xff73d373);
  static const lightBlue = Color(0xff56c6fc);
  static const lightGrey = Color.fromARGB(78, 255, 255, 255);
  static const black = Color(0xff23272c);
  static const white = Color(0xffffffff);
}

final dartTheme = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
  ),
  // scaffoldBackgroundColor: const Color.fromARGB(255, 59, 59, 59),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff34495E),
  ),
  highlightColor: AppColor.lightGrey,
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppColor.lightGrey,
    isDense: true,
    hintStyle: TextStyle(
      color: AppColor.lightGrey,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.jost(
      fontSize: 60,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: GoogleFonts.jost(
      fontSize: 45,
      fontWeight: FontWeight.w800,
      color: AppColor.white,
    ),
    displaySmall: GoogleFonts.jost(
      fontSize: 34,
      fontWeight: FontWeight.normal,
      // color: AppColor.white,
    ),
    headlineMedium: GoogleFonts.jost(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColor.white,
    ),
    headlineSmall: GoogleFonts.jost(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColor.white,
    ),
    titleLarge: GoogleFonts.jost(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColor.white,
    ),
    bodyLarge: GoogleFonts.jost(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.white,
    ),
    bodyMedium: GoogleFonts.jost(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.white,
    ),
    bodySmall: GoogleFonts.jost(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColor.lightGrey,
    ),
  ),
);

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 228, 228, 228),
  iconTheme: const IconThemeData(
    color: AppColor.blue,
  ),
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColor.black,
      onPrimary: AppColor.white,
      secondary: AppColor.blue,
      onSecondary: AppColor.white,
      error: Colors.red,
      onError: AppColor.white,
      surface: AppColor.black,
      onSurface: AppColor.lightGrey),
  highlightColor: AppColor.lightGrey,
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppColor.lightGrey,
    isDense: true,
    hintStyle: TextStyle(
      color: AppColor.lightGrey,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.jost(
      fontSize: 60,
      fontWeight: FontWeight.normal,
    ),
    displayMedium: GoogleFonts.jost(
      fontSize: 45,
      fontWeight: FontWeight.w800,
      color: AppColor.blue,
    ),
    displaySmall: GoogleFonts.jost(
      fontSize: 34,
      fontWeight: FontWeight.normal,
      // color: AppColor.blue,
    ),
    headlineMedium: GoogleFonts.jost(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColor.blue,
    ),
    headlineSmall: GoogleFonts.jost(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColor.blue,
    ),
    titleLarge: GoogleFonts.jost(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColor.blue,
    ),
    bodyLarge: GoogleFonts.jost(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.blue,
    ),
    bodyMedium: GoogleFonts.jost(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.blue,
    ),
    bodySmall: GoogleFonts.jost(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColor.lightGrey,
    ),
  ),
);
