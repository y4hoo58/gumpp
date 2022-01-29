import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  /*
    Kaydı tutulan parametrelerin isimleri.
  */
  static final String _bestScore = "bestScore";
  static final String _voicePref = "voicePref";
  static final String _flashMode = "flashMode";

  /*
    Eğer daha önceden bestScore kaydedildiyse o değeri döner.
    Eğer bestScore daha önceden hiç kaydedilmediyse default olarak sıfır döner.
    Herhangi bir exception durumunda default değeri dön.
    Bu method asla null dönmemeli.
  */
  static Future<int> getBestScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int _defaultValue = 0;
    try {
      final String _bestScoreString = prefs.getString(_bestScore);

      if (_bestScoreString != null) {
        return int.parse(prefs.getString(_bestScore));
      } else {
        return _defaultValue;
      }
    } on Exception {
      return _defaultValue;
    }
  }

  /*
    Eğer parametre olarak aldığı score değeri null değilse kaydeder.
    Eğer nullsa default değer kaydetmez.
    Bu method asla null kaydetmemeli.
   */
  static Future<bool> setBestScore(final int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (score != null) {
        return prefs.setString(_bestScore, score.toString());
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  /*
    Default voicePref değeri true'dur.
    voicePref değerini döner.
  */
  static Future<bool> getVoicePref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool _defaultVoicePref = true;
    try {
      final bool voicePref = await prefs.getBool(_voicePref);
      if (voicePref != null) {
        return voicePref;
      } else {
        return _defaultVoicePref;
      }
    } on Exception {
      return _defaultVoicePref;
    }
  }

  /*
    Bu method asla null kaydetmez.
   */
  static Future<bool> setVoicePref(final bool voicePref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (voicePref != null) {
        return prefs.setBool(_voicePref, voicePref);
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  static Future<int> getFlashMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int _defaultFlashMode = 1;
    try {
      final int flashMode = await prefs.getInt(_flashMode);
      if (flashMode != null) {
        return flashMode;
      } else {
        return _defaultFlashMode;
      }
    } on Exception {
      return _defaultFlashMode;
    }
  }

  static Future<bool> setFlashMode(final int flashMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (flashMode != null) {
        return prefs.setInt(_flashMode, flashMode);
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }
}
