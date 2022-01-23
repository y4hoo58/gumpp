import 'package:flutter/material.dart';

class DesignParams {
  static Color retryButCol = Colors.yellow.shade100;

  static Color menuButCol = Colors.yellow.shade100;

  static Color pauseCol = Colors.yellow.shade100;

  static void setRetryButCol(bool isDown) {
    if (isDown) {
      retryButCol = Colors.white;
    } else {
      retryButCol = Colors.yellow.shade100;
    }
  }

  static void setMenuButCol(bool isDown) {
    if (isDown) {
      menuButCol = Colors.white;
    } else {
      menuButCol = Colors.yellow.shade100;
    }
  }

  static void setPauseCol(bool isDown) {
    if (isDown) {
      pauseCol = Colors.white;
    } else {
      pauseCol = Colors.yellow.shade100;
    }
  }
}
