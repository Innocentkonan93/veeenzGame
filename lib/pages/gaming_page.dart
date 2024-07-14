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
import 'package:veeenz/services/ai_ajuster.dart';
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
  AIDifficultyAdjuster difficultyAdjuster = AIDifficultyAdjuster();
  static const maxSeconds = 35;

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
    // int duration = getMovementDurationFromLevel(level);
    int duration = difficultyAdjuster.getAdjustedMovementDuration(level);
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

                      // Mise à jour des performances avec succès
                      difficultyAdjuster.updatePerformance(true);

                      if (positionCaptured.length == target) {
                        setState(() {
                          level++;
                        });
                        stop();
                        LocalStorage().updatePlayerLevel(level);
                        showResultDialog(isWin: true);
                        positionCaptured.clear();
                      }
                    } else {
                      // Mise à jour des performances avec échec
                      difficultyAdjuster.updatePerformance(false);
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
              InkWell(
                onTap: isStart ? stop : start,
                borderRadius: BorderRadius.circular(30),
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
              InkWell(
                onTap: () =>
                    Get.offAll(() => const HomePage(), fullscreenDialog: true),
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
                  if (isStart && widget.player.powers != 0) {
                    setState(() {
                      widget.player.decrementPower();
                      seconds = (seconds + 10 <= maxSeconds)
                          ? seconds + 10
                          : maxSeconds;
                    });
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: AppColor.red,
                        radius: 10,
                        child: Text(
                          widget.player.powers.toString(),
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
          ),
    );
  }
}
