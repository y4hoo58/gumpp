// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gumpp/app_params.dart';

class Stick {
  Rect stick_rect;

  double center_x, center_y, width, height;
  double org_width, org_height;
  double render_x, render_y;
  double x_speed, y_speed;
  double direction;

  String stick_type;

  Stick(this.stick_type);

  //Renders the stick.
  void render(Canvas canvas) {
    final paint = Paint();
    if (stick_type == "normal") {
      paint.color = Colors.yellow.shade100;
    } else if (stick_type == "inverse") {
      paint.color = Colors.red;
    } else if (stick_type == "boosted") {
      paint.color = Colors.green;
    } else if (stick_type == "bonus") {
      paint.color = Colors.pink;
    }
    render_x = (center_x - ((width) / 2));
    render_y = (center_y) - (height / 2);

    stick_rect = Rect.fromLTWH(render_x, render_y, (width), (height));
    canvas.drawRect(stick_rect, paint);

    //stick_sprite.renderRect(canvas, stick_rect);
  }

  //Updates the coordinate of the stick according to the offset of the character..

  void scale_stick(double prediction_box_area) {
    double scale = sqrt(prediction_box_area) / 40;
    if (scale > 1.5) {
      scale = 1.5;
    }
    if (scale < 1) {
      scale = 1;
    }
    width = scale * org_width;
  }

  bool update(double t, double char_offset, double prediction_box_area) {
    //scale_stick(prediction_box_area);
    if (char_offset != null) {
      center_y = center_y + char_offset;
    }
    if (x_speed != null) {
      if (direction == 1) {
        if (center_x + (width / 2) + (x_speed * t) >= AppParams.gameSize[0]) {
          center_x = AppParams.gameSize[0] - (width / 2);
          direction = -1;
        } else {
          center_x = center_x + x_speed * t;
        }
      } else if (direction == -1) {
        if (center_x - (width / 2) - (x_speed * t) <= 0) {
          center_x = width / 2;
          direction = 1;
        } else {
          center_x = center_x - x_speed * t;
        }
      }
    }
    if (center_y > AppParams.gameSize[1]) {
      return true;
    } else {
      return false;
    }
  }
}
