// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flame/flame.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:is_first_run/is_first_run.dart';

import 'package:torch_light/torch_light.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:gumpp/app_params.dart';
import 'package:gumpp/helpers/shared_preferences_helper.dart';

import 'package:gumpp/widgets/buttons/play_button.dart';
import 'package:gumpp/widgets/buttons/settings_button.dart';
import 'package:gumpp/widgets/buttons/tutorial_button.dart';

import 'package:gumpp/widgets/title.dart';
import 'package:gumpp/widgets/menu_painter.dart';

int bestScore = 0;

//Main function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      //showPerformanceOverlay: true,
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
  @override
  void initState() {
    init();
    load_model();
    _initGoogleMobileAds();
    load_bestScore();
    load_voicePref();
    load_flashMode();
    checkIfTutorial();
    checkIfFlashOn();
    super.initState();
  }

  void checkIfFlashOn() async {
    if (AppParams.isFlashOn) {
      try {
        await TorchLight.disableTorch();
      } on Exception catch (_) {}
    }
  }

  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Flame.device.fullScreen();
    await Flame.device.setPortraitUpOnly();
  }

  void load_model() async {
    Interpreter _interpreter;
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
      set_bestScore(0);
    }

    AppParams.bestScore = bestScore;
  }

  void load_flashMode() async {
    int flashMode = await SharedPreferencesHelper.getFlashMode();
    AppParams.flashMode = flashMode;
  }

  void load_voicePref() async {
    final bool _voicePref = await SharedPreferencesHelper.getVoicePref();
    AppParams.voicePref = _voicePref;
  }

  void checkIfTutorial() async {
    AppParams.isTutorial ??= await IsFirstRun.isFirstRun();
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
    checkIfFlashOn();
    AppParams.gameSize = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    ];
    return Material(
      animationDuration: Duration(milliseconds: 0),
      color: Colors.black,
      child: Stack(children: <Widget>[
        MenuPainterr(),
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.15),
              ),
              TitleWidget(),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.3),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PlayButton(),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ),
                    TutorialButton(),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ),
                    SettingsButton(),
                  ]),
            ],
          ),
        ),
      ]),
    );
  }
}
