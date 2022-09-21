import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeenz_game/components/count_down.dart';
import 'package:veeenz_game/pages/home_page.dart';
import 'package:veeenz_game/pages/results_view.dart';

import '../components/custom_app_bar.dart';
import '../components/start_button.dart';
import '../models/player.dart';

class GamingPage extends StatefulWidget {
  const GamingPage({super.key, required this.player});
  final Player player;

  @override
  State<GamingPage> createState() => _GamingPageState();
}

class _GamingPageState extends State<GamingPage> {
  static const maxSeconds = 35;
  int seconds = maxSeconds;
  AlignmentGeometry alignment = Alignment.center;
  int counter = 0;
  GetStorage storage = GetStorage();
  int? oldCounter;
  Timer? _debounce;
  Timer? _timer;
  List<Widget> widgets = [];
  List<AlignmentGeometry> positionCaptured = [];

  //user level
  int level = 1;
  int target = 8;

  late AssetsAudioPlayer _assetsAudioPlayer;

  bool isCompleted = false;
  bool isStart = false;

  movment(int tick) {
    const map = {
      // Circle movment
      0: Alignment.topCenter,
      1: Alignment.topRight,
      2: Alignment.centerRight,
      3: Alignment.bottomRight,
      4: Alignment.bottomCenter,
      5: Alignment.bottomLeft,
      6: Alignment.centerLeft,
      7: Alignment.topLeft,
      8: Alignment.topCenter,
      // Z mouvment
      9: Alignment.topLeft,
      10: Alignment.topCenter,
      11: Alignment.topRight,
      12: Alignment.bottomLeft,
      13: Alignment.bottomCenter,
      14: Alignment.bottomRight,
      15: Alignment.centerLeft,
      16: Alignment.centerRight,
      // N mouvment
      17: Alignment.bottomLeft,
      18: Alignment.centerLeft,
      19: Alignment.topLeft,
      20: Alignment.bottomRight,
      21: Alignment.centerRight,
      22: Alignment.topRight,
      23: Alignment.topCenter,
      24: Alignment.bottomCenter,
    };
    setState(() {
      alignment = map[tick] ?? Alignment.center;
    });
  }

  void start() {
    setState(() {
      isStart = true;
    });
    startTimer();
    startMovement2();
  }

  void startMovement() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer.periodic(const Duration(milliseconds: 1300), (timer) {
      if (mounted) {
        if (isCompleted) {
          counter--;
        } else {
          counter++;
        }
      }
      if (counter >= 8) {
        setState(() {
          isCompleted = true;
        });
      }
      if (counter <= 0) {
        setState(() {
          isCompleted = false;
        });
      }
      movment(counter);
    });
  }

  void startMovement2() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer.periodic(const Duration(milliseconds: 1300), (timer) {
      setState(() {
        counter = Random().nextInt(20);
      });
      if (kDebugMode) {
        print(counter);
      }
      movment(counter);
    });
  }

  void stop() {
    _debounce!.cancel();
    _timer!.cancel();
    // seconds = maxSenconds;
    counter = 0;
    setState(() {
      //!
      alignment = Alignment.center;
      //?
      isStart = false;
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stop();
        showResultDialog(isWin: false);
      }
    });
  }

  void showResultDialog({bool isWin = false}) {
    showDialog(
      context: context,
      barrierLabel: "resultDialog",
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(8),
          child: ResultView(
            isWin: isWin,
            player: widget.player.copyWith(position: level),
          ),
        );
      },
    );
  }

  void updatePlayerLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("level", level);
  }

  getPlayerLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getInt("level") ?? 1;
    });
  }

  @override
  void initState() {
    getPlayerLevel();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  Future playAudio() async {
    Audio audio = Audio("assets/audios/catchit.mp3");
    AssetsAudioPlayer.playAndForget(audio);
  }

  @override
  Widget build(BuildContext context) {
    oldCounter = seconds;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(levelTarget: target - positionCaptured.length),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: alignment,
                duration: const Duration(milliseconds: 100),
                curve: Curves.slowMiddle,
                child: InkWell(
                  onTap: () {
                    if (isStart == true) {
                      widgets.add(
                        Align(
                          alignment: alignment,
                          child: const Runner(),
                        ),
                      );
                    }
                    if (!positionCaptured.contains(alignment)) {
                      positionCaptured.add(alignment);
                      playAudio();
                      setState(() {});
                      if (positionCaptured.length == 8) {
                        setState(() {
                          level++;
                        });
                        stop();
                        updatePlayerLevel();
                        showResultDialog(isWin: true);
                        positionCaptured.clear();
                      }
                    }
                  },
                  child: const FlutterLogo(size: 40),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.black12,
                ),
                child: Center(
                  child: isStart == false
                      ? StartButton(
                          maxSeconds: maxSeconds,
                          seconds: seconds,
                          onTap: () {
                            start();
                          },
                        )
                      : CountDown(
                          percent: seconds / maxSeconds,
                          oldCount: oldCounter,
                          seconds: seconds,
                        ),
                ),
              ),
              ...widgets,
            ],
          ),
          // child: Alimated,
        ),
      ),
      bottomNavigationBar: Container(
        // height: 120,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.black12,
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (isStart) {
                    stop();
                  } else {
                    start();
                  }
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    isStart ? Icons.pause : Icons.play_arrow_rounded,
                    color: const Color.fromARGB(255, 75, 78, 187),
                    size: 40,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.offAll(
                    () => const HomePage(),
                    fullscreenDialog: true,
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade50,
                  child: const Icon(
                    Icons.home_rounded,
                    color: Color.fromARGB(255, 83, 100, 92),
                    size: 40,
                  ),
                ),
              ),
              GestureDetector(
                onTap: playAudio,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    Icons.replay_rounded,
                    color: Colors.orange.shade900,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Runner extends StatelessWidget {
  const Runner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const FlutterLogo(
          size: 40,
          textColor: Colors.grey,
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
