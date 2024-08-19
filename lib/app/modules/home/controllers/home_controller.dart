import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeenz/models/player.dart';

import 'package:veeenz/widgets/profile_dialog.dart';

class HomeController extends GetxController {
  late AssetsAudioPlayer _assetsAudioPlayer;
  Rxn<Player> currentPlayer = Rxn<Player>();
  final isSoundEnabled = true.obs;
  final nameController = TextEditingController();
  final level = 1.obs;

  void getPlayerLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    level(pref.getInt("level") ?? 1);
  }

  void setPlayerName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("name", nameController.text);
  }

  void getPlayerData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name = pref.getString("name") ?? "";
    currentPlayer(
      Player(
        name: name,
        position: level.value,
        id: '',
        powers: 2,
      ),
    );
  }

  @override
  void onInit() async {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    getPlayerLevel();
    getPlayerData();
    super.onInit();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  void getSoundSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isSoundEnabled(pref.getBool('sound_enabled') ?? true);
  }

  Future<void> playAudio() async {
    Audio audio = Audio("assets/audios/click.mp3");
    if (isSoundEnabled.value) {
      AssetsAudioPlayer.playAndForget(audio);
    }
  }

  void vibrate() async {
    // Check if the device can vibrate
    bool canVibrate = await Vibrate.canVibrate;
    var type = FeedbackType.impact;
    if (canVibrate) {
      Vibrate.feedback(type);
    } else {
      return;
    }
  }

  Future<bool?> showProfileDialog() async {
    return await showGeneralDialog<bool>(
      barrierColor: Colors.black.withOpacity(0.75),
      transitionBuilder: (context, a1, a2, widget) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.0).animate(a1),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: const Offset(0, 0),
              ).animate(a1),
              child: const ProfileDialog(),
            ),
          ),
        );
      },
      transitionDuration: const Duration(
        milliseconds: 100,
      ),
      barrierDismissible: true,
      barrierLabel: "",
      context: Get.context!,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }
}
