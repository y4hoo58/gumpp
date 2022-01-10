// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:is_first_run/is_first_run.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:gumpp/helpers/shared_preferences_helper.dart';
import 'package:gumpp/game/unvisible/game_engine.dart';
import 'package:gumpp/helpers/hand_detection/hand_detection.dart';
import 'package:gumpp/tutorial_page.dart';

import 'package:gumpp/app_params.dart';

class JumpGame extends FlameGame with TapDetector {
  GameEngine gameEngine;

  HandDetection handDetection;

  TutorialPage tutorialPage;

  Function onLose = () {};

  JumpGame() {
    initGame();
  }

  double initialWait = 2;

  int bestScore = 0;

  int renderScore;

  Interpreter interpreter;

  void initGame() async {
    await checkIfTutorial();

    gameEngine = GameEngine(tutorialPage);

    handDetection = HandDetection();
  }

  void checkIfTutorial() async {
    if (AppParams.isTutorial == null) {
      AppParams.isTutorial = await IsFirstRun.isFirstRun();
    }

    if (AppParams.isTutorial) {
      tutorialPage = TutorialPage();
    }
  }

  void resetGame() {
    handDetection.startLoop();
    //gameEngine.resetGameParams();

    initialWait = 1;
  }

  @override
  void update(double t) {
    switch (AppParams.gameState) {
      case -3:
        finishGame();
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

      if (isCharDied) {
        return 1;
      } else {
        return AppParams.gameState;
      }
    }
  }

  void setBestScore(int best_score) async {
    SharedPreferencesHelper.setBestScore(best_score);
  }

  void finishGame() async {
    await Future.delayed(
      const Duration(milliseconds: 25),
    );

    handDetection.disposeDetectionLoop();

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
      gameEngine.render(canvas);
    }
    if (AppParams.isTutorial == true) {
      tutorialPage.render_tutorial_page(canvas);
    }
  }

  @override
  bool onTapUp(TapUpInfo tapUp) {
    switch (AppParams.gameState) {
      case -1:
        AppParams.gameState = 0;
        break;
      case 1:
        AppParams.gameState = compButtons(tapUp);
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
        yTap < AppParams.gameSize[1] * 0.79) {
      return -2;
    }
    //Eğer "menu" butonuna basılırsa gamestate'i oyunu sıfırlayacak şekilde güncelle.
    //TODO : x sınır koşullarını da ekle
    if (yTap > AppParams.gameSize[1] * 0.84 &&
        yTap < AppParams.gameSize[1] * 0.95) {
      return -3;
    }

    return AppParams.gameState;
  }
}
