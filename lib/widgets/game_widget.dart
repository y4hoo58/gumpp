import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gumpp/jump_game.dart';

import 'package:gumpp/app_params.dart';

class MyGameWidget extends StatelessWidget {
  final JumpGame jumpGame = JumpGame();
  int bestScore;

  MyGameWidget() {
    setGongParams();
  }

  void setGongParams() {
    AppParams.gameState = -1;
  }

  onLose(BuildContext context) async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    jumpGame.onLose = () => onLose(context);
    return GameWidget(
      game: jumpGame,
    );
  }
}
