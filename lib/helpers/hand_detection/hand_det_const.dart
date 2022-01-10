class HDetConst {
  //SSD Tflite modeli için kullanılan parametreler.
  static const int options_num_boxes = 896;

  static const double options_x_scale = 128.0;
  static const double options_h_scale = 128.0;
  static const double options_w_scale = 128.0;

  static const double detection_threshold = 0.5;

  //Anchors
  static const List<double> anchorsX = [
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
  static const List<double> anchorsY = [
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
}