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
    init_game();
  }

  String condition = "full initialization";
  String orientation;

  bool is_tutorial;
  double initial_wait = 2;

  int bestScore = 0;

  int renderScore;

  Interpreter interpreter;

  void initGame() async {
    await checkIfTutorial();

    gameEngine = GameEngine(tutorialPage);
    gameEngine.is_tutorial = is_tutorial;

    handDetection = HandDetection();

    initial_wait = 2;
  }

  void checkIfTutorial() async {
    if (is_tutorial == null) {
      is_tutorial = await IsFirstRun.isFirstRun();
    } else if (is_tutorial == true) {
      is_tutorial = false;
    }

    if (is_tutorial == true) {
      tutorialPage = TutorialPage();
    }
  }

  void resetGame() {
    handDetection.startLoop();
    //gameEngine.resetGameParams();

    initial_wait = 1;
  }

  @override
  bool onTapUp(TapUpInfo tapUp) {
    if (condition == "initialized") {
      condition = "playing";
    } else if (condition == "game finished") {
      //TODO: buradaki aralığı tam retry text boyutlarına göre ayarla
      double tap_y = tapUpDetails.globalPosition.dy;
      if (tap_y > AppParams.gameSize[1] * 0.69 &&
          tap_y < AppParams.gameSize[1] * 0.79) {
        //Retry atılacağı için durumu restart game olarak değiştir.
        condition = "lite initialization";

        //Başlatma işlemini tekrardan yap.
        init_game();
      } else if (tap_y > AppParams.gameSize[1] * 0.84 &&
          tap_y < AppParams.gameSize[1] * 0.95) {
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
            //TODO: prediction_box_area yeniden eklenecek
            //handDetection.prediction_box_area,
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
      gameEngine.render(canvas, condition);
    }
    if (is_tutorial == true) {
      tutorialPage.render_tutorial_page(canvas);
    }
  }
}
