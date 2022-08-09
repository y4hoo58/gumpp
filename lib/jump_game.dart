// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:gumpp/app_params.dart';
import 'package:gumpp/helpers/shared_preferences_helper.dart';
import 'package:gumpp/game/unvisible/game_engine.dart';
import 'package:gumpp/helpers/hand_detection/hand_detection.dart';
import 'package:gumpp/design_params.dart';
import 'package:gumpp/game/visible/alerts_render.dart';
import 'package:gumpp/widgets/int_ad_widget.dart';

class JumpGame extends FlameGame with TapDetector {
  GameEngine gameEngine;
  HandDetection handDetection;
  IntAdWidg intAd;
  AlertsRender alertsRender;
  double initialWait = 2;

  Function onLose = () {};

  bool _isAdShowing = false;
  JumpGame() {
    initGame();
  }

  /*
    Oyun için gerekli classları başlatır.
    Eğer kamera izinleri alındıysa handDetection mekanizmasını direkt başlatır.
    Eğer izinler alınmadıysa kamera izinlerini sorar, izin verilirse handDetection
    mekanizmasını başlatır. Eğer izin almaz ise başlatmaz.
  */
  void initGame() async {
    await Future.delayed(const Duration(milliseconds: 300));
    handDetection = HandDetection();

    var status = await Permission.camera.status;
    if (status.isGranted || status.isLimited || status.isRestricted) {
      await handDetection.initialization();
    } else {
      var askedStatus = await Permission.camera.request();
      if (askedStatus.isGranted ||
          askedStatus.isLimited ||
          askedStatus.isRestricted) {
        await handDetection.initialization();
      }
    }

    await Future.delayed(const Duration(milliseconds: 100));

    gameEngine = GameEngine();
    AppParams.gameState = -1;
    intAd = IntAdWidg();
    alertsRender = AlertsRender();
  }

