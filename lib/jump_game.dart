// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flame/gestures.dart';
import 'package:flame/game.dart';

import 'package:is_first_run/is_first_run.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:gumpp/helpers/shared_preferences_helper.dart';
import 'package:gumpp/helpers/game_engine.dart';
import 'package:gumpp/helpers/hand_detection.dart';
import 'package:gumpp/tutorial_page.dart';

class JumpGame extends BaseGame with TapDetector {
  Size screenSize;

  GameEngine gameEngine;

  HandDetection handDetection;

  TutorialPage tutorialPage;

  Function onLose = () {};

  JumpGame() {}

  String condition = "full initialization";
  String orientation;

  bool is_tutorial;
  double initial_wait = 2;

  int bestScore = 0;

  int renderScore;

  Interpreter interpreter;

  @override
  void resize(Size size) {
    screenSize = size;
    init_game();
    //Ekran boyutu değişirse gamerender'a da haber uçur
    //if (gameEngine != null) {
    //  gameEngine.resize(screenSize);
    //}
    super.resize(size);
  }

  //Her resize'da çağrılır..
  void init_game() async {
    //show_tutorial();

    //Eğer is_tutorial "null" ise uygulamanın ilk kez kullanılıp kullanılmadığına bakıyor.
    //Ancak eğer is_tutorial "true" ise, zaten bir el oyun oynanmış demektir bu yüzden
    //is_tutorial "true"'dur. Bu yüzden retry tuşuna basıldığı zaman tutorial ekranının
    //kaldırılması gerekir.
    if (is_tutorial == null) {
      is_tutorial = await IsFirstRun.isFirstRun();
    } else if (is_tutorial == true) {
      is_tutorial = false;
    }
    //TODO: Bir alt satırı sil
    is_tutorial = true;
    if (is_tutorial == true) {
      tutorialPage = TutorialPage(screenSize);
    }

    if (condition == "full initialization") {
      await Future.delayed(Duration(milliseconds: 500));
      //GameEngine'i başlat ve tutorial ekranı olup olmadığına dair bilgilendir.
      gameEngine = GameEngine(screenSize, orientation, tutorialPage);
      gameEngine.is_tutorial = is_tutorial;

      //HandDetection'ı başlat ve interpreter'ı yolla.
      handDetection = HandDetection(orientation);
      handDetection.interpreter = interpreter;
      handDetection.initialization();

      //Tap screen'den sonra her şeyin iyice başladığından emin olmak için
      //2 saniye gibi bir süre beklenmesi gerekiyor.
      initial_wait = 2;

      //Not: Burada condition'ı "playing" olarak değiştirmiyoruz çünkü
      //bu ekranda kullanıcıdan tap yapması bekleniyor.
      condition = "initialized";
    } else if (condition == "lite initialization") {
      //GameEngine'i başlat ve tutorial ekranı olup olmadığına dair bilgilendir.
      gameEngine = GameEngine(screenSize, orientation, tutorialPage);
      gameEngine.is_tutorial = is_tutorial;

      //Kamera stop'da olduğu ve daha önce handDetection başlatıldığı için
      //stream başlatmak yeterli.
      handDetection.start_stream();

      //Burada hard work yapılmadığı için 1 saniyelik bekleme süresi yeterli.
      initial_wait = 1;

      //Oyun durumu "restart game" den "playing" e dönüştü.
      //Çünkü kullanıcı retry tuşuna bastı.
      condition = "playing";
    }
    //TODO: burada çok alakasız durdu sanki?

    gameEngine.resize(screenSize);
  }

  @override
  bool onTapUp(TapUpDetails tapUpDetails) {
    if (condition == "initialized") {
      condition = "playing";
    } else if (condition == "game finished") {
      //TODO: buradaki aralığı tam retry text boyutlarına göre ayarla
      double tap_y = tapUpDetails.globalPosition.dy;
      if (tap_y > screenSize.height * 0.69 &&
          tap_y < screenSize.height * 0.79) {
        //Retry atılacağı için durumu restart game olarak değiştir.
        condition = "lite initialization";

        //Başlatma işlemini tekrardan yap.
        init_game();
      } else if (tap_y > screenSize.height * 0.84 &&
          tap_y < screenSize.height * 0.95) {
        delete_game();
      }
    }
    return true;
  }

  @override
  void update(double t) {
    if (condition == "playing" &&
        interpreter != null &&
        handDetection.is_camera_working == true) {
      if (initial_wait <= 0) {
        if (is_tutorial == true) {
          tutorialPage.t = t;
        }

        if (renderScore == null) {
          renderScore = bestScore;
        }
        final gameList = gameEngine.update(
            t,
            handDetection.x_hand,
            handDetection.y_hand,
            handDetection.prediction_box_area,
            renderScore);

        if (gameList[1].round() > renderScore) {
          renderScore = gameList[1].round();
        }
        if (gameList[0] == true) {
          condition = "game finished";
          handDetection.stop_stream();

          if (bestScore < renderScore) {
            bestScore = renderScore;
            set_bestScore(bestScore);
          }
        }
      } else {
        initial_wait = initial_wait - t;
      }
    }
  }

  void set_bestScore(int best_score) async {
    SharedPreferencesHelper.setBestScore(best_score);
  }

  void delete_game() async {
    await Future.delayed(
      const Duration(milliseconds: 25),
    );

    handDetection.dispose_camera();

    handDetection = null;
    await Future.delayed(
      const Duration(milliseconds: 100),
    );

    gameEngine = null;
    onLose();
  }

  @override
  void render(Canvas canvas) {
    if (gameEngine != null) {
      gameEngine.render(canvas, condition);
    }
    if (is_tutorial == true) {
      tutorialPage.render_tutorial_page(canvas);
    }
  }
}
