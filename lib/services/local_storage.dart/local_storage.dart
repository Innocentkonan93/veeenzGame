import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  void updatePlayerLevel(int level) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("level", level);
  }

  Future<int> getPlayerLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("level") ?? 1;
  }

  void updatePlayerScore(int score) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("score", score);
  }

  void saveQuests(List<String> questsJSon) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setStringList('quests', questsJSon);
  }

  Future<List<String>?> getQuests() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('quests');
  }
}
