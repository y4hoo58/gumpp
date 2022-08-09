import 'package:flutter/material.dart';

import 'package:gumpp/components/character.dart';
import 'package:gumpp/app_params.dart';
import 'package:gumpp/game/visible/game_buttons.dart';
import 'package:gumpp/game/visible/other_obj.dart';

class GameRender {
  MyCharacter myCharacter;
  GameButtons gameButs = GameButtons();
  OtherObj otherObj = OtherObj();

  void render(
    final Canvas _canvas,
    final renderSticksCallback,
    final renderCharacterCallback,
    final double _y_hand,
    final double _prediction_box_area,
  ) {
    /*
      Oyun arka planını renderlar.
    */
    drawBackground(_canvas);

    otherObj.drawScore(_canvas, false, AppParams.totalScore);

    renderSticksCallback(_canvas);
    renderCharacterCallback(_canvas, _y_hand, _prediction_box_area);

    /*
      Training ve tutorial durumunda best score renderlanmaz.
    */
    if (AppParams.isTutorial == false && AppParams.isTraining == false) {
      otherObj.drawBestScore(_canvas, AppParams.bestScore);
    }

    switch (AppParams.gameState) {
      case 0:
        gameButs.drawPauseButton(_canvas);
        break;
      case -1:
        drawTapScreen(_canvas);
        break;
      case 1:
        drawFinishScreen(_canvas);
        break;
      case 3:
        drawPauseScreen(_canvas);
        break;
    }
  }

  /*
    "Tap to play" ekranını renderlar.
  */
  void drawTapScreen(final Canvas _canvas) {
    drawBackground(_canvas);
    otherObj.drawTapText(_canvas);
  }

  /*
    Draws black background with 0.87 opacity.
  */
  void drawBackground(final Canvas _canvas) {
    final _bgRect = Rect.fromLTWH(
      0,
      0,
      AppParams.gameSize[0],
      AppParams.gameSize[1],
    );
    final _bgPaint = Paint();

    _bgPaint.color = Colors.black87;

    _canvas.drawRect(_bgRect, _bgPaint);
  }

  void drawPauseScreen(final Canvas _canvas) {
    drawBackground(_canvas);
    gameButs.drawRetryButton(_canvas);
    gameButs.drawMenuButton(_canvas);
  }

  void drawFinishScreen(final Canvas _canvas) {
    drawBackground(_canvas);
    otherObj.drawScore(_canvas, true, AppParams.totalScore);
    otherObj.drawBestScore(_canvas, AppParams.bestScore);
    gameButs.drawRetryButton(_canvas);
    gameButs.drawMenuButton(_canvas);
  }
}
