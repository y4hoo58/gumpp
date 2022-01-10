import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gumpp/jump_game.dart';

class MyGameWidget extends StatelessWidget {
  final JumpGame jumpGame = JumpGame();
  int bestScore;

  MyGameWidget() {
    initStateless();
  }

  void initStateless() {
    jumpGame.bestScore = bestScore;
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
