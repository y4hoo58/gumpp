//Game constants
// ignore_for_file: constant_identifier_names

const game_speed = 0.5;
const gravity_fac = (0.6) * (game_speed); //kullanıldı

//Constants about the character.
const char_radius_fac = 1 / 20; //kullanıldı

const char_center_x_fac = 1 / 2; //kullanıldı
const char_center_y_fac = 9 / 10; //kullanıldı

const char_port_y_speed_fac = (4 / 15) * game_speed; //kullanıldı
const char_port_y_speed_boost_fac = (6 / 15) * game_speed; //kullanıldı

const char_land_y_speed_fac = (4 / 15) * game_speed; //kullanıldı
const char_land_y_speed_boost_fac = (6 / 15) * game_speed; //kullanıldı

const pow_const = 1.5;
const pow_dist_fac = 0.5;

//Constants about the sticks.
const stick_width_fac = 0.2; // kullanıldı
const stick_height_fac = 0.015; // kullanıldı

const stick_center_x_fac = 0.5; // kullanıldı

const min_port_spawn_y_fac = (0.075) * game_speed; //kullanıldı
const min_land_spawn_y_fac = (0.075) * game_speed; //kullanıldı

const stick_speed_fac = 0.5; //kullanıldı

//Stickler arasındaki mesafe, karakterin zıplama mesafesinden daha az olmamalı.
//Gravity'i de hesaba katacak olursak, azaltma faktörü olarak 0.9 kullanılabilir.
//Bu değer daha sonradan optimize edilebilir.
const max_spawn_y_fac = char_port_y_speed_fac * 0.9;

const List<double> ax = [
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375
];
const List<double> ay = [
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.03125,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.09375,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.15625,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.21875,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.28125,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.34375,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.40625,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.46875,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.53125,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.59375,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.65625,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.71875,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.78125,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.84375,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.90625,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.96875,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.0625,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.1875,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.3125,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.4375,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.5625,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.6875,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.8125,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375,
  0.9375
];