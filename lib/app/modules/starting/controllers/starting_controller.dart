import 'package:get/get.dart';
import 'package:veeenz/app/modules/home/views/home_view.dart';

class StartingController extends GetxController {
  final showLoading = false.obs;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const HomeView());
    });
    super.onReady();
  }
}
