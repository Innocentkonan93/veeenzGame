import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz_game/models/player.dart';

import '../pages/results_view.dart';

class GameController extends GetxController {
  static const maxSeconds = 35;
  int seconds = maxSeconds;
  Rx<AlignmentGeometry> alignment = Rx<AlignmentGeometry>(Alignment.center);
  RxInt counter = 0.obs;
  Rxn<int> oldCounter = Rxn<int>();
  Timer? _debounce;
  Timer? _timer;
  List<Widget> widgets = [];
  List<AlignmentGeometry> positionCaptured = [];

  RxBool isCompleted = false.obs;
  RxBool isStart = false.obs;
  RxInt userLevel = 1.obs;

  Player player = const Player(id: "1", name: "Josco", position: 1);

  movment(int tick) {
    const map = {
      //circle
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
    alignment(map[tick] ?? Alignment.center);
  }

  void start() {
    positionCaptured.clear();
    //
    isStart(true);
    //
    startTimer();
    //
    level1Movement();
  }

  void stop() {
    _debounce!.cancel();
    _timer!.cancel();
    // seconds = maxSenconds;
    counter(0);
    isStart(false);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
      } else {
        stop();
        showResultDialog(isWin: false);
      }
    });
  }

  void showResultDialog({bool isWin = false}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        insetPadding: const EdgeInsets.all(8),
        child: ResultView(
          isWin: isWin,
          player: player,
        ),
      ),
    );
  }

  // LEVEL METHODS

  void level1Movement() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer.periodic(
      const Duration(milliseconds: 1900),
      (timer) {
        if (isCompleted.value == true) {
          counter--;
        } else {
          counter++;
        }
        if (counter >= 8) {
          isCompleted(true);
        }
        if (counter <= 0) {
          isCompleted(false);
        }
        // print(counter);
        movment(counter.value);
      },
    );
  }

  void level2Movement() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        //random counter
        counter(Random().nextInt(8));
        // print(counter);
        movment(counter.value);
      },
    );
  }
}
