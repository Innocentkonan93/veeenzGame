import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final isSoundEnabled = true.obs;

  @override
  void onInit() {
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
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
}
