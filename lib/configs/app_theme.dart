import 'package:flutter/material.dart';
import 'package:veeenz/configs/text_theme.dart';
import 'package:veeenz/configs/theme.dart';

ThemeData appTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColor.white,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 45, 133, 143),
    error: const Color.fromARGB(255, 191, 78, 69),
  ),
  textTheme: textTheme,
);
