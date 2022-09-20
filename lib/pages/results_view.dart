import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../models/player.dart';
import 'gaming_page.dart';

class ResultView extends StatefulWidget {
  const ResultView({
    Key? key,
    required this.isWin,
    required this.player,
  }) : super(key: key);

  final bool isWin;
  final Player player;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();

    Future.delayed(const Duration(seconds: 8), () {
      _controllerCenter.stop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isWin = widget.isWin;
    Player player = widget.player;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: isWin == true
              ? const Text('Niveau supérieur')
              : const Text('Echec'),
        ),
        body: isWin == true
            ? ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirection: pi / 2,
                canvas: MediaQuery.of(context).size,

                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify // manually specify the colors to be used
                strokeWidth: 1,
                strokeColor: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "😀",
                        style: TextStyle(
                          fontSize: 100,
                        ),
                        textAlign: TextAlign.center,
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
                        "Vous passer au niveau supérieur ",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 70,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white12,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white24,
                            child: Text(
                              player.position.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 70,
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
                        ),
                        child: Text(
                          'Continuer',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.black,
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
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "🥹",
                      style: TextStyle(
                        fontSize: 100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Dommage !",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Tu peux toujours réessayer ",
                      style: Theme.of(context).textTheme.bodyText1,
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
                      ),
                      child: Text(
                        'Réessayer',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
