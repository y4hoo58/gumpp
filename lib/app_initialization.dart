import 'package:flame/flame.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:is_first_run/is_first_run.dart';

import 'package:gumpp/helpers/shared_preferences_helper.dart';

import 'package:gumpp/app_params.dart';

/* 
    Uygulama için gerekli şeylerin başlatılmasını gerçekleştirir.
    Tek seferli bir işlemdir.
  */

class AppInitialization {
  void initGame() async {
    //Uygulamayı tam ekran ve sadece portre olarak çalışacak şekilde başlat.
    await Flame.device.fullScreen();
    await Flame.device.setPortraitUpOnly();

    /*
      Model oyuna geçilince kullanılacağı için await kullanmaya gerek yok.
      Oyun başlayana kadar zaten yüklenmiş olur.
     */
    loadModel();

    /*
      Eğer uygulama ilk kez çalıştırılıyorsa shared preferences null. O yüzden 
      bazı işlemler farklı şekilde gerçekleştirilecek.
      await eklendi çünkü loadPreferences fonksiyonuna null bool değerlerinin geçmesini istemiyorum.
    */
    await checkIsFirstRun();

    /*
      Kullanıcı ayarlarını yükler.
     */
    loadPreferences();

    /*
      Reklam işleri..
     */
    _initGoogleMobileAds();
  }

  /*
    interpreter'ı asset klasöründen yükler ve adressini appParams'a yollar.
  */
  void loadModel() async {
    Interpreter _interpreter;
    var _interpreterOptions;

    try {
      _interpreterOptions = InterpreterOptions()..useNnApiForAndroid = true;
      _interpreter = await Interpreter.fromAsset('palm_detection.tflite',
          options: _interpreterOptions);
      _interpreter.allocateTensors();
    } on Exception {
      _interpreterOptions = InterpreterOptions()..useNnApiForAndroid = false;
      _interpreter = await Interpreter.fromAsset('palm_detection.tflite',
          options: _interpreterOptions);
      _interpreter.allocateTensors();
    }

    AppParams.interpreterAddress = _interpreter.address;
  }

  /* 
    Eğer uygulama ilk kez açıldıysa isTutorial değerini true yapar bu 
    sayede tutorial ekranı gösterilebilir.
   */
  Future<void> checkIsFirstRun() async {
    AppParams.isTutorial ??= await IsFirstRun.isFirstRun();
  }

  /*
    Tüm kullanıcı ayarlarını yükleme işlemi bu fonksiyon altında gerçekleşir.
    Hafızaya kaydedilen ayarlar SharedPreferences class'ında önlem alınarak
    asla null dönmemesi için ayarlandı. 
    Bu yüzden bu kısımda null check yapmaya gerek yoktur.
    Eğer parametreler null dönecek olursa otomatik olarak default değerler atanıyor.
   */
  void loadPreferences() async {
    loadBestScore();
    loadVoicePref();
    loadFlashMode();
  }

  void loadBestScore() async {
    final int _bestScore = await SharedPreferencesHelper.getBestScore();
    AppParams.bestScore = _bestScore;
  }

  void loadVoicePref() async {
    final bool _voicePref = await SharedPreferencesHelper.getVoicePref();
    AppParams.voicePref = _voicePref;
  }

  void loadFlashMode() async {
    /*
      bool kullanılmadı çünkü flashmode'da 3 adet seçenek var.
      " on-auto-off "
      todo : 32 bit integer yerine 8 bit integer vs. kullanılabilir.
     */
    final int _flashMode = await SharedPreferencesHelper.getFlashMode();
    AppParams.flashMode = _flashMode;
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }
}
