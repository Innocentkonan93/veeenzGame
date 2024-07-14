import 'package:flutter/material.dart';
import 'package:veeenz/configs/text_theme.dart';
import 'package:veeenz/configs/theme.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColor.white,
    ),
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
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 83, 175, 236),
    error: const Color.fromARGB(255, 191, 78, 69),
  ),
  textTheme: darkTextTheme,
);
