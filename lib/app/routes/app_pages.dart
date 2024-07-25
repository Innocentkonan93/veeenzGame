import 'package:get/get.dart';

import '../modules/game/bindings/game_binding.dart';
import '../modules/game/views/game_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/starting/bindings/starting_binding.dart';
import '../modules/starting/views/starting_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.STARTING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GAME,
      page: () => const GameView(),
      binding: GameBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.STARTING,
      page: () => const StartingView(),
      binding: StartingBinding(),
    ),
  ];
}
