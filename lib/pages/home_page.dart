import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veeenz_game/models/player.dart';
import 'package:veeenz_game/pages/gaming_page.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => GamingPage(
                        player: player,
                      ),
                    );
                  },
                  child: Text(
                    'Play',
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Leaderboard',
                  style: GoogleFonts.fredokaOne(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Setting',
                  style: GoogleFonts.fredokaOne(
                    color: Colors.white,
                    fontSize: 30,
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
