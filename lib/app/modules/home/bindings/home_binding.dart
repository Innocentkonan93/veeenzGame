import 'package:get/get.dart';
import 'package:veeenz/app/modules/game/controllers/game_controller.dart';
import 'package:veeenz/app/modules/settings/controllers/settings_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );

    Get.lazyPut<GameController>(
      () => GameController(),
      fenix: true,
    );

    Get.lazyPut<SettingsController>(
      () => SettingsController(),
      fenix: true,
    );
  }
}
