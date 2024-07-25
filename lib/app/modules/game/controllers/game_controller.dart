import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeenz/app/modules/game/views/game_result_view.dart';
import 'package:veeenz/models/player.dart';
import 'package:veeenz/services/ai_ajuster.dart';
import 'package:veeenz/utils/constants.dart';

class GameController extends GetxController {
  Rxn<Player> currentPlayer = Rxn<Player>();
  AIDifficultyAdjuster difficultyAdjuster = AIDifficultyAdjuster();
  late AssetsAudioPlayer _assetsAudioPlayer;
  late ConfettiController controllerCenter;
  static const maxSeconds = 35;

  Rxn<int> oldCounter = Rxn<int>(maxSeconds);
  RxMap<String, dynamic> currentDecoration = <String, dynamic>{}.obs;
  Timer? _debounce;
  Timer? _timer;
  RxList<Widget> widgets = <Widget>[].obs;
  Rx<AlignmentGeometry> alignment = Alignment.center.obs;
  RxList<AlignmentGeometry> positionCaptured = <AlignmentGeometry>[].obs;
  GetStorage storage = GetStorage();

  final counter = 0.obs;
  var seconds = maxSeconds.obs;
  final level = 1.obs;
  final target = 8.obs;
  final isCompleted = false.obs;
  final isStart = false.obs;
  final isSoundEnabled = true.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    getPlayerData();
    getSoundSettings();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    controllerCenter = ConfettiController();
    super.onInit();
  }

  void clearData() {
    widgets.clear();
    alignment(Alignment.center);
    positionCaptured.clear();
    seconds = maxSeconds.obs;
    getPlayerData();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    widgets.clear();
    super.onClose();
  }

  void getSoundSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isSoundEnabled(pref.getBool('sound_enabled') ?? true);
  }

  // Movement Methods
  void allMovement(int tick) {
    final newAlignment = movementMap[tick];
    if (newAlignment != null) {
      alignment(newAlignment);
    } else {
      if (kDebugMode) {
        print('Invalid tick value: $tick');
      }
    }
  }

  void accuracyMovement(int level) {
    // int duration = getMovementDurationFromLevel(level);
    int duration = difficultyAdjuster.getAdjustedMovementDuration(level);
    _debounce?.cancel();
    _debounce = Timer.periodic(Duration(milliseconds: duration), (timer) {
      counter(isCompleted.value ? counter.value - 1 : counter.value + 1);
      if (counter >= 8) {
        isCompleted(true);
      }
      if (counter <= 0) {
        isCompleted(false);
      }
      allMovement(counter.value);
    });
  }

  void randomMovement(int level) {
    // int duration = getMovementDurationFromLevel(level);
    int duration = difficultyAdjuster.getAdjustedMovementDuration(level);
    _debounce?.cancel();
    _debounce = Timer.periodic(Duration(milliseconds: duration), (timer) {
      counter(Random().nextInt(20));
      allMovement(counter.value);
    });
  }

  // Helper Methods

  Future<void> getPlayerData() async {
    if (kDebugMode) {
      print("geting player data ...");
    }
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 1));
      SharedPreferences pref = await SharedPreferences.getInstance();
      level(pref.getInt("level") ?? 1);
      getLevelTarget(level.value);
      getTimerBasedOnLevel(level.value);
      getGameDecoration();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print(e);
    }
  }

  void getLevelTarget(int level) {
    if (level > 15) {
      target(4);
    }
  }

  void getTimerBasedOnLevel(int level) {
    if (level > 10) {
      seconds(25);
    }
  }

  void getGameDecoration() {
    final bg = getDecorationForLevel(level.value);
    currentDecoration(bg);
  }

  Map<String, dynamic> getDecorationForLevel(int level) {
    Map<String, dynamic>? decoration;

    for (var bg in allGameBackgrounds) {
      if (bg['level'] <= level) {
        decoration = bg;
      } else {
        break;
      }
    }

    return decoration ?? allGameBackgrounds.first;
  }

  // Game Control Methods
  void start() {
    playStartAudio();
    vibrate();
    isStart(true);
    startTimer();
    level <= 10 ? accuracyMovement(level.value) : randomMovement(level.value);
  }

  void stop() {
    _debounce?.cancel();
    _timer?.cancel();

    alignment(Alignment.center);
    isStart(false);
  }

  // Timer Method
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds.value--;
      } else {
        stop();
        showResultDialog(isWin: false);
      }
    });
  }

  // UI Methods
  Future<void> playStartAudio() async {
    Audio audio = Audio("assets/audios/click.mp3");
    if (isSoundEnabled.value) {
      AssetsAudioPlayer.playAndForget(audio);
    }
  }

  Future<void> playAudio() async {
    Audio audio = Audio("assets/audios/catchit.mp3");
    if (isSoundEnabled.value) {
      AssetsAudioPlayer.playAndForget(audio);
    }
  }

  Future playResultAudio(bool isWin) async {
    Audio winAudio = Audio("assets/audios/winning.mp3");
    Audio loseAudio = Audio("assets/audios/losing.mp3");
    if (isWin) {
      controllerCenter.play();
      Future.delayed(const Duration(seconds: 3), () {
        controllerCenter.stop();
      });
      if (isSoundEnabled.value) {
        AssetsAudioPlayer.playAndForget(winAudio);
      }
    } else {
      if (isSoundEnabled.value) {
        AssetsAudioPlayer.playAndForget(loseAudio);
      }
    }
  }

  void showResultDialog({bool isWin = false}) {
    String levelDescription = getLevelDescription(level.value);

    showGeneralDialog<bool>(
      barrierColor: Colors.black.withOpacity(0.75),
      transitionBuilder: (context, a1, a2, widget) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                insetPadding: const EdgeInsets.all(8),
                child: GameResultView(
                  isWin: isWin,
                  player: currentPlayer.value!.copyWith(position: level.value),
                  levelDescription: levelDescription,
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(
        milliseconds: 100,
      ),
      barrierDismissible: false,
      barrierLabel: '',
      context: Get.context!,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }

  void catchRunner() async {
    if (!positionCaptured.contains(alignment.value)) {
      positionCaptured.addIf(
        !positionCaptured.contains(alignment.value),
        alignment.value,
      );
      playAudio();
      // Mise à jour des performances avec succès
      difficultyAdjuster.updatePerformance(true);

      if (positionCaptured.length == target.value) {
        level.value++;
        stop();
        updatePlayer();
        showResultDialog(isWin: true);
        positionCaptured.clear();
      }
    } else {
      // Mise à jour des performances avec échec
      difficultyAdjuster.updatePerformance(false);
    }
  }

  void updatePlayer() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Player player = currentPlayer.value!.copyWith(position: level.value);
    pref.setInt("level", player.position);
  }

  void vibrate() async {
    // Check if the device can vibrate
    bool canVibrate = await Vibrate.canVibrate;
    var type = FeedbackType.success;
    if (canVibrate) {
      Vibrate.feedback(type);
    } else {
      return;
    }
  }
}
