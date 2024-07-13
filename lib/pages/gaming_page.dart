import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeenz/components/count_down.dart';
import 'package:veeenz/configs/theme.dart';
import 'package:veeenz/local_storage.dart/local_storage.dart';
import 'package:veeenz/pages/home_page.dart';
import 'package:veeenz/pages/results_view.dart';
import 'package:veeenz/utils/constants.dart';

import '../components/custom_app_bar.dart';
import '../components/start_button.dart';
import '../models/player.dart';
import '../widgets/runner.dart';

class GamingPage extends StatefulWidget {
  const GamingPage({super.key, required this.player});
  final Player player;

  @override
  State<GamingPage> createState() => _GamingPageState();
}

class _GamingPageState extends State<GamingPage> {
  static const maxSeconds = 35;
  static const movementMap = {
    // Circle movement
    0: Alignment.topCenter,
    1: Alignment.topRight,
    2: Alignment.centerRight,
    3: Alignment.bottomRight,
    4: Alignment.bottomCenter,
    5: Alignment.bottomLeft,
    6: Alignment.centerLeft,
    7: Alignment.topLeft,
    8: Alignment.topCenter,
    // Z movement
    9: Alignment.topLeft,
    10: Alignment.topCenter,
    11: Alignment.topRight,
    12: Alignment.bottomLeft,
    13: Alignment.bottomCenter,
    14: Alignment.bottomRight,
    15: Alignment.centerLeft,
    16: Alignment.centerRight,
    // N movement
    17: Alignment.bottomLeft,
    18: Alignment.centerLeft,
    19: Alignment.topLeft,
    20: Alignment.bottomRight,
    21: Alignment.centerRight,
    22: Alignment.topRight,
    23: Alignment.topCenter,
    24: Alignment.bottomCenter,
    // Additional movements for variety
    25: Alignment.topLeft,
    26: Alignment.bottomRight,
    27: Alignment.topRight,
    28: Alignment.bottomLeft,
    29: Alignment.centerLeft,
    30: Alignment.centerRight,
    31: Alignment.topCenter,
    32: Alignment.bottomCenter,
    33: Alignment.topLeft,
    34: Alignment.centerRight,
    35: Alignment.bottomLeft,
    36: Alignment.topRight,
    37: Alignment.centerLeft,
    38: Alignment.bottomRight,
    39: Alignment.center,
    40: Alignment.topCenter,
    41: Alignment.topRight,
    42: Alignment.centerRight,
    43: Alignment.bottomRight,
    44: Alignment.bottomCenter,
    45: Alignment.bottomLeft,
    46: Alignment.centerLeft,
    47: Alignment.topLeft,
    48: Alignment.center,
  };

  int seconds = maxSeconds;
  int counter = 0;
  int? oldCounter;
  Timer? _debounce;
  Timer? _timer;
  List<Widget> widgets = [];
  AlignmentGeometry alignment = Alignment.center;
  List<AlignmentGeometry> positionCaptured = [];
  GetStorage storage = GetStorage();
  int level = 1;
  int target = 8;
  late AssetsAudioPlayer _assetsAudioPlayer;
  bool isCompleted = false;
  bool isStart = false;

  @override
  void initState() {
    super.initState();
    getPlayerLevel();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  // Movement Methods
  void allMovement(int tick) {
    final newAlignment = movementMap[tick];
    if (newAlignment != null) {
      setState(() {
        alignment = newAlignment;
      });
    } else {
      if (kDebugMode) {
        print('Invalid tick value: $tick');
      }
    }
  }

  void accuracyMovement(int level) {
    int duration = getMovementDurationFromLevel(level);
    _debounce?.cancel();
    _debounce = Timer.periodic(Duration(milliseconds: duration), (timer) {
      if (mounted) {
        counter = isCompleted ? counter - 1 : counter + 1;
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
        allMovement(counter);
      }
    });
  }

  void randomMovement(int level) {
    int duration = getMovementDurationFromLevel(level);
    _debounce?.cancel();
    _debounce = Timer.periodic(Duration(milliseconds: duration), (timer) {
      if (mounted) {
        setState(() {
          counter = Random().nextInt(20);
        });
        allMovement(counter);
      }
    });
  }

  // Helper Methods
  int getMovementDurationFromLevel(int level) {
    if (level <= 9) return 1300;
    if (level >= 10 && level <= 19) return 1000;
    if (level >= 20) return 700;
    return 1300;
  }

  Future<void> getPlayerLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getInt("level") ?? 1;
    });
    getLevelTarget(level);
    getTimerBasedOnLevel(level);
  }

  void getLevelTarget(int level) {
    if (level > 15 && mounted) {
      setState(() {
        target = 4;
      });
    }
  }

  void getTimerBasedOnLevel(int level) {
    if (level > 10 && mounted) {
      setState(() {
        seconds = 25;
      });
    }
  }

  // Game Control Methods
  void start() {
    setState(() {
      isStart = true;
    });
    startTimer();
    level <= 10 ? accuracyMovement(level) : randomMovement(level);
  }

  void stop() {
    _debounce?.cancel();
    _timer?.cancel();
    setState(() {
      alignment = Alignment.center;
      isStart = false;
    });
  }

  // Timer Method
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        if (mounted) {
          setState(() {
            seconds--;
          });
        }
      } else {
        stop();
        showResultDialog(isWin: false);
      }
    });
  }

  // UI Methods
  Future<void> playAudio() async {
    Audio audio = Audio("assets/audios/catchit.mp3");
    AssetsAudioPlayer.playAndForget(audio);
  }

  void showResultDialog({bool isWin = false}) {
    String levelDescription = getLevelDescription(level);
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
            levelDescription: levelDescription,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    oldCounter = seconds;
    final size = MediaQuery.sizeOf(context);
    final theme = context.theme;
    return Scaffold(
      appBar: CustomAppBar(levelTarget: target - positionCaptured.length),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: alignment,
                duration: const Duration(milliseconds: 100),
                curve: Curves.slowMiddle,
                child: InkWell(
                  onTap: () {
                    if (isStart) {
                      widgets.add(
                        Align(
                          alignment: alignment,
                          child: const Runner(),
                        ),
                      );
                    }
                    if (!positionCaptured.contains(alignment)) {
                      positionCaptured.addIf(
                        !positionCaptured.contains(alignment),
                        alignment,
                      );
                      playAudio();
                      setState(() {});
                      if (positionCaptured.length == target) {
                        setState(() {
                          level++;
                        });
                        stop();
                        LocalStorage().updatePlayerLevel(level);
                        showResultDialog(isWin: true);
                        positionCaptured.clear();
                      }
                    }
                  },
                  child: Visibility(
                    visible: isStart,
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
                  child: !isStart
                      ? StartButton(
                          maxSeconds: maxSeconds,
                          seconds: seconds,
                          onTap: start,
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
        ),
      ),
      bottomNavigationBar: Container(
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
              GestureDetector(
                onTap: isStart ? stop : start,
                child: CircleAvatar(
                  radius: 30,
                  // backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    isStart ? Icons.pause : Icons.play_arrow_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 40,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Get.offAll(() => const HomePage(), fullscreenDialog: true),
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
              GestureDetector(
                onTap: () {
                  if (widget.player.powers != 0) {
                    setState(() {
                      seconds = (seconds + 10 <= maxSeconds)
                          ? seconds + 10
                          : maxSeconds;
                    });
                  }
                },
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 10,
                        child: Text(
                          widget.player.powers.toString(),
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
          ),
    );
  }
}
