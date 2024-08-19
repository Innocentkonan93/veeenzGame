import 'package:flutter/material.dart';
import 'package:veeenz/app/configs/text_theme.dart';
import 'package:veeenz/app/configs/theme.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColor.white,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(),
  ),
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 83, 175, 236),
    error: const Color.fromARGB(255, 191, 78, 69),
  ),
  textTheme: textTheme,
);

ThemeData lightTheme = ThemeData.light().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(),
  ),
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 83, 175, 236),
    error: const Color.fromARGB(255, 191, 78, 69),
  ),
  textTheme: darkTextTheme,
);
