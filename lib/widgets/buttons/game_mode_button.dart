import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gumpp/widgets/game_widget.dart';
import 'package:gumpp/widgets/ad_widget.dart';
import 'package:gumpp/app_params.dart';
import 'package:gumpp/remote_config_service.dart';
import 'package:gumpp/widgets/camera_screen.dart';

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

  RemoteConfigService _remoteConfigService;

  final Color buttonColor = Colors.yellow.shade100;
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
        AppParams.isTraining = isTutorial;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Stack(
            children: <Widget>[
              MyGameWidget(),
              CameraScreen(),
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
