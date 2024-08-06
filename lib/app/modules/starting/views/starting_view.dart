import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:veeenz/configs/theme.dart';

import '../controllers/starting_controller.dart';

class StartingView extends GetView<StartingController> {
  const StartingView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(StartingController());
    final theme = context.theme;
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFF21DBF6),
                    Color(0XFF03CC93),
                  ],
                  stops: [0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Image.asset(
              "assets/images/loading-gradient.jpg",
              fit: BoxFit.cover,
            ).animate().fadeIn(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 7,
                ),
                SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(15),
                    minHeight: 12,
                  ),
                ),
                Text(
                  'Loading...'.tr,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColor.black,
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: AppColor.white,
                  padding: const EdgeInsets.all(8),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1384 - 1.0.0",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
