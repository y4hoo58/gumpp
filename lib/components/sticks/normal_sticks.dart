// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:gumpp/components/sticks/sticks.dart';
import 'package:gumpp/components/game_constants.dart';

import 'package:gumpp/app_params.dart';

class NormalStick extends Stick {
  double spawn_y, stick_speed;

  NormalStick(this.spawn_y, this.stick_speed) : super("normal") {
    set_stick_properties();
  }

  void set_stick_properties() {
    //Width and height of the stick
    width = AppParams.gameSize[0] * stick_width_fac;
    height = AppParams.gameSize[1] * stick_height_fac;

    org_width = AppParams.gameSize[0] * stick_width_fac;
    org_height = AppParams.gameSize[1] * stick_height_fac;
    //Spawning x coordinates  of a stick always random.
    var rng = Random();
    center_x =
        rng.nextInt((AppParams.gameSize[0] - (1 * width)).floor()).toDouble() +
            (width * stick_center_x_fac);

    //Spawning coordinate of the stick,vertically.
    center_y = spawn_y;

    //If stick speed is not 0 then it's moving horizontally.
    if (stick_speed != 0) {
      x_speed = stick_speed;
      double random_direction = rng.nextDouble();
      if (random_direction > 0.5) {
        direction = 1;
      } else {
        direction = -1;
      }
    }
  }
}
