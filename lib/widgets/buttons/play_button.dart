import 'package:flutter/material.dart';

import 'package:gumpp/widgets/game_mode_widget.dart';

class PlayButton extends StatefulWidget {
  PlayButton();
  @override
  PlayButtonState createState() => PlayButtonState();
}

class PlayButtonState extends State<PlayButton> {
  final Color buttonColor = Colors.yellow.shade100;

  String assetName;

  PlayButtonState();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.075,
      child: RawMaterialButton(
        highlightColor: Colors.white,
        splashColor: Colors.white,
        fillColor: buttonColor,
        child: const Text(
          "PLAY",
          style: TextStyle(
            backgroundColor: Colors.transparent,
            color: Colors.black,
            //TODO : fontsize parametereleştirilecek
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => GameModWidg(false));
        },
      ),
    );
  }
}
