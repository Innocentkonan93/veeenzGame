import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veeenz/app/modules/game/controllers/game_controller.dart';
import 'package:veeenz/app/modules/game/views/game_view.dart';
import 'package:veeenz/app/modules/settings/controllers/settings_controller.dart';
import 'package:veeenz/app/modules/settings/views/settings_view.dart';

import 'package:veeenz/models/player.dart';
import 'package:veeenz/pages/how_to_play_page.dart';
import 'package:veeenz/widgets/dash_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    Player player = Player.players.first;
    final theme = context.theme;

    Get.put(GameController());
    Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const HowToPlayPage(),
              );
            },
            icon: const Icon(CupertinoIcons.question_circle),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Opacity(
                opacity: .3,
                child: Text(
                  "Veeenz",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    // color: theme.textTheme .withOpacity(.4),
                  ),
                  textScaler: const TextScaler.linear(1.5),
                ),
              ),
              const Spacer(),
              const DashWidget()
                  .animate()
                  .shake(delay: const Duration(seconds: 1)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      await controller.playAudio();
                      Get.to(
                        () => GameView(
                          player: player,
                        ),
                        fullscreenDialog: true,
                      );
                    },
                    label: Row(
                      children: [
                        Text(
                          'Play'.tr,
                          style: GoogleFonts.jost(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    icon: const Icon(CupertinoIcons.play_arrow_solid),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      await controller.playAudio();
                      Get.to(() => const SettingsView());
                    },
                    icon: const Icon(
                      CupertinoIcons.settings,
                    ),
                    label: Row(
                      children: [
                        Text(
                          'Settings'.tr,
                          style: GoogleFonts.jost(
                            color: theme.colorScheme.primary,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
