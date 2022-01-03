import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  /// Instantiation of the SharedPreferences library
  static final String _bestScore = "bestScore";

  //Method that returns the best score of user.
  static Future<int> getBestScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      int returnScore = int.parse(prefs.getString("bestScore"));
      return returnScore;
    } on Exception {
      return 0;
    }
  }

  //Method that saves the best score of user.
  static Future<bool> setBestScore(int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_bestScore, score.toString());
  }
}
