import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:veeenz/app/modules/home/views/home_view.dart';
import 'package:veeenz/components/count_down.dart';
import 'package:veeenz/components/custom_app_bar.dart';
import 'package:veeenz/configs/theme.dart';
import 'package:veeenz/models/player.dart';
import 'package:veeenz/widgets/3d_button.dart';
import 'package:veeenz/widgets/runner.dart';

import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  const GameView({super.key, this.player});

  final Player? player;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = context.theme;
    const maxSeconds = 35;

    Get.put(GameController());
    controller.currentPlayer(player);
    controller.getPlayerData();
    controller.getGameDecoration();
    String image = controller.currentDecoration['image'];
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/wallpapers/$image"),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Colors.black12,
            BlendMode.darken,
          ),
          alignment: Alignment.topLeft,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(),
          body: Obx(
            () {
              if (controller.currentPlayer.value == null) {
                return Center(
                  child: Text(
                    'Aucun joueur connecté',
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              controller.oldCounter(controller.seconds.value);
              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        alignment: controller.alignment.value,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.fastOutSlowIn,
                        child: InkWell(
                          onTap: () {
                            if (controller.isStart.value) {
                              controller.widgets.add(
                                Align(
                                  alignment: controller.alignment.value,
                                  child: const Runner(),
                                ),
                              );
                            }
                            if (!controller.positionCaptured
                                .contains(controller.alignment.value)) {
                              controller.positionCaptured.addIf(
                                !controller.positionCaptured
                                    .contains(controller.alignment.value),
                                controller.alignment.value,
                              );
                              controller.playAudio();

                              // Mise à jour des performances avec succès
                              controller.difficultyAdjuster
                                  .updatePerformance(true);

                              if (controller.positionCaptured.length ==
                                  controller.target.value) {
                                controller.level.value++;
                                controller.stop();
                                controller.updatePlayer();
                                controller.showResultDialog(isWin: true);
                                controller.positionCaptured.clear();
                              }
                            } else {
                              // Mise à jour des performances avec échec
                              controller.difficultyAdjuster
                                  .updatePerformance(false);
                            }
                          },
                          child: Visibility(
                            visible: controller.isStart.value,
                            child: Image.asset(
                              'assets/images/flutter_dash.png',
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(70),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: !controller.isStart.value
                              ?
                              // ? StartButton(
                              //     maxSeconds: maxSeconds,
                              //     seconds: controller.seconds.value,
                              //     onTap: controller.start,
                              //   )

                              Button3D(
                                  height: size.width / 3,
                                  width: size.width / 3,
                                  style: StyleOf3dButton(
                                    borderRadius: BorderRadius.circular(
                                      200,
                                    ),
                                    topColor: theme.colorScheme.secondary,
                                  ),
                                  onPressed: controller.start,
                                  child: Text(
                                    "Play".tr,
                                    style: theme.textTheme.displaySmall,
                                  ),
                                )
                              : CountDown(
                                  percent: controller.seconds / maxSeconds,
                                  oldCount: controller.oldCounter.value,
                                  seconds: controller.seconds.value,
                                ),
                        ),
                      ),
                      ...controller.widgets,
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: Obx(() {
            if (controller.currentPlayer.value == null) {
              return const SizedBox();
            }
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: controller.isStart.value
                          ? controller.stop
                          : controller.start,
                      borderRadius: BorderRadius.circular(30),
                      child: CircleAvatar(
                        radius: 30,
                        // backgroundColor: Colors.blue.shade50,
                        child: Icon(
                          controller.isStart.value
                              ? Icons.pause
                              : Icons.play_arrow_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 40,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.stop();
                        Get.offAll(
                          () => const HomeView(),
                          fullscreenDialog: true,
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColor.white,
                        child: Icon(
                          Icons.home_rounded,
                          color: Color.fromARGB(255, 83, 100, 92),
                          size: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.isStart.value &&
                            controller.currentPlayer.value!.powers != 0) {
                          controller.currentPlayer(
                              controller.currentPlayer.value!.decrementPower());
                          controller.seconds.value =
                              (controller.seconds.value + 10 <= maxSeconds)
                                  ? controller.seconds.value + 10
                                  : maxSeconds;
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            // backgroundColor: Colors.blue.shade50,
                            child: Icon(
                              Icons.timer_10_rounded,
                              color: theme.colorScheme.primary,
                              size: 30,
                            ),
                          ),
                          if (controller.currentPlayer.value!.powers != 0)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: AppColor.red,
                                radius: 10,
                                child: Text(
                                  controller.currentPlayer.value!.powers
                                      .toString(),
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().slideY(
                  begin: 1,
                  end: 0,
                  curve: Curves.bounceInOut,
                );
          })),
    );
  }
}
