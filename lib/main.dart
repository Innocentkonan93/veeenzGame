import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeenz/app/routes/app_pages.dart';
import 'package:veeenz/configs/app_theme.dart';

bool? isDarkMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();
  isDarkMode = (pref.getBool('dark_mode') ?? true);

  runApp(const MyApp());
  if (Platform.isMacOS) {
    doWhenWindowReady(() {
      const initialSize = Size(450, 700);
      appWindow.size = initialSize;
      appWindow.minSize = initialSize;
      appWindow.maxSize = const Size(1024, 768);
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],
      locale: const Locale('fr', "FR"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Veeenz Game',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode! ? ThemeMode.dark : ThemeMode.light,
      // home: const HomePage(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
