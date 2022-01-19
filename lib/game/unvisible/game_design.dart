// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:gumpp/components/game_constants.dart';
import 'package:gumpp/app_params.dart';

class GameDesign {
  int max_sticks = 20;
  int stick_moving_rand = 20;

  void calc_game_score() {}

  double calc_spawn_y_fac() {
    double calculated_spawn_y_fac;

    calculated_spawn_y_fac =
        min_port_spawn_y_fac + (AppParams.totalScore / 100000);

    if (calculated_spawn_y_fac > max_spawn_y_fac) {
      calculated_spawn_y_fac = max_spawn_y_fac;
    }

    return calculated_spawn_y_fac;
  }

  //TODO: Oyun zorluğuna bağlı olarak bir fonksiyona bağlanıcak
  String select_stick_type() {
    var rng = Random();
    int which_stick = rng.nextInt(100);
    if (AppParams.totalScore < 2000) {
      return "normal";
    } else if (AppParams.totalScore >= 2000 && AppParams.totalScore < 10000) {
      if (which_stick < 70) {
        return "normal";
      } else if (which_stick >= 70 && which_stick < 85) {
        return "bonus";
      } else if (which_stick >= 85) {
        return "boosted";
      }
    } else if (AppParams.totalScore >= 10000 && AppParams.totalScore < 20000) {
      if (which_stick < 31) {
        return "normal";
      } else if (which_stick >= 31 && which_stick < 54) {
        return "bonus";
      } else if (which_stick >= 54 && which_stick < 77) {
        return "boosted";
      } else {
        return "inverse";
      }
    } else {
      if (which_stick < 30) {
        return "normal";
      } else if (which_stick >= 30 && which_stick < 60) {
        return "bonus";
      } else if (which_stick >= 60 && which_stick < 70) {
        return "boosted";
      } else {
        return "inverse";
      }
    }
  }

  double calc_stick_speed(double screenwidth) {
    if (AppParams.totalScore < 2000) {
      return 0.0;
    } else if (AppParams.totalScore >= 2000 && AppParams.totalScore < 4000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 10) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 4000 && AppParams.totalScore < 6000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 15) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 6000 && AppParams.totalScore < 10000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 20) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 10000 && AppParams.totalScore < 12000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 25) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 12000 && AppParams.totalScore < 15000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 30) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 15000 && AppParams.totalScore < 18000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 35) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 18000 && AppParams.totalScore < 21000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 40) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 21000 && AppParams.totalScore < 24000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 45) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 24000 && AppParams.totalScore < 27000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 50) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 27000 && AppParams.totalScore < 30000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 55) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac)).toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 30000 && AppParams.totalScore < 33000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 60) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac) * 1.2)
                .toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 36000 && AppParams.totalScore < 39000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 65) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac) * 1.4)
                .toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 39000 && AppParams.totalScore < 42000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 75) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac) * 1.6)
                .toDouble();
        return stick_speed;
      }
    } else if (AppParams.totalScore >= 42000 && AppParams.totalScore < 50000) {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 80) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac) * 1.8)
                .toDouble();
        return stick_speed;
      }
    } else {
      var rng = Random();
      int is_moving_rand = rng.nextInt(100);
      if (is_moving_rand < 100) {
        double stick_speed =
            (rng.nextInt(200) + (screenwidth * stick_speed_fac) * 2).toDouble();
        return stick_speed;
      }
    }
  }
}
