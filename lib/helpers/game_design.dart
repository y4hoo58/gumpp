// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:gumpp/components/game_constants.dart';

class GameDesign {
  int max_sticks = 20;
  String game_mode;
  bool change_game_mode = false;
  int stick_moving_rand = 20;
  double total_points = 0;

  void calc_game_score() {}

  double calc_spawn_y_fac() {
    double calculated_spawn_y_fac;

    calculated_spawn_y_fac = min_port_spawn_y_fac + (total_points / 100000);

    if (calculated_spawn_y_fac > max_spawn_y_fac) {
      calculated_spawn_y_fac = max_spawn_y_fac;
    }

    return calculated_spawn_y_fac;
  }

  String select_stick_type() {
    var rng = Random();
    int which_stick = rng.nextInt(100);
    if (total_points < 2000) {
      return "normal";
    } else if (total_points >= 2000 && total_points < 10000) {
      if (which_stick < 70) {
        return "normal";
      } else if (which_stick >= 70 && which_stick < 85) {
        return "bonus";
      } else if (which_stick >= 85) {
        return "boosted";
      }
    } else {
      if (which_stick < 50) {
        return "normal";
      } else if (which_stick >= 50 && which_stick < 70) {
        return "bonus";
      } else if (which_stick >= 70 && which_stick < 90) {
        return "boosted";
      } else {
        return "inverse";
      }
    }
  }

  double calc_stick_speed(double screenwidth) {
    if (total_points >= 2000 && total_points < 3000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 10) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (total_points >= 3000 && total_points < 4000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 15) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (total_points >= 4000 && total_points < 5000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 20) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (total_points >= 5000 && total_points < 6000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 25) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (total_points >= 6000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 30) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (total_points < 2000) {
      return 0.0;
    }
  }
}
