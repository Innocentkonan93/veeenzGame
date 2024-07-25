import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeenz/app/routes/app_pages.dart';
import 'package:veeenz/configs/app_theme.dart';
import 'package:veeenz/utils/constants.dart';
import 'package:veeenz/utils/localisation.dart';

bool? isDarkMode;
String locale = "en_US";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();
  isDarkMode = (pref.getBool('dark_mode') ?? true);

  locale = pref.getString('language') ?? locale;

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    Future.wait([
      precacheImage(const AssetImage('assets/wallpapers/dices.jpg'), context),
      precacheImage(const AssetImage('assets/wallpapers/fantasy.jpg'), context),
      precacheImage(const AssetImage('assets/wallpapers/moon.jpg'), context),
      precacheImage(
          const AssetImage('assets/wallpapers/mountains.jpg'), context),
      precacheImage(
          const AssetImage('assets/wallpapers/mushroom.jpg'), context),
      precacheImage(const AssetImage('assets/wallpapers/neon.jpg'), context),
      precacheImage(const AssetImage('assets/wallpapers/squares.jpg'), context),
      precacheImage(const AssetImage('assets/images/dash-cloud.png'), context),
      precacheImage(
          const AssetImage('assets/images/loading-gradient.jpg'), context),
    ]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Translate(),
      supportedLocales: [
        // Locale('en', 'US'),
        // Locale('fr', 'FR'),
        // Locale('en', 'ES'),
        // Locale('en', 'ES'),
        ...List.generate(
          allLanguages.length,
          (index) {
            String localeCode = allLanguages[index]['locale'];
            return Locale(
              localeCode.split("_").first,
              localeCode.split("_").last,
            );
          },
        )
      ],
      locale: Locale(locale.split('_').first, locale.split('_').last),
      // fallbackLocale: const Locale('en', "US"),
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
