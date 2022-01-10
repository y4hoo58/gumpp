// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flame/flame.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:gumpp/jump_game.dart';
import 'package:gumpp/helpers/shared_preferences_helper.dart';
import 'package:gumpp/widgets/playbutton.dart';
import 'package:gumpp/widgets/title.dart';
import 'package:gumpp/widgets/menu_painter.dart';

int bestScore = 0;

//Create jumpgame object
JumpGame jumpGame = JumpGame();

//Main function
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

//Homescreen statefulwidget
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//Homescreen state
class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Interpreter _interpreter;
  //Loads the tflite model.

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    init();
    load_bestScore();
    _initGoogleMobileAds();
    load_model();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void load_model() async {
    var interpreterOptions = InterpreterOptions()..useNnApiForAndroid = true;

    _interpreter = await Interpreter.fromAsset('palm_detection.tflite',
        options: interpreterOptions);
    _interpreter.allocateTensors();

    jumpGame.interpreter = _interpreter;
  }

  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Flame.device.fullScreen();
    await Flame.device.setPortraitUpOnly();
  }

  //TODO
  void load_bestScore() async {
    bestScore = await SharedPreferencesHelper.getBestScore();
    //Eğer daha önceden bestscore kaydedilmediyse null döndürüyor.
    if (bestScore == null) {
      bestScore = 0;
      set_bestScore(bestScore);
    }
  }

  void set_bestScore(int best_score) async {
    SharedPreferencesHelper.setBestScore(best_score);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(children: <Widget>[
        MenuPainterr(),
        Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.15),
            ),
            TitleWidget(),
            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.175),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              PlayButton("front_cam"),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.05),
              ),
              PlayButton("rear_cam"),
            ]),
          ],
        ),
      ]),
    );
  }
}
