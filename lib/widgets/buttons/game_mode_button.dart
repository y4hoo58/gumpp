import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gumpp/widgets/game_widget.dart';
import 'package:gumpp/widgets/ad_widget.dart';
import 'package:gumpp/app_params.dart';
import 'package:gumpp/remote_config_service.dart';

class GameModeBut extends StatefulWidget {
  final bool isFrontCam;
  final bool isTutorial;

  GameModeBut(
    this.isFrontCam,
    this.isTutorial,
  );
  @override
  GameModeButState createState() =>
      GameModeButState(this.isFrontCam, this.isTutorial);
}

class GameModeButState extends State<GameModeBut> {
  final bool isFrontCam;
  final bool isTutorial;
  bool isLoading = true;
  RemoteConfigService _remoteConfigService;

  Color buttonColor = Colors.yellow.shade100;
  String assetName;
  GameModeButState(
    this.isFrontCam,
    this.isTutorial,
  );

  _initializeRemoteConfig() async {
    _remoteConfigService = await RemoteConfigService.getInstance();
    await _remoteConfigService.initialize();
  }

  @override
  void initState() {
    _initializeRemoteConfig();
    if (isFrontCam) {
      assetName = "assets/images/front_cam_img1.png";
    } else {
      assetName = "assets/images/back_cam_img1.png";
    }
    super.initState();

    //changeColor();
  }

  void changeColor() async {
    var rng = Random();
    while (true) {
      if (rng.nextBool()) {
        buttonColor = Colors.cyan.shade100;
      } else {
        buttonColor = Colors.yellow.shade100;
      }
      // int randColor = rng.nextInt(4);
      // switch (randColor) {
      //   case 0:
      //     buttonColor = Colors.cyanAccent;
      //     break;
      //   case 1:
      //     buttonColor = Colors.greenAccent.shade200;
      //     break;
      //   case 2:
      //     buttonColor = Colors.yellow.shade100;
      //     break;
      //   case 3:
      //     buttonColor = Colors.pink.shade200;
      //     break;
      // }

      setState(() {});
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      animationDuration: Duration(milliseconds: 10),
      highlightColor: Colors.white,
      splashColor: Colors.white,
      fillColor: buttonColor,
      onPressed: () {
        AppParams.isFrontCam = isFrontCam;
        AppParams.isTutorial = isTutorial;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Stack(
            children: <Widget>[
              MyGameWidget(),
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
          side: BorderSide(width: 1, color: Colors.yellow.shade100)),
    );
  }
}
