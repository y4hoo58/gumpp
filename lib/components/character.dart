// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gumpp/components/game_constants.dart';

import 'package:gumpp/app_params.dart';

class MyCharacter {
  double radius, center_x, center_y;
  double old_center_x, old_center_y, old_y_speed;
  double x_speed, y_speed;

  double gravity;
  double game_mode_factor;
  double abs_char_offset = 0;

  Paint paint = Paint();

  MyCharacter() {
    init_character();
  }

  //Initializes character..
  void init_character() {
    //TODO: Yerini değiştir
    gravity = AppParams.gameSize[1] * gravity_fac;

    final double _square = pow(
      pow(AppParams.gameSize[0], 2) + pow(AppParams.gameSize[1], 2),
      0.5,
    );
    //Create the character variables and constants..
    radius = char_radius_fac * _square * 0.5;
    center_x = char_center_x_fac * AppParams.gameSize[0];
    center_y = char_center_y_fac * AppParams.gameSize[1];
    y_speed = char_port_y_speed_fac * AppParams.gameSize[1];
    game_mode_factor = 1;

    //Old variables. Used for colliding detection.
    old_center_x = center_x;
    old_center_y = center_y;
    old_y_speed = y_speed;

    /// KONTROL EDİLDİ.
    ///TODO: game_mode_factor kontrol edilecek.
  }

  void update(double t, double x_hand) {
    //TODO : Burayı yeniden kontrol et.
    // Eğer x_hand nullsa, karakter aynı yerinde kalsın herhangi bir yöne hareket etmesin.
    // Daha sonraki evrelerde bu kısım bir miktar geliştirilebilir ve bir prediction ile
    // başka bir değer atanabilir.

    if (x_hand != null) {
      update_center_x(x_hand);
    } else {
      update_center_x(center_x);
    }

    //Update center y
    update_center_y(t);

    check_if_above_centerline();

    //Karakterin ölüp ölmediğini kontrol et.
    is_char_died();
  }

  void update_center_x(double x_hand) {
    //Old center x. Used for colliding detection.
    old_center_x = center_x;

    //Current location as float.
    double x_float = center_x / AppParams.gameSize[0];

    // if (AppParams.currentGameMode == -1) {
    //   x_hand = (1 - x_hand).abs();
    // }
    double dist = (x_float - x_hand).abs();

    double pow_dist = pow(dist, 1.5 + (dist / 2));

    //Smooth center x moving speed.
    if (x_hand > x_float) {
      x_float = x_float + pow_dist;
    } else {
      x_float = x_float - pow_dist;
    }

    //New center x.
    center_x = x_float * AppParams.gameSize[0];

    //Prevent going out of screen.
    if (center_x >= (AppParams.gameSize[0] - (radius))) {
      center_x = AppParams.gameSize[0] - (radius);
    } else if (center_x <= ((radius))) {
      center_x = (radius);
    }
  }

  void update_center_y(double t) {
    //Old vertical speed. Used for colliding detection.
    old_y_speed = y_speed;

    //Update vertical speed.
    y_speed = y_speed - (t * gravity * game_mode_factor);
    //TODO: game_mode_factor ne işe yarıyor??

    //Old center y. Used for colliding detection.
    old_center_y = center_y;

    //Update center y
    //TODO: Burada y_speed kadar center'dan çıkarıyoruz
    //bu sayede y eksenine göre ters dönmüş oluyor.
    center_y = center_y - (y_speed * t * 10);
  }

  void check_if_above_centerline() {
    //Check if over the half of the screen.
    if (center_y <= AppParams.gameSize[1] * 0.5) {
      abs_char_offset = (AppParams.gameSize[1] * 0.5) - center_y;
      //Prevent going over the half of the screen.
      center_y = AppParams.gameSize[1] * 0.5;
    }
  }

  bool is_char_died() {
    //Kill if below the screen.
    if ((center_y - radius) > AppParams.gameSize[1]) {
      return true;
    } else {
      return false;
    }
  }

  //TODO: String yerine başka ne kullanılabilir?
  String bounce_the_ball(double y_correction, String stick_type) {
    center_y = center_y + y_correction;
    if (stick_type == "boosted") {
      y_speed = AppParams.gameSize[1] * char_port_y_speed_boost_fac;
      return "";
    } else if (stick_type == "inverse") {
      y_speed = AppParams.gameSize[1] * char_port_y_speed_fac;

      return "reversity";
    } else if (stick_type == "bonus") {
      y_speed = AppParams.gameSize[1] * char_port_y_speed_fac;
      return "randomize";
    } else {
      y_speed = AppParams.gameSize[1] * char_port_y_speed_fac;
      return "";
    }
  }

  //Renders charachter..
  void render(Canvas canvas, double y_hand, double average_box_area) {
    final center = Offset(center_x, center_y);

    paint.color = Colors.yellow.shade100;
    canvas.drawCircle(center, radius, paint);

    // if (y_hand != null) {
    //   if (y_hand > 0.75) {
    //     render_alert_one(canvas, paint, center, center_x, center_y);
    //   } else if (y_hand < 0.25) {
    //     render_alert_two(canvas, paint, center, center_x, center_y);
    //   }
    // }

    ///TODO: alert three için hem el boyutu hem de prediction ın ağırlığı gerekiyor.
    ///O şekilde olursa daha güvenilir sonuç alınır. 50 değerinden de eminmisin ayrıca?
    // if (average_box_area != null) {
    //   if (sqrt(average_box_area) > 50) {
    //     render_alert_three(canvas, paint, center, center_x, center_y);
    //   }
    // }

    /// KONTROL EDİLDİ.
  }

  //Renders the alert on the character.
  void render_alert_one(Canvas canvas, Paint paint, Offset center,
      double render_x, double render_y) {
    paint.color = Colors.white;
    canvas.drawCircle(center, radius - 2.5, paint);

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

  //Renders the alert on the character.
  void render_alert_two(Canvas canvas, Paint paint, Offset center,
      double render_x, double render_y) {
    paint.color = Colors.white;
    canvas.drawCircle(center, radius - 2.5, paint);

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

  //Renders the alert on the character.
  void render_alert_three(Canvas canvas, Paint paint, Offset center,
      double render_x, double render_y) {
    paint.color = Colors.white;
    canvas.drawCircle(center, radius - 2.5, paint);

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
}
