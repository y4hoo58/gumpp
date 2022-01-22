import 'package:flutter/material.dart';

import 'package:gumpp/app_params.dart';
import 'package:gumpp/helpers/shared_preferences_helper.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final Color onColor = Colors.greenAccent;
  final Color offColor = Colors.redAccent;
  final Color buttonColor = Colors.yellow.shade100;

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
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
                  "FLASH",
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.075,
                  child: RawMaterialButton(
                    highlightColor: Colors.white,
                    splashColor: Colors.white,
                    fillColor: buttonColor,
                    child: const Text(
                      "BACK",
                      style: TextStyle(
                        backgroundColor: Colors.transparent,
                        color: Colors.black,
                        //TODO : fontsize parametereleştirilecek
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
