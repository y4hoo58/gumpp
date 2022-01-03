// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flame/sprite.dart';

class TutorialPage {
  Size screenSize;

  Sprite too_close = Sprite("too_close.png");
  Sprite too_up = Sprite("too_up.png");
  Sprite too_down = Sprite("too_down.png");
  Sprite correct_sprite = Sprite("correct.png");
  Sprite hand_palm_sprite = Sprite("hand_palm.png");

  double moving_hand_center_x, moving_hand_direction;

  double moving_hand_timer = 4;
  double t = 0;

  TutorialPage(this.screenSize);

  void render_tutorial_page(Canvas canvas) {
    render_black_box(canvas);
    render_title(canvas);
    render_info_panel(canvas);
    if (moving_hand_timer >= 0) {
      moving_hand_timer = moving_hand_timer - t;
      render_moving_hand(canvas);
    }
  }

  void render_black_box(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Rect black_rect;
    double render_x = screenSize.width * 0.0;
    double render_y = screenSize.height * 0;
    black_rect = Rect.fromLTWH(
        render_x, render_y, screenSize.width, screenSize.height * 0.375);
    canvas.drawRect(black_rect, paint);
  }

  void render_info_panel(Canvas canvas) {
    render_phone_image_one(canvas);
    render_phone_image_two(canvas);
    render_phone_image_three(canvas);
    render_phone_image_four(canvas);

    render_ayrim_line(canvas);

    render_alert_one(canvas);
    render_alert_two(canvas);
    render_alert_three(canvas);
    render_alert_four(canvas);

    tutorial_lower_text(canvas);
    // down_alert_text(canvas);
    // up_alert_text(canvas);
    // close_alert_text(canvas);
    correct_alert_text(canvas);
    //move_text(canvas);
  }

  //////////////////////////////////
  ///Render phone images
  /////////////////////////////////
  //TODO: Ekran oranına göre boyutları öyle bir ayarla ki resim kareye çok yakın olsun..
  void render_phone_image_one(Canvas canvas) {
    Rect phone_rect;
    double render_x = screenSize.width * 0.05;
    double render_y = screenSize.height * 0.15;

    phone_rect = Rect.fromLTWH(
        render_x, render_y, screenSize.width * 0.2, screenSize.height * 0.09);
    too_down.renderRect(canvas, phone_rect);
  }

  void render_phone_image_two(Canvas canvas) {
    Rect phone_rect;
    double render_x = screenSize.width * 0.275;
    double render_y = screenSize.height * 0.15;
    phone_rect = Rect.fromLTWH(
        render_x, render_y, screenSize.width * 0.2, screenSize.height * 0.09);
    too_up.renderRect(canvas, phone_rect);
  }

  void render_phone_image_three(Canvas canvas) {
    Rect phone_rect;
    double render_x = screenSize.width * 0.5;
    double render_y = screenSize.height * 0.15;
    phone_rect = Rect.fromLTWH(
        render_x, render_y, screenSize.width * 0.2, screenSize.height * 0.09);
    too_close.renderRect(canvas, phone_rect);
  }

  void render_phone_image_four(canvas) {
    Rect correct_rect;
    double render_x = screenSize.width * 0.75;
    double render_y = screenSize.height * 0.15;
    correct_rect = Rect.fromLTWH(
        render_x, render_y, screenSize.width * 0.2, screenSize.height * 0.09);
    correct_sprite.renderRect(canvas, correct_rect);
  }

  ///////////////////////////////////

  void render_moving_hand(Canvas canvas) {
    double render_beg_x = screenSize.width * 0.4;
    double render_fin_x = screenSize.width * 0.5;
    double render_y = screenSize.height * 0.65;

    if (moving_hand_center_x == null) {
      moving_hand_center_x = render_beg_x;
      moving_hand_direction = 1;
    } else {
      moving_hand_center_x = moving_hand_center_x +
          screenSize.width * 0.005 * moving_hand_direction;
    }
    if (moving_hand_direction == 1 && moving_hand_center_x > render_fin_x) {
      moving_hand_direction = -1;
    } else if (moving_hand_direction == -1 &&
        moving_hand_center_x < render_beg_x) {
      moving_hand_direction = 1;
    }

    Rect hand_palm_rect;
    hand_palm_rect = Rect.fromLTWH(moving_hand_center_x, render_y,
        screenSize.width * 0.11, screenSize.height * 0.075);
    hand_palm_sprite.renderRect(canvas, hand_palm_rect);
  }

  //////////////////////////////////
  ///Render alert texts..
  /////////////////////////////////
  void down_alert_text(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.cyan.shade100, fontSize: 15, fontWeight: FontWeight.w900);
    final textSpan = TextSpan(
      text: "Raise \nYour \nHand",
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
    final offset = Offset((screenSize.width * 0.15) - (textPainter.width * 0.5),
        screenSize.height * 0.325);
    textPainter.paint(canvas, offset);
  }

  void up_alert_text(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.cyan.shade100, fontSize: 15, fontWeight: FontWeight.w900);
    final textSpan = TextSpan(
      text: "Lower \n Your \n Hand",
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
    final offset = Offset((screenSize.width * 0.4 - (textPainter.width * 0.5)),
        screenSize.height * 0.325);
    textPainter.paint(canvas, offset);
  }

  void close_alert_text(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.cyan.shade100, fontSize: 15, fontWeight: FontWeight.w900);
    final textSpan = TextSpan(
      text: "Further \n  Your \n  Hand",
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
    final offset = Offset((screenSize.width * 0.6) - (textPainter.width * 0.5),
        screenSize.height * 0.325);
    textPainter.paint(canvas, offset);
  }

