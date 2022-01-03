import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gumpp/main.dart';
import 'package:gumpp/widgets/game_widget.dart';
import 'package:gumpp/widgets/ad_widget.dart';

class PlayButton extends StatefulWidget {
  final String buttonName;
  PlayButton(this.buttonName);
  @override
  PlayButtonState createState() => PlayButtonState(this.buttonName);
}

class PlayButtonState extends State<PlayButton> {
  final String buttonName;
  Color buttonColor = Colors.transparent;
  String assetName;
  PlayButtonState(this.buttonName);

  @override
  void initState() {
    super.initState();
    if (buttonName == "front_cam") {
      assetName = "assets/images/front_cam_img.png";
    } else if (buttonName == "rear_cam") {
      assetName = "assets/images/back_cam_img.png";
    }

    changeColor();
  }

  void changeColor() async {
    var rng = Random();
    while (true) {
      int randColor = rng.nextInt(4);
      switch (randColor) {
        case 0:
          buttonColor = Colors.red.shade100;
          break;
        case 1:
          buttonColor = Colors.green.shade100;
          break;
        case 2:
          buttonColor = Colors.yellow.shade100;
          break;
        case 3:
          buttonColor = Colors.pink.shade100;
          break;
      }

      setState(() {});
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: buttonColor,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Stack(
            children: <Widget>[
              GameWidget(buttonName, jumpGame),
              AddWidg(),
            ],
          );
        }));
      },
      elevation: 0,
      child: Image.asset(
        assetName,
        fit: BoxFit.contain,
        scale: (MediaQuery.of(context).size.height / 300).ceil().ceilToDouble(),
      ),
      padding: const EdgeInsets.all(10.0),
      shape: ContinuousRectangleBorder(
          side: BorderSide(width: 1, color: Colors.cyan.shade100)),
    );
  }
}
