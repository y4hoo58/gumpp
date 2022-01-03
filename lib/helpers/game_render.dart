import 'package:flutter/material.dart';

import 'package:gumpp/components/character.dart';
import 'package:gumpp/components/sticks/sticks.dart';
import 'package:gumpp/helpers/shared_preferences_helper.dart';

class GameRender {
  String current_game_mode;

  List<Stick> all_sticks;
  MyCharacter myCharacter;

  Size screenSize;

  double y_hand;
  double prediction_box_area;
  double total_points = 0;

  int bestScore;

  //TODO: Her seferinde tekrar tekrar screensize geçmek yerine
  //tek seferde yap
  GameRender() {
    load_bestScore();
  }
  void setScreensize(Size screenSize) {
    this.screenSize = screenSize;
  }

  void load_bestScore() async {
    bestScore = await SharedPreferencesHelper.getBestScore();
    //Eğer daha önceden bestscore kaydedilmediyse null döndürüyor.
    if (bestScore == null) {
      bestScore = 0;
    }
  }

  void setParameters(
      List all_sticks,
      String current_game_mode,
      double total_points,
      MyCharacter myCharacter,
      int bestScore,
      double y_hand,
      double prediction_box_area) {
    this.all_sticks = all_sticks;
    this.current_game_mode = current_game_mode;
    this.total_points = total_points;
    this.myCharacter = myCharacter;
    this.bestScore = bestScore;
    this.y_hand = y_hand;
    this.prediction_box_area = prediction_box_area;
  }

  void render(Canvas canvas, String condition) {
    //Oyun arka planını renderlar.
    drawBackground(canvas);

    //Oyun ekranının arkasına score tabelasını renderlar.
    render_score(canvas, 0.3);

    //Her bir stick'in renderlanmasını sağlar.

    for (var i = 0; i < all_sticks.length; i++) {
      all_sticks[i].render(canvas);
    }

    myCharacter.render(canvas, y_hand, prediction_box_area);

    //Best score'u renderlar.
    render_best(canvas);

    //Eğer tap screen renderlanması gerekiyorsa, oyun ekranının üzerine tap screen'i
    //renderlar. Eğer oyun bittiyse aynı şeyi finish screen için gerçekleştirir.
    //Bu ekranların normal halinde arkada oyun tasarımı olduğu gibi kaldığı için
    //bu ikisini ayrı birer ekranmış gibi düşünme.
    if (condition == "initialized") {
      render_tap_screen(canvas);
    } else if (condition == "game finished") {
      render_finish_screen(canvas);
    }
  }

  //Render background
  void drawBackground(canvas) {
    final bgRect = Rect.fromLTWH(
      0,
      0,
      screenSize.width,
      screenSize.height,
    );
    final bgPaint = Paint();

    if (current_game_mode == "inverse_mode") {
      bgPaint.color = Colors.redAccent.shade100;
    } else {
      bgPaint.color = Colors.black;
    }
    canvas.drawRect(bgRect, bgPaint);
  }

  //Render the finish screen when character dies.
  void render_finish_screen(Canvas canvas) {
    render_finish_background(canvas);
    render_score(canvas, 1.0);
    render_score_text(canvas);
    render_best(canvas);
    render_retry_button(canvas);
    render_menu_button(canvas);
  }

  //Render the background when the game finished.
  void render_finish_background(Canvas canvas) {
    //TODO: Bu fonksiyona gerçekten gerek var mı??
    final bgRect = Rect.fromLTWH(
      0,
      0,
      screenSize.width,
      screenSize.height,
    );
    final bgPaint = Paint();
    bgPaint.color = Colors.black87;
    canvas.drawRect(bgRect, bgPaint);
  }

  //Render score at the end of the game and during the gameplay.
  void render_score_text(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.cyan.shade100,
        fontSize: screenSize.width * 0.09,
        fontWeight: FontWeight.w700);

    final textSpan = TextSpan(
      text: "SCORE",
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: screenSize.width,
    );

    final textOffset = Offset((screenSize.width / 2) - textPainter.width / 2,
        screenSize.height * 0.375);
    textPainter.paint(canvas, textOffset);

