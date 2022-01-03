import 'dart:math';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatefulWidget {
  TitleWidget();

  @override
  TitleState createState() => TitleState();
}

class TitleState extends State<TitleWidget> {
  Color titleColor = Colors.cyan.shade100;

  @override
  void initState() {
    super.initState();
    changeColor();
  }

  void changeColor() async {
    var rng = Random();
    while (true) {
      int randColor = rng.nextInt(10);
      switch (randColor) {
        case 0:
          titleColor = Colors.cyan.shade100;
          break;
        case 1:
          titleColor = Colors.cyanAccent.shade100;
          break;
        case 2:
          titleColor = Colors.pink.shade100;
          break;
        case 3:
          titleColor = Colors.pinkAccent.shade100;
          break;
        case 4:
          titleColor = Colors.red.shade100;
          break;
        case 5:
          titleColor = Colors.redAccent.shade100;
          break;
        case 6:
          titleColor = Colors.green.shade100;
          break;
        case 7:
          titleColor = Colors.greenAccent.shade100;
          break;
        case 8:
          titleColor = Colors.yellow.shade100;
          break;
        case 9:
          titleColor = Colors.yellowAccent.shade100;
          break;
        case 10:
          titleColor = Colors.white38;
          break;
      }

      setState(() {});
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "GUMP",
      style: GoogleFonts.megrim(
        color: titleColor,
        fontWeight: FontWeight.w900,
        fontSize: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }
}
