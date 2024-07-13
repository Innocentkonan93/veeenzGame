import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/configs/theme.dart';

import '../models/player.dart';
import 'gaming_page.dart';

class ResultView extends StatefulWidget {
  const ResultView({
    super.key,
    required this.isWin,
    required this.player,
    required this.levelDescription,
  });

  final bool isWin;
  final Player player;
  final String levelDescription;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late ConfettiController _controllerCenter;
  late AssetsAudioPlayer _assetsAudioPlayer;

  @override
  void initState() {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    playAudio();
    _controllerCenter = ConfettiController();
    _controllerCenter.play();

    Future.delayed(const Duration(seconds: 3), () {
      _controllerCenter.stop();
    });
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  Future playAudio() async {
    Audio audio = Audio("assets/audios/winning.mp3");
    if (widget.isWin) {
      AssetsAudioPlayer.playAndForget(audio);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isWin = widget.isWin;
    Player player = widget.player;
    final theme = context.theme;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: isWin == true
            ? ConfettiWidget(
                confettiController: _controllerCenter,
                maximumSize: const Size(15, 10),
                minimumSize: const Size(15, 10),
                blastDirection: pi / 2,
                canvas: MediaQuery.of(context).size,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: Text(
                            "😄",
                            style: TextStyle(
                              fontSize: 80,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Text(
                        "Félicitations ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Vous passez au niveau supérieur",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.levelDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        backgroundColor: Colors.green[700],
                        radius: 80,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.green,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.green[300],
                            child: Text(
                              player.position.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 60,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => GamingPage(
                                player: player,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          elevation: 0.0,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(12),
                          minimumSize: const Size(270, 50),
                        ),
                        child: Text(
                          'Continuer',
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "🥹",
                      style: TextStyle(
                        fontSize: 80,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Dommage !",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColor.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Tu peux toujours réessayer",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => GamingPage(
                              player: player,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        elevation: 0.0,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(12),
                        minimumSize: const Size(270, 50),
                      ),
                      child: Text(
                        'Réessayer',
                        style: theme.textTheme.titleLarge,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
