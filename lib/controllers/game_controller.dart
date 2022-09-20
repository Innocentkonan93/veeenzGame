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

  Player player = const Player(id: "1", name: "Josco", position: 1);

  void updatePosition(int tick) {
    switch (tick) {
      case 0:
        alignment(Alignment.topCenter);
        break;
      case 1:
        alignment(Alignment.topRight);
        break;
      case 2:
        alignment(Alignment.centerRight);
        break;
      case 3:
        alignment(Alignment.bottomRight);
        break;
      case 4:
        alignment(Alignment.bottomCenter);
        break;
      case 5:
        alignment(Alignment.bottomLeft);
        break;
      case 6:
        alignment(Alignment.centerLeft);
        break;
      case 7:
        alignment(Alignment.topLeft);

        break;
      case 8:
        alignment(Alignment.topCenter);
        break;
      default:
        _debounce?.cancel();
    }
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
        updatePosition(counter.value);
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
        updatePosition(counter.value);
      },
    );
  }
}
