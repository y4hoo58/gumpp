import 'package:flutter/material.dart';

import 'package:gumpp/widgets/buttons/game_mode_button.dart';

class GameModWidg extends StatelessWidget {
  final bool isTutorial;
  GameModWidg(this.isTutorial);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "CAMERA",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.05,
                fontWeight: FontWeight.w900,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GameModeBut(
                  true,
                  isTutorial,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                GameModeBut(
                  false,
                  isTutorial,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.075,
              child: RawMaterialButton(
                highlightColor: Colors.white,
                splashColor: Colors.white,
                fillColor: Colors.yellow.shade100,
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
      ),
    );
  }
}
