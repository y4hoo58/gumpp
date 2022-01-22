import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  /// Instantiation of the SharedPreferences library
  static final String _bestScore = "bestScore";
  static final String _voicePref = "voicePref";
  static final String _flashMode = "flashMode";

  //Method that returns the best score of user.
  static Future<int> getBestScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return int.parse(prefs.getString(_bestScore));
    } on Exception {
      return 0;
    }
  }

  //Method that saves the best score of user.
  static Future<bool> setBestScore(final int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.setString(_bestScore, score.toString());
    } on Exception {
      //TODO:...
    }
  }

  static Future<bool> setVoicePref(final bool voicePref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.setBool(_voicePref, voicePref);
    } on Exception {
      //TODO:...
    }
  }

  static Future<bool> getVoicePref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final bool voicePref = prefs.getBool(_voicePref);
      if (voicePref != null) {
        return voicePref;
      } else {
        return true;
      }
    } on Exception {
      return true;
    }
  }

  static Future<bool> setFlashMode(final int flashMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.setInt(_flashMode, flashMode);
    } on Exception {
      //TODO:...
    }
  }

  static Future<int> getFlashMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final int flashMode = prefs.getInt(_flashMode);
      if (flashMode != null) {
        return flashMode;
      } else {
        //TODO : Düzelt
        return 1;
      }
    } on Exception {
      //TODO : Düzelt
      return 1;
    }
  }
}
