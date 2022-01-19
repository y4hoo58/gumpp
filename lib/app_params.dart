import 'package:gumpp/jump_game.dart';

class AppParams {
  // Tflite modelinin hafızada ki adresini tutar.
  // Uygulama açıldığı anda interpreter hafızaya yüklenir.
  // Daha sonra adresi buraya kaydedilir.
  // Sadece HandDetection classından bu adrese erişilir.
  static int interpreterAddress;

  // Dialogbox ekranında kullanıcının bastığı butona bağlı olarak belirlenir.
  // difficultyLevel -> 1,2 ve 3 değerlerini alabilir.
  static int difficultyLevel;

  // Uygulamanın hangi kamerayı kullandığını saklar.
  // Birçok class'ın bu parametreye erişimi var.
  static bool isFrontCam;

  //Ekran boyutunu tutar.
  //[width,height]
  static List<double> gameSize;

  //gameState:
  //-4  : Finishgame çalıştırıldı
  //-3  : Menuye dönüldü
  //-2  : Retry atıldı
  //-1  : Bekleme ekranında bekliyor
  // 0  : Oyun devam ediyor
  // 1  : Player Öldü
  // 2  : Kamera bekleniyor
  static int gameState = -999;

  //-1 : Reverse
  // 0 : No mode
  static int currentGameMode;

  static bool isPlayer1Selected;

  static int bestScore = 0;

  static int totalScore = 50000;

  static bool isTutorial = false;

  static bool isFlashOn = false;
}
