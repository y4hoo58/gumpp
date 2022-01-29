// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:torch_light/torch_light.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:gumpp/app_params.dart';

import 'package:gumpp/widgets/buttons/play_button.dart';
import 'package:gumpp/widgets/buttons/settings_button.dart';
import 'package:gumpp/widgets/buttons/tutorial_button.dart';
import 'package:gumpp/widgets/title.dart';
import 'package:gumpp/widgets/menu_painter.dart';

import 'package:gumpp/app_initialization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final AppInitialization _appInitialization = AppInitialization();
  _appInitialization.initGame();

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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  void checkIfFlashOn() async {
    /*
    State her build attığında çalışır.
    Ana ekranda hiç bir şekilde flash yanmasını istemediğim için
    herhangi bir condition eklemedim.
    Zaten bu state pek fazla çağrılmadığı için pek sıkıntı olmaz.
   */
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {}
  }

  void setScreenSize(final BuildContext context) {
    /*
      Ekran boyutlarını AppParams classına taşır.
      Widget her build attığında çalışır.
    */
    AppParams.gameSize = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    ];
  }

  @override
  Widget build(BuildContext context) {
    /*
      Alttaki iki fonksiyonu gözden kaçırma.
     */
    checkIfFlashOn();
    setScreenSize(context);

    return Material(
      animationDuration: const Duration(milliseconds: 0),
      color: Colors.black,
      child: Stack(children: <Widget>[
        MenuPainterr(),
        SizedBox(
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
