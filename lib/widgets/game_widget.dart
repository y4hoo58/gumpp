import 'package:flutter/material.dart';
import 'package:gumpp/jump_game.dart';

class GameWidget extends StatelessWidget {
  final String camm;
  final JumpGame jumpGame;
  int bestScore;
  GameWidget(this.camm, this.jumpGame) {
    initStateless();
  }

  void initStateless() {
    jumpGame.condition = "full initialization";
    jumpGame.orientation = camm;

    jumpGame.bestScore = bestScore;
  }

  onLose(BuildContext context) async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    jumpGame.onLose = () => onLose(context);
    return jumpGame.widget;
  }
}
