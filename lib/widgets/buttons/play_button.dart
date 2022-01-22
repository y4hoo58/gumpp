import 'package:flutter/material.dart';

import 'package:is_first_run/is_first_run.dart';

import 'package:gumpp/widgets/game_mode_widget.dart';

class PlayButton extends StatefulWidget {
  PlayButton();
  @override
  PlayButtonState createState() => PlayButtonState();
}

class PlayButtonState extends State<PlayButton> {
  Color buttonColor = Colors.yellow.shade100;

  String assetName;

  bool isFirstRun = false;

  PlayButtonState();

  @override
  void initState() {
    _initAsynState();
  }

  void _initAsynState() async {
    isFirstRun = await IsFirstRun.isFirstRun();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.075,
      child: RawMaterialButton(
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
              builder: (BuildContext context) => GameModWidg(isFirstRun));
        },
      ),
    );
  }
}