    ///KONTROL EDİLDİ
  }

  //Render the score.
  void render_score(Canvas canvas, opacityy) {
    final textStyle = TextStyle(
        color: Colors.cyan.shade100.withOpacity(opacityy),
        fontSize: screenSize.width * 0.2,
        fontWeight: FontWeight.w900);

    final textSpan = TextSpan(
      text: total_points.round().toString(),
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: screenSize.width,
    );
    final textOffset = Offset((screenSize.width / 2) - textPainter.width / 2,
        (screenSize.height / 2) - textPainter.height / 2);
    textPainter.paint(canvas, textOffset);
  }

  //Render retry button at the end of the game.
  void render_retry_button(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.black,
        fontSize: screenSize.width * 0.1,
        fontWeight: FontWeight.w900);

    final textSpan = TextSpan(
      text: "RETRY",
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: screenSize.width,
    );
    final textOffset = Offset((screenSize.width / 2) - textPainter.width / 2,
        screenSize.height * 0.7);

    final bgRect = Rect.fromLTWH(
      (screenSize.width * 0.25),
      screenSize.height * 0.69,
      screenSize.width * 0.5,
      screenSize.height * 0.075,
    );

    //Button background color.
    final bgPaint = Paint();
    bgPaint.color = Colors.cyan.shade100;

    canvas.drawRect(bgRect, bgPaint);
    textPainter.paint(canvas, textOffset);

    ///KONTROL EDİLDİ
  }

  //Render menu button at the end of the game.
  void render_menu_button(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.black,
        fontSize: screenSize.width * 0.1,
        fontWeight: FontWeight.w900);

    final textSpan = TextSpan(
      text: "MENU",
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: screenSize.width,
    );

    final textOffset = Offset((screenSize.width / 2) - textPainter.width / 2,
        screenSize.height * 0.85);

    final bgRect = Rect.fromLTWH(
      (screenSize.width * 0.25),
      screenSize.height * 0.84,
      screenSize.width * 0.5,
      screenSize.height * 0.075,
    );

    //Button background color.
    final bgPaint = Paint();
    bgPaint.color = Colors.cyan.shade100;

    canvas.drawRect(bgRect, bgPaint);
    textPainter.paint(canvas, textOffset);

    ///KONTROL EDİLDİ
  }

  //Render best score at the start of the screen.
  void render_best(Canvas canvas) {
    //Render best text.
    final bestStyle = TextStyle(
        color: Colors.cyan.shade100,
        fontSize: screenSize.width * 0.1,
        fontWeight: FontWeight.w900);

    final bestSpan = TextSpan(
      text: "BEST",
      style: bestStyle,
    );
    final bestPainter = TextPainter(
      text: bestSpan,
      textDirection: TextDirection.ltr,
    );
    bestPainter.layout(
      minWidth: 0,
      maxWidth: screenSize.width,
    );
    final bestOffset = Offset((screenSize.width / 2) - bestPainter.width / 2,
        bestPainter.height * 1.25);

    bestPainter.paint(canvas, bestOffset);

    //Render score text.
    final scoreStyle = TextStyle(
        color: Colors.cyan.shade100,
        fontSize: screenSize.width * 0.1,
        fontWeight: FontWeight.w200);

    //TODO: Best score kaydetmeyi ayarladığın zaman burayı düzeltmeyi unutma.
    final scoreSpan = TextSpan(
      text: bestScore.toString(),
      //text: score.round().toString(),
      style: scoreStyle,
    );
    final scorePainter = TextPainter(
      text: scoreSpan,
      textDirection: TextDirection.ltr,
    );
    scorePainter.layout(
      minWidth: 0,
      maxWidth: screenSize.width,
    );
    final scoreOffset = Offset((screenSize.width / 2) - scorePainter.width / 2,
        bestPainter.height * 1.25 + scorePainter.height);
    scorePainter.paint(canvas, scoreOffset);

    ///KONTROL EDİLDİ
  }

  //Renders the tap to play button.
  void render_tap_screen(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.cyan.shade100,
        fontSize: screenSize.width * 0.1,
        fontWeight: FontWeight.w900);

    final textSpan = TextSpan(
      text: "TAP TO PLAY",
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: screenSize.width,
    );

    //Text locations
    final offset = Offset((screenSize.width / 2) - (textPainter.width / 2),
        (screenSize.height / 2) - (textPainter.height / 2));

    //Draw background.
    final bgRect = Rect.fromLTWH(0, 0, (screenSize.width), (screenSize.height));
    final bgPaint = Paint();
    bgPaint.color = Colors.black87;
    canvas.drawRect(bgRect, bgPaint);

    //Draw text.
    textPainter.paint(canvas, offset);
  }
}