  @override
  void update(double t) {
    switch (AppParams.gameState) {
      case -4:
        /* 
        Hiç bir şey yapma, finishGame çalıştırıldı ve menüye dönülüyor.
        */
        break;
      case -3:
        /*
        finishGame çalıştırıldıktan sonra gamestate'in -4 olarak değiştirilmemesi
        update fonksiyonunun her devamlı olarak loop atması ve finishGame'i defalarca çağırmaya çalışmasıdır.
        finishGame tek bir sefer çalıştırılması gerekiyor.
        */
        finishGame();
        AppParams.gameState = -4;
        break;
      case -2:
        /* 
          Retry tuşuna basıldı.
          Gerekli tüm parametereleri sıfırlayıp oyunu tekrardan başlat.
          Prediction loop tekrar çalıştır.
          Imagestream zaten durdurulmayacağı için tekrardan çalıştırılmayacak.
        */
        resetGame();
        AppParams.gameState = 0;
        break;
      case -1:
        /* 
          Oyun bekleme ekranında hiç bir şey yapmaya gerek yok.
          todo : Score'u sıfırlamaya gerek olmayabilir. Silinmeli mi daha sonra kontrol et. 
          Şimdilik zararı yok burada.
        */
        AppParams.totalScore = 0;
        break;
      case 0:
        AppParams.gameState = playGame(t);
        break;
      case 1:
        /* 
          Karakter öldü. 
          Eğer reklam hazırsa reklamı göster.
          alersRender instance'ı sil. Yoksa retry ekranında da 
          alertleri göstermeye devam eder.
        */
        if (intAd.interstitialAd != null && _isAdShowing == false) {
          intAd.interstitialAd.show();
          _isAdShowing = true;
        }

        alertsRender = null;
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }

  int playGame(double t) {
    if (initialWait > 0) {
      initialWait = initialWait - t;
      return AppParams.gameState;
    } else {
      if (AppParams.isTutorial == true || AppParams.isTraining == true) {
        alertsRender.renderAlert(
          handDetection.x_hand,
          handDetection.y_hand,
          handDetection.max_area,
        );
      }

      bool isCharDied = gameEngine.update(
        t,
        handDetection.x_hand,
        handDetection.y_hand,
      );

      if (AppParams.totalScore > AppParams.bestScore) {
        if (AppParams.isTutorial == false && AppParams.isTraining == false) {
          AppParams.bestScore = AppParams.totalScore;
        }
      }

      if (isCharDied) {
        if (!intAd.isInterstitialAdReady) {
          intAd.loadInterstitialAd();
          _isAdShowing = false;
        }
        //Karakter her öldüğünde bestscore u kaydeder.
        //Total score la bestscore karşılaştırıp yapmama sebebi,
        //total score un zaten bestscore a eşit olması.
        //TODO:bool lu bir şey ayarla. Her defasında kaydetmesin.
        setBestScore();

        return 1;
      } else {
        return AppParams.gameState;
      }
    }
  }

  void setBestScore() async {
    if (AppParams.isTutorial == false && AppParams.isTraining == false) {
      SharedPreferencesHelper.setBestScore(AppParams.bestScore);
    }
  }

  void resetGame() {
    gameEngine = GameEngine();
    alertsRender = AlertsRender();
    initialWait = 1;
  }

  void finishGame() async {
    gameEngine = null;
    handDetection.disposeDetectionLoop();
    handDetection = null;
    await Future.delayed(const Duration(milliseconds: 100));

    onLose();
  }

  @override
  void render(Canvas canvas) {
    if (gameEngine != null) {
      gameEngine.render(canvas);
      if (AppParams.gameState == 0) {
        alertsRender.render(canvas);
      }
    }
  }

  @override
  bool onTapDown(TapDownInfo tapDown) {
    switch (AppParams.gameState) {
      case 0:

      case 1:
        final int _gameState = changeRetryColor(tapDown);
        if (_gameState == -2) {
          DesignParams.setRetryButCol(true);
        } else if (_gameState == -3) {
          DesignParams.setMenuButCol(true);
        }
        break;
      case 3:
        final int _gameState = changePauseColor(tapDown);
        if (_gameState == -2) {
          DesignParams.setRetryButCol(true);
        } else if (_gameState == -3) {
          DesignParams.setMenuButCol(true);
        }
        break;
    }
    return true;
  }

  @override
  bool onTapCancel() {
    DesignParams.setRetryButCol(false);
    DesignParams.setMenuButCol(false);
  }

  @override
  bool onTapUp(TapUpInfo tapUp) {
    switch (AppParams.gameState) {
      case -1:
        AppParams.gameState = 0;
        break;
      case 0:
        final _isPressed = isPausePressed(tapUp);
        if (_isPressed) {
          AppParams.gameState = 3;
        }
        break;
      case 1:
        final int _gameState = compRetryButtons(tapUp);

        DesignParams.setRetryButCol(false);
        DesignParams.setMenuButCol(false);

        AppParams.gameState = _gameState;

        if (_gameState == -2) {
          AppParams.totalScore = 0;
        }

        break;

      case 3:
        final int _gameState = compPauseButtons(tapUp);
        DesignParams.setRetryButCol(false);
        DesignParams.setMenuButCol(false);
        AppParams.gameState = _gameState;
        if (_gameState == -2) {
          AppParams.totalScore = 0;
        }
        break;
    }
    return true;
  }

  bool isPausePressed(final TapUpInfo tapUp) {
    final double xTap = tapUp.eventPosition.global.x;
    final double yTap = tapUp.eventPosition.global.y;

    final double _height = AppParams.gameSize[1] * 0.05;

    final double _width = _height * 0.5;

    double _renderY;
    if (AppParams.gameSize[1] * 0.1 > 50) {
      _renderY = AppParams.gameSize[1] * 0.1;
    } else {
      _renderY = AppParams.gameSize[1] * 0.15;
    }

    final double _pauseLeft = AppParams.gameSize[0] * 0.1;
    final double _pauseRight = AppParams.gameSize[0] * 0.1 + _width;
    final double _pauseTop = _renderY;
    final double _pauseBot = _renderY + _height;

    if (yTap >= _pauseTop && yTap <= _pauseBot) {
      if (xTap >= _pauseLeft && xTap <= _pauseRight) {
        return true;
      }
    }
    return false;
  }

  int compRetryButtons(TapUpInfo tapUp) {
    final double xTap = tapUp.eventPosition.global.x;
    final double yTap = tapUp.eventPosition.global.y;

    final double _butHeight = AppParams.gameSize[1] * 0.1;
    final double _butWidth = _butHeight * 2;

    final double _retryLeft = AppParams.gameSize[0] * 0.5 - _butWidth * 0.5;
    final double _retryRight = AppParams.gameSize[0] * 0.5 + _butWidth * 0.5;
    final double _retryTop = AppParams.gameSize[1] * 0.65 - _butHeight * 0.5;
    final double _retryBot = AppParams.gameSize[1] * 0.65 + _butHeight * 0.5;

    if (yTap >= _retryTop && yTap <= _retryBot) {
      if (xTap >= _retryLeft && xTap <= _retryRight) {
        return -2;
      } else {
        return AppParams.gameState;
      }
    }

    final double _menuLeft = AppParams.gameSize[0] * 0.5 - _butWidth * 0.5;
    final double _menuRight = AppParams.gameSize[0] * 0.5 + _butWidth * 0.5;
    final double _menuTop = AppParams.gameSize[1] * 0.8 - _butHeight * 0.5;
    final double _menuBot = AppParams.gameSize[1] * 0.8 + _butHeight * 0.5;

    if (yTap >= _menuTop && yTap <= _menuBot) {
      if (xTap >= _menuLeft && xTap <= _menuRight) {
        return -3;
      } else {
        return AppParams.gameState;
      }
    }

    return AppParams.gameState;
  }

  int compPauseButtons(TapUpInfo tapUp) {
    final double xTap = tapUp.eventPosition.global.x;
    final double yTap = tapUp.eventPosition.global.y;

    final double _butHeight = AppParams.gameSize[1] * 0.1;
    final double _butWidth = _butHeight * 2;

    final double _retryLeft = AppParams.gameSize[0] * 0.5 - _butWidth * 0.5;
    final double _retryRight = AppParams.gameSize[0] * 0.5 + _butWidth * 0.5;
    final double _retryTop = AppParams.gameSize[1] * 0.65 - _butHeight * 0.5;
    final double _retryBot = AppParams.gameSize[1] * 0.65 + _butHeight * 0.5;

    if (yTap >= _retryTop && yTap <= _retryBot) {
      if (xTap >= _retryLeft && xTap <= _retryRight) {
        return -2;
      } else {
        return AppParams.gameState;
      }
    }

    final double _menuLeft = AppParams.gameSize[0] * 0.5 - _butWidth * 0.5;
    final double _menuRight = AppParams.gameSize[0] * 0.5 + _butWidth * 0.5;
    final double _menuTop = AppParams.gameSize[1] * 0.8 - _butHeight * 0.5;
    final double _menuBot = AppParams.gameSize[1] * 0.8 + _butHeight * 0.5;

    if (yTap >= _menuTop && yTap <= _menuBot) {
      if (xTap >= _menuLeft && xTap <= _menuRight) {
        return -3;
      } else {
        return AppParams.gameState;
      }
    }

    return 0;
  }

  int changeRetryColor(TapDownInfo tapDown) {
    final double xTap = tapDown.eventPosition.global.x;
    final double yTap = tapDown.eventPosition.global.y;

    final double _butHeight = AppParams.gameSize[1] * 0.1;
    final double _butWidth = _butHeight * 2;

    final double _retryLeft = AppParams.gameSize[0] * 0.5 - _butWidth * 0.5;
    final double _retryRight = AppParams.gameSize[0] * 0.5 + _butWidth * 0.5;
    final double _retryTop = AppParams.gameSize[1] * 0.65 - _butHeight * 0.5;
    final double _retryBot = AppParams.gameSize[1] * 0.65 + _butHeight * 0.5;

    if (yTap >= _retryTop && yTap <= _retryBot) {
      if (xTap >= _retryLeft && xTap <= _retryRight) {
        return -2;
      } else {
        return AppParams.gameState;
      }
    }

    final double _menuLeft = AppParams.gameSize[0] * 0.5 - _butWidth * 0.5;
    final double _menuRight = AppParams.gameSize[0] * 0.5 + _butWidth * 0.5;
    final double _menuTop = AppParams.gameSize[1] * 0.8 - _butHeight * 0.5;
    final double _menuBot = AppParams.gameSize[1] * 0.8 + _butHeight * 0.5;

    if (yTap >= _menuTop && yTap <= _menuBot) {
      if (xTap >= _menuLeft && xTap <= _menuRight) {
        return -3;
      } else {
        return AppParams.gameState;
      }
    }

    return AppParams.gameState;
  }

  int changePauseColor(TapDownInfo tapDown) {
    final double xTap = tapDown.eventPosition.global.x;
    final double yTap = tapDown.eventPosition.global.y;

    final double _butHeight = AppParams.gameSize[1] * 0.1;
    final double _butWidth = _butHeight * 2;

    final double _retryLeft = AppParams.gameSize[0] * 0.5 - _butWidth * 0.5;
    final double _retryRight = AppParams.gameSize[0] * 0.5 + _butWidth * 0.5;
    final double _retryTop = AppParams.gameSize[1] * 0.65 - _butHeight * 0.5;
    final double _retryBot = AppParams.gameSize[1] * 0.65 + _butHeight * 0.5;

    if (yTap >= _retryTop && yTap <= _retryBot) {
      if (xTap >= _retryLeft && xTap <= _retryRight) {
        return -2;
      } else {
        return AppParams.gameState;
      }
    }

    final double _menuLeft = AppParams.gameSize[0] * 0.5 - _butWidth * 0.5;
    final double _menuRight = AppParams.gameSize[0] * 0.5 + _butWidth * 0.5;
    final double _menuTop = AppParams.gameSize[1] * 0.8 - _butHeight * 0.5;
    final double _menuBot = AppParams.gameSize[1] * 0.8 + _butHeight * 0.5;

    if (yTap >= _menuTop && yTap <= _menuBot) {
      if (xTap >= _menuLeft && xTap <= _menuRight) {
        return -3;
      } else {
        return AppParams.gameState;
      }
    }
    return AppParams.gameState;
  }
}
