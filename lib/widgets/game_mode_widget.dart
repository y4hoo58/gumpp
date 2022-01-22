import 'package:flutter/material.dart';

import 'package:gumpp/widgets/buttons/game_mode_button.dart';

class GameModWidg extends StatelessWidget {
  final bool isTutorial;
  GameModWidg(this.isTutorial);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
            ]),
          ],
        ),
      ),
    );
  }
}
