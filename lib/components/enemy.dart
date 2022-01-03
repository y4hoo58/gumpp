// ignore_for_file: non_constant_identifier_names

import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gumpp/components/game_constants.dart';

class Enemy {
  Size screenSize;
  Paint paint;

  double center_x, center_y, radius;
  double render_x, render_y;
  double x_speed, y_speed;
  double direction = 1;

  bool is_died = false;

  Enemy(this.screenSize) {
    init_enemy();
  }

  //Renders the stick.
  void render(Canvas canvas) {
    double render_x = center_x;
    double render_y = center_y;

    final center = Offset(render_x, render_y);

    paint.color = Colors.red;
    canvas.drawCircle(center, radius, paint);
  }

  void init_enemy() {
    radius = char_radius_fac * screenSize.width;

    var rng = Random();
    center_x =
        rng.nextInt((screenSize.width - (radius / 2)).floor()) + (radius / 2);

    center_y = rng.nextInt((screenSize.width / 5).floor()).toDouble();
  }
}
