import 'package:get/get.dart';
import 'package:veeenz/app/modules/home/controllers/home_controller.dart';

import '../controllers/starting_controller.dart';

class StartingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartingController>(
      () => StartingController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