  void correct_alert_text(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.greenAccent.shade100,
        fontSize: 15,
        fontWeight: FontWeight.w900);
    final textSpan = TextSpan(
      text: "Perfect!",
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
    final offset = Offset((screenSize.width * 0.85) - (textPainter.width * 0.5),
        screenSize.height * 0.35);
    textPainter.paint(canvas, offset);
  }

  void tutorial_lower_text(Canvas canvas) {
    final textStyle = TextStyle(
        color: Colors.redAccent.shade200,
        fontSize: 15,
        fontWeight: FontWeight.w900);
    final textSpan = TextSpan(
      text: "Poor Gameplay Quality!",
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
    final offset = Offset((screenSize.width * 0.4) - (textPainter.width * 0.5),
        screenSize.height * 0.35);
    textPainter.paint(canvas, offset);
  }

  //////////////////////////////////

  //////////////////////////////////
  ///Render alerts
  /////////////////////////////////
  void render_alert_one(Canvas canvas) {
    double render_x = screenSize.width * 0.125;
    double render_y = screenSize.height * 0.3;
    double radius = screenSize.height / 40;

    final center = Offset(render_x, render_y);
    final paint = Paint();
    paint.color = Colors.white;
    canvas.drawCircle(center, radius, paint);

    final p3 = Offset(render_x - (radius * 0.75), (render_y + radius * 0.1));
    final p4 = Offset(render_x, render_y - (radius / 2));

    final p5 = Offset(render_x + (radius * 0.75), (render_y + (radius * 0.1)));

    final points = [p3, p4, p5];

    final pointMode = PointMode.polygon;

    final line_paint = Paint()
      ..color = Colors.red.shade600
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, line_paint);
  }

  void render_alert_two(Canvas canvas) {
    double render_x = screenSize.width * 0.375;
    double render_y = screenSize.height * 0.3;
    double radius = screenSize.height / 40;

    final center = Offset(render_x, render_y);

    final paint = Paint();

    paint.color = Colors.white;
    canvas.drawCircle(center, radius, paint);

    final p3 = Offset(render_x - (radius * 0.75), render_y - (radius * 0.1));
    final p4 = Offset(render_x, render_y + (radius / 2));

    final p5 = Offset(render_x + (radius * 0.75), render_y - (radius * 0.1));

    final points = [p3, p4, p5];

    final pointMode = PointMode.polygon;

    final line_paint = Paint()
      ..color = Colors.red.shade600
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, line_paint);
  }

  void render_alert_three(Canvas canvas) {
    double render_x = screenSize.width * 0.6;
    double render_y = screenSize.height * 0.3;
    double radius = screenSize.height / 40;

    final center = Offset(render_x, render_y);

    final paint = Paint();

    paint.color = Colors.white;
    canvas.drawCircle(center, radius, paint);

    final p1 = Offset(render_x - radius / 2, render_y - radius / 2);
    final p2 = Offset(render_x + radius / 2, render_y + radius / 2);

    final p3 = Offset(render_x - radius / 2, render_y + radius / 2);
    final p4 = Offset(render_x + radius / 2, render_y - radius / 2);

    final line_paint = Paint()
      ..color = Colors.red.shade600
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(p1, p2, line_paint);
    canvas.drawLine(p3, p4, line_paint);
  }

  void render_alert_four(Canvas canvas) {
    double render_x = screenSize.width * 0.85;
    double render_y = screenSize.height * 0.3;
    double radius = screenSize.height / 40;

    final center = Offset(render_x, render_y);

    final paint = Paint();

    paint.color = Colors.white;
    canvas.drawCircle(center, radius, paint);
  }

  void render_middle_line(Canvas canvas) {
    final p1 = Offset(0, screenSize.height * 0.7);
    final p2 = Offset(screenSize.width, screenSize.height * 0.7);
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  //////////////////////////////////

  void render_upper_line(Canvas canvas) {
    final p1 = Offset(0, screenSize.height * 0.2);
    final p2 = Offset(screenSize.width, screenSize.height * 0.2);
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  void render_ayrim_line(Canvas canvas) {
    render_ayrim_line1(canvas);
    render_ayrim_line2(canvas);
    final p1 = Offset(screenSize.width * 0.725, screenSize.height * 0.125);
    final p2 = Offset(screenSize.width * 0.725, screenSize.height * 0.375);
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 5;
    canvas.drawLine(p1, p2, paint);
  }

  void render_ayrim_line1(Canvas canvas) {
    final p1 = Offset(screenSize.width * 0.4875, screenSize.height * 0.14);
    final p2 = Offset(screenSize.width * 0.4875, screenSize.height * 0.25);
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  void render_ayrim_line2(Canvas canvas) {
    final p1 = Offset(screenSize.width * 0.2625, screenSize.height * 0.14);
    final p2 = Offset(screenSize.width * 0.2625, screenSize.height * 0.25);
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  // Title of the tutorial page..
  void render_title(Canvas canvas) {
    final textStyle = TextStyle(
      color: Colors.cyan.shade100,
      fontSize: screenSize.width * 0.075,
      fontWeight: FontWeight.w900,
    );
    final textSpan = TextSpan(
      text: "TUTORIAL",
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
    final offset = Offset((screenSize.width * 0.5) - (textPainter.width * 0.5),
        screenSize.height * 0.075);
    textPainter.paint(canvas, offset);
  }
}
