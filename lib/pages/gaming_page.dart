import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  int? oldCounter;
  Timer? _debounce;
  Timer? _timer;
  List<Widget> widgets = [];
  List<AlignmentGeometry> positionCaptured = [];

  bool isCompleted = false;
  bool isStart = false;

  void updatePosition(int tick) {
    switch (tick) {
      case 0:
        setState(() {
          alignment = Alignment.topCenter;
        });
        break;
      case 1:
        setState(() {
          alignment = Alignment.topRight;
        });
        break;
      case 2:
        setState(() {
          alignment = Alignment.centerRight;
        });
        break;
      case 3:
        setState(() {
          alignment = Alignment.bottomRight;
        });
        break;
      case 4:
        setState(() {
          alignment = Alignment.bottomCenter;
        });
        break;
      case 5:
        setState(() {
          alignment = Alignment.bottomLeft;
        });
        break;
      case 6:
        setState(() {
          alignment = Alignment.centerLeft;
        });
        break;
      case 7:
        setState(() {
          alignment = Alignment.topLeft;
        });
        break;
      case 8:
        setState(() {
          alignment = Alignment.topCenter;
        });
        break;
      default:
        _debounce?.cancel();
    }
  }

  void start() {
    setState(() {
      positionCaptured.clear();
      isStart = true;
    });
    startTimer();
    startMovement2();
  }

  void startMovement() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer.periodic(const Duration(milliseconds: 1900), (timer) {
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
      // setState(() {
      //   counter = Random().nextInt(8);
      // });
      // print(counter);
      updatePosition(counter);
    });
  }

  void startMovement2() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer.periodic(const Duration(milliseconds: 1300), (timer) {
      setState(() {
        counter = Random().nextInt(8);
      });
      if (kDebugMode) {
        print(counter);
      }
      updatePosition(counter);
    });
  }

  void stop() {
    _debounce!.cancel();
    _timer!.cancel();
    // seconds = maxSenconds;
    counter = 0;
    setState(() {
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
            player: widget.player,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    oldCounter = seconds;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(),
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
                          child: const ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.black12, BlendMode.darken),
                            child: FlutterLogo(
                              size: 40,
                              textColor: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }
                    if (!positionCaptured.contains(alignment)) {
                      positionCaptured.add(alignment);
                      setState(() {});
                      if (positionCaptured.length == 8) {
                        stop();
                        showResultDialog(isWin: true);
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
              if (isStart) ...widgets,
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
                Get.offAll(() => const HomePage());
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
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade50,
              child: Icon(
                Icons.replay_rounded,
                color: Colors.orange.shade900,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
