// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flame/flame.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:gumpp/app_params.dart';
import 'package:gumpp/helpers/shared_preferences_helper.dart';
import 'package:gumpp/widgets/playbutton.dart';
import 'package:gumpp/widgets/title.dart';
import 'package:gumpp/widgets/menu_painter.dart';

int bestScore = 0;

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

  @override
  void initState() {
    init();
    load_model();
    _initGoogleMobileAds();
    load_bestScore();
    super.initState();
  }

  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Flame.device.fullScreen();
    await Flame.device.setPortraitUpOnly();
  }

  void load_model() async {
    var interpreterOptions = InterpreterOptions()..useNnApiForAndroid = true;

    _interpreter = await Interpreter.fromAsset('palm_detection.tflite',
        options: interpreterOptions);
    _interpreter.allocateTensors();

    AppParams.interpreterAddress = _interpreter.address;
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  void load_bestScore() async {
    bestScore = await SharedPreferencesHelper.getBestScore();

    //Eğer daha önceden bestscore kaydedilmediyse null döndürüyor.
    if (bestScore == null) {
      bestScore = 0;
      set_bestScore(bestScore);
    }
    AppParams.bestScore = bestScore;
  }

  void set_bestScore(int best_score) async {
    SharedPreferencesHelper.setBestScore(best_score);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppParams.gameSize = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    ];
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
              PlayButton(true),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.05),
              ),
              PlayButton(false),
            ]),
          ],
        ),
      ]),
    );
  }
}
