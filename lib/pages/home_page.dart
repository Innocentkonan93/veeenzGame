import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veeenz/models/player.dart';
import 'package:veeenz/pages/gaming_page.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Text(
                "Veeenz",
                style: Theme.of(context).textTheme.displayLarge,
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
                            fontSize: 35,
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
                          'Setting',
                          style: GoogleFonts.jost(
                            color: Theme.of(context).colorScheme.primary,
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
