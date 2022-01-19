// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:gumpp/app_params.dart';
import 'package:gumpp/helpers/shared_preferences_helper.dart';
import 'package:gumpp/game/unvisible/game_engine.dart';
import 'package:gumpp/helpers/hand_detection/hand_detection.dart';
import 'package:gumpp/design_params.dart';

class JumpGame extends FlameGame with TapDetector {
  GameEngine gameEngine;
  HandDetection handDetection;

  double initialWait = 2;

  Function onLose = () {};

  JumpGame() {
    initGame();
  }

  void initGame() async {
    await Future.delayed(const Duration(milliseconds: 50));
    handDetection = HandDetection();
    await Future.delayed(const Duration(milliseconds: 250));
    await handDetection.initialization();
    await Future.delayed(const Duration(milliseconds: 250));
    gameEngine = GameEngine();
    AppParams.gameState = -1;
  }

  @override
  void update(double t) {
    switch (AppParams.gameState) {
      case -3:
        finishGame();
        AppParams.gameState = -4;
        break;
      case -2:
        handDetection.startLoop();
        resetGame();
        AppParams.gameState = 0;
        break;
      case -1:
        break;
      case 0:
        AppParams.gameState = playGame(t);
        break;
      case 1:
        handDetection.stopLoop();
        break;
      case 2:
        break;
    }
  }

  int playGame(double t) {
    if (initialWait > 0) {
      initialWait = initialWait - t;
      return AppParams.gameState;
    } else {
      bool isCharDied = gameEngine.update(
        t,
        handDetection.x_hand,
        handDetection.y_hand,
      );
      if (AppParams.totalScore > AppParams.bestScore) {
        AppParams.bestScore = AppParams.totalScore;
      }

      if (isCharDied) {
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
    SharedPreferencesHelper.setBestScore(AppParams.bestScore);
  }

  void resetGame() {
    handDetection.startLoop();
    gameEngine = GameEngine();
    initialWait = 1;
  }

  void finishGame() async {
    gameEngine = null;
    //TODO: Dispose yapmak mı yoksa doğrudan null yapmak mı daha iyi? Direkt null
    //yapınca crash yaşanıyor mu kamerada?
    //handDetection = null;
    handDetection.disposeDetectionLoop();
    await Future.delayed(const Duration(milliseconds: 100));

    onLose();
  }

  @override
  void render(Canvas canvas) {
    if (gameEngine != null) {
      gameEngine.render(canvas);
    }
  }

  @override
  bool onTapDown(TapDownInfo tapDown) {
    switch (AppParams.gameState) {
      case 1:
        final int _gameState = changeColor(tapDown);
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
      case 1:
        final int _gameState = compButtons(tapUp);

        DesignParams.setRetryButCol(false);
        DesignParams.setMenuButCol(false);
        AppParams.gameState = _gameState;
        AppParams.totalScore = 50000;
        break;
    }
    return true;
  }

  int compButtons(TapUpInfo tapUp) {
    final double xTap = tapUp.eventPosition.global.x;
    final double yTap = tapUp.eventPosition.global.y;

    //Eğer "retry" butonuna basılırsa gamestate'i oyuna retry atılacak şekilde güncelle.
    //TODO : x sınır koşullarını da ekle
    if (yTap > AppParams.gameSize[1] * 0.69 &&
        yTap < AppParams.gameSize[1] * 0.765) {
      if (xTap > AppParams.gameSize[0] * 0.25 &&
          xTap < AppParams.gameSize[0] * 0.75) {
        return -2;
      } else {
        return AppParams.gameState;
      }
    }
    //Eğer "menu" butonuna basılırsa gamestate'i oyunu sıfırlayacak şekilde güncelle.
    //TODO : x sınır koşullarını da ekle
    if (yTap > AppParams.gameSize[1] * 0.84 &&
        yTap < AppParams.gameSize[1] * 0.915) {
      if (xTap > AppParams.gameSize[0] * 0.25 &&
          xTap < AppParams.gameSize[0] * 0.75) {
        return -3;
      } else {
        return AppParams.gameState;
      }
    }

    return AppParams.gameState;
  }

  int changeColor(TapDownInfo tapDown) {
    final double xTap = tapDown.eventPosition.global.x;
    final double yTap = tapDown.eventPosition.global.y;

    //Eğer "retry" butonuna basılırsa gamestate'i oyuna retry atılacak şekilde güncelle.
    //TODO : x sınır koşullarını da ekle
    if (yTap > AppParams.gameSize[1] * 0.69 &&
        yTap < AppParams.gameSize[1] * 0.765) {
      if (xTap > AppParams.gameSize[0] * 0.25 &&
          xTap < AppParams.gameSize[0] * 0.75) {
        return -2;
      }
    }
    //Eğer "menu" butonuna basılırsa gamestate'i oyunu sıfırlayacak şekilde güncelle.
    //TODO : x sınır koşullarını da ekle
    if (yTap > AppParams.gameSize[1] * 0.84 &&
        yTap < AppParams.gameSize[1] * 0.915) {
      if (xTap > AppParams.gameSize[0] * 0.25 &&
          xTap < AppParams.gameSize[0] * 0.75) {
        return -3;
      }
    }

    return AppParams.gameState;
  }
}
