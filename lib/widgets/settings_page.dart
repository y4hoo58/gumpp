import 'package:flutter/material.dart';

import 'package:gumpp/app_params.dart';
import 'package:gumpp/helpers/shared_preferences_helper.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  Color onColor = Colors.greenAccent;
  Color offColor = Colors.redAccent;

  SettingsPageState();

  @override
  void initState() {}

  void setVoicePref() async {
    if (AppParams.voicePref) {
      AppParams.voicePref = false;
    } else {
      AppParams.voicePref = true;
    }
    await SharedPreferencesHelper.setVoicePref(AppParams.voicePref);
    setState(() {});
  }

  void setFlashMode() async {
    switch (AppParams.flashMode) {
      case -1:
        AppParams.flashMode = 1;
        break;
      // case 0:
      //   AppParams.flashMode = 1;
      //   break;
      case 1:
        AppParams.flashMode = -1;
        break;
    }
    await SharedPreferencesHelper.setFlashMode(AppParams.flashMode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "SOUND",
                style: TextStyle(
                  //TODO: Fontsize parametrelereştirilecek
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.yellow.shade100,
                ),
              ),
              RawMaterialButton(
                fillColor: AppParams.voicePref ? onColor : offColor,
                child: Text(
                  AppParams.voicePref ? "ON" : "OFF",
                  style: TextStyle(
                    //TODO: FONT SIZE PARAMETERELEŞTİRİLECEK
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onPressed: () {
                  setVoicePref();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                " FLASH",
                style: TextStyle(
                  //TODO: Fontsize parametrelereştirilecek
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.yellow.shade100,
                ),
              ),
              RawMaterialButton(
                fillColor: (() {
                  switch (AppParams.flashMode) {
                    case -1:
                      return Colors.redAccent;
                      break;
                    // case 0:
                    //   return Colors.grey;
                    //   break;
                    case 1:
                      return Colors.greenAccent;
                      break;
                  }
                }()),
                child: (() {
                  String _butText = "ON";
                  switch (AppParams.flashMode) {
                    case -1:
                      _butText = "OFF";
                      break;
                    // case 0:
                    //   _butText = "AUTO";
                    //   break;
                    case 1:
                      _butText = "ON";
                      break;
                  }
                  return Text(
                    _butText,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  );
                }()),
                onPressed: () {
                  setFlashMode();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
