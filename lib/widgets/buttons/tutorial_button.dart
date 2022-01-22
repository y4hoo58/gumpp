import 'package:flutter/material.dart';

import 'package:gumpp/widgets/game_mode_widget.dart';

class TutorialButton extends StatefulWidget {
  TutorialButton();
  @override
  TutorialButtonState createState() => TutorialButtonState();
}

class TutorialButtonState extends State<TutorialButton> {
  Color buttonColor = Colors.yellow.shade100;

  String assetName;

  TutorialButtonState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.075,
      child: RawMaterialButton(
        fillColor: buttonColor,
        child: const Text(
          "TUTORIAL",
          style: TextStyle(
            backgroundColor: Colors.transparent,
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => GameModWidg(true));
        },
      ),
    );
  }
}
