import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gumpp/jump_game.dart';
import 'package:gumpp/main.dart';

class MyGameWidget extends StatelessWidget {
  JumpGame jumpGame = JumpGame();

  onLose(BuildContext context) async {
    jumpGame = null;

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    if (jumpGame == null) {
      jumpGame = JumpGame();
    }
    jumpGame.onLose = () => onLose(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: GameWidget(
        game: jumpGame,
      ),
      // child: Container(
      //   color: Colors.transparent,
      //   child: GameWidget(
      //     game: jumpGame,
      //   ),
      // ),
    );
  }
}
