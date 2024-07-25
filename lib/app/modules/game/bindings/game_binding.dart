import 'package:get/get.dart';
import 'package:veeenz/app/modules/home/controllers/home_controller.dart';

import '../controllers/game_controller.dart';

class GameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(
      () => GameController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
  }
}
