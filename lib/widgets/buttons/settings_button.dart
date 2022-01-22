import 'package:flutter/material.dart';

import 'package:gumpp/widgets/game_mode_widget.dart';
import 'package:gumpp/widgets/settings_page.dart';

class SettingsButton extends StatelessWidget {
  Color buttonColor = Colors.yellow.shade100;

  String assetName;

  SettingsButton();

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
          "SETTINGS",
          style: TextStyle(
            backgroundColor: Colors.transparent,
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return SettingsPage();
          }));
        },
      ),
    );
  }
}
