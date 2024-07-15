import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeenz/models/player.dart';

class SettingsController extends GetxController {
  Rxn<Player> currentPlayer = Rxn<Player>();

  final selectedLanguage = "fr".obs;

  final isDark = true.obs;
  final isSoundEnabled = true.obs;

  Future<void> getThemeModeSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isDark(pref.getBool('dark_mode') ?? true);
  }

  Future<void> setThemeModeSettings(bool dark) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('dark_mode', dark);
    isDark(dark);
  }

  Future<void> getSoundSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isSoundEnabled(pref.getBool('sound_enabled') ?? true);
  }

  Future<void> setSoundSettings(bool enabled) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('sound_enabled', enabled);
    isSoundEnabled(enabled);
    print(isSoundEnabled.value);
  }

  Future<void> setLanguage(String language) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('language', language);
    selectedLanguage(language);
  }

  Future<void> getLanguageSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    selectedLanguage(pref.getString('language') ?? 'fr');
  }

  @override
  void onInit() {
    getSoundSettings();
    Future.wait(
      [
        getSoundSettings(),
        getLanguageSettings(),
        getThemeModeSettings(),
      ],
    );
    super.onInit();
  }
}
