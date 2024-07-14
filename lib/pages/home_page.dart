import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veeenz/models/player.dart';
import 'package:veeenz/pages/gaming_page.dart';
import 'package:veeenz/pages/how_to_play_page.dart';
import 'package:veeenz/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Player player = Player.players.first;
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(
                  () => const HowToPlayPage(),
                );
              },
              icon: const Icon(CupertinoIcons.question_circle))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Text(
                "Veeenz",
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.surfaceTint.withOpacity(.4),
                ),
                textScaler: const TextScaler.linear(1.5),
              ),
              const Spacer(),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                child: Image.asset("assets/images/flutter_dash.png"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Get.to(
                        () => GamingPage(
                          player: player,
                        ),
                        fullscreenDialog: true,
                      );
                    },
                    label: Row(
                      children: [
                        Text(
                          'Play',
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
                    onPressed: () {
                      Get.to(() => const SettingsPage());
                    },
                    icon: const Icon(
                      CupertinoIcons.settings,
                    ),
                    label: Row(
                      children: [
                        Text(
                          'Settings',
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
