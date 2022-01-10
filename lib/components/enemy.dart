// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gumpp/components/game_constants.dart';

import 'package:gumpp/app_params.dart';

class Enemy {
  Paint paint;

  double center_x, center_y, radius;
  double render_x, render_y;
  double x_speed, y_speed;
  double direction = 1;

  bool is_died = false;

  Enemy() {
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
    radius = char_radius_fac * AppParams.gameSize[0];

    var rng = Random();
    center_x = rng.nextInt((AppParams.gameSize[0] - (radius / 2)).floor()) +
        (radius / 2);

    center_y = rng.nextInt((AppParams.gameSize[1] / 5).floor()).toDouble();
  }
}
