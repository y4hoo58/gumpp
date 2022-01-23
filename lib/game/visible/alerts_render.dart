import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:gumpp/app_params.dart';

//Priority uzaklık>yükseklik =  alçaklık
class AlertsRender {
  Sprite handSprite;

  double tgCenterX, tgCenterY, tgStepSize;
  double handCenterX, handCenterY;

  double xHand, yHand, maxArea;
  double zoomOutScale = 0.75;

  /*alertRendering:
  * 0 : No alert
  * 1 : Moving right
  * 2 : Moving up
  * 3 : Moving down
  */
  int alertRendering = 0;
  bool isRender = false;
  AlertsRender() {
    tgCenterX = AppParams.gameSize[0] * 0.6;
    tgCenterY = AppParams.gameSize[1] * 0.25;
    init();
  }

  void init() async {
    handSprite = Sprite(await Flame.images.load("hand_sprite.png"));
  }

  //TODO : Şimdilik yakınlık alerti devre dışı
  void renderAlert(
      final double xHand, final double yHand, final double maxArea) {
    this.yHand = yHand;
    this.xHand = xHand;
    this.maxArea = maxArea;

    // //Eğer fotoda el algılanamadıysa default değerleri kullan.
    // if (AppParams.isHandOnImage == false) {
    //   this.maxArea = 0;
    //   this.yHand = 0.5;
    // }

    if (alertRendering == 0) {
      isRender = false;
    }

    //Yukarı ya da aşağı hareketi seçer
    if (yHand > 0.9 && alertRendering == 0) {
      zoomOutScale = 0.75;
      setHandDownCoords();
      alertRendering = 3;
      isRender = true;
    } else if (yHand < 0.1 && alertRendering == 0) {
      zoomOutScale = 0.75;
      setHandUpCoords();
      alertRendering = 2;
      isRender = true;
    }

    //Eğer yakınlık yüksekse diğerlerinin önemsemez direkt yakınlığı seçer
    if (sqrt(maxArea) >= 50 && alertRendering == 0) {
      setHandRightCoords();
      zoomOutScale = 0.75;
      alertRendering = 1;
      isRender = true;
    }

    if (alertRendering == 1) {
      zoomOutEffect();
    } else if (alertRendering == 2) {
      moveHandUp();
    } else if (alertRendering == 3) {
      moveHandDown();
    }
  }

  void setHandUpCoords() {
    handCenterX = AppParams.gameSize[0] * 0.5;
    handCenterY = AppParams.gameSize[1] * 0.35;
  }

  void setHandDownCoords() {
    handCenterX = AppParams.gameSize[0] * 0.5;
    handCenterY = AppParams.gameSize[1] * 0.15;
  }

  void setHandRightCoords() {
    handCenterX = AppParams.gameSize[0] * 0.5;
    handCenterY = AppParams.gameSize[1] * 0.25;
  }

  void moveHandUp() {
    tgStepSize = AppParams.gameSize[1] * 0.0025;
    if ((handCenterY - tgCenterY).abs() <= tgStepSize) {
      handCenterY = tgCenterY;
      alertRendering = 0;
      yHand = 0.5;
    } else {
      handCenterY = handCenterY - tgStepSize;
    }
  }

  void moveHandDown() {
    tgStepSize = AppParams.gameSize[1] * 0.0025;

    if ((handCenterY - tgCenterY).abs() <= tgStepSize) {
      handCenterY = tgCenterY;
      alertRendering = 0;

      yHand = 0.5;
    } else {
      handCenterY = handCenterY + tgStepSize;
    }
  }

  void zoomOutEffect() {
    zoomOutScale = zoomOutScale + 0.025;
    if (zoomOutScale >= 1.5) {
      alertRendering = 0;
      maxArea = 0;
    }
  }

  void render(Canvas canvas) {
    if (isRender == true) {
      //renderBackground(canvas);
      //renderText(canvas);
      renderHand(canvas);
    }
  }

  void renderBackground(Canvas canvas) {
    final bgRect = Rect.fromLTWH(
      0,
      AppParams.gameSize[1] * 0.2,
      AppParams.gameSize[0],
      AppParams.gameSize[1] * 0.25,
    );
    final bgPaint = Paint();
    bgPaint.color = Colors.black54;
    canvas.drawRect(bgRect, bgPaint);
  }

  void renderText(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.red.shade700,
        fontSize: AppParams.gameSize[0] * 0.09,
        fontWeight: FontWeight.w700);

    final textSpan = TextSpan(
      text: "ALERT",
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: AppParams.gameSize[0],
    );

    final textOffset = Offset(
        (AppParams.gameSize[0] * 0.5) - textPainter.width / 2,
        AppParams.gameSize[1] * 0.175);
    textPainter.paint(canvas, textOffset);
  }

  void renderHand(Canvas canvas) {
    if (xHand != null && yHand != null) {
      final double render_x = handCenterX;
      final double render_y = handCenterY;
      final double width = AppParams.gameSize[0] * 0.3 * zoomOutScale;
      final double height = AppParams.gameSize[1] * 0.15 * zoomOutScale;
      final Rect hand_rect = Rect.fromLTWH(
          render_x - width * 0.5, render_y - height * 0.5, width, height);
      handSprite.renderRect(canvas, hand_rect);
    }
  }
}
