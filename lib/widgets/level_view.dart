import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/app/modules/game/controllers/game_controller.dart';
import 'package:veeenz/app/modules/home/views/how_to_play_page.dart';
import 'package:veeenz/utils/constants.dart';

class LevelView extends GetWidget<GameController> {
  const LevelView({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    getLevelDescription(level);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const HowToPlayPage(),
                fullscreenDialog: true,
                // transition: Transition.fadeIn,
                duration: const Duration(
                  milliseconds: 300,
                ),
              );
            },
            icon: const Icon(CupertinoIcons.question_circle),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: "level",
                child: Container(
                  padding: const EdgeInsets.all(30),
                  // height: Get.width / 2,
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: theme.colorScheme.surfaceTint.withOpacity(.1),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Level".tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.w200),
                        ),
                        Text(
                          level.toString(),
                          style: theme.textTheme.displayMedium!.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              getLevelDescription(level),
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
