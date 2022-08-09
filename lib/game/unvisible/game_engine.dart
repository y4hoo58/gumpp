// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flame_audio/flame_audio.dart';

import 'package:gumpp/app_params.dart';
// import 'package:gumpp/game/visible/tutorial_page.dart';

import 'package:gumpp/components/character.dart';
import 'package:gumpp/components/sticks/sticks.dart';

import 'package:gumpp/game/unvisible/game_design.dart';
import 'package:gumpp/game/unvisible/physics_engine.dart';

import 'package:gumpp/game/visible/game_render.dart';

import 'package:gumpp/components/sticks/normal_sticks.dart';
import 'package:gumpp/components/sticks/bonus_sticks.dart';
import 'package:gumpp/components/sticks/inverse_sticks.dart';
import 'package:gumpp/components/sticks/boosted_sticks.dart';

class GameEngine {
  PhysicsEngine physicsEngine = PhysicsEngine();
  GameDesign gameDesign = GameDesign();
  GameRender gameRender = GameRender();
  // TutorialPage tutorialPage;
  MyCharacter myCharacter;

  List<Stick> all_sticks = [];

  double y_hand, prediction_box_area;

  GameEngine() {
    init_game_engine();
  }

  void init_game_engine() {
    create_initial_sticks();

    myCharacter = MyCharacter();
  }

  void create_initial_sticks() {
    for (var i = 20; i > 0; i = i - 1) {
      all_sticks.add(NormalStick(i * AppParams.gameSize[1] / 25, 0));
    }
  }

  bool update(
    double t,
    double x_hand,
    double y_hand,
  ) {
    //Render işleminde kullanıldığı için global olarak (y_hand) ve
    //(prediction_box_area) değişkenlerinin değerlerinin tutulması gerekiyor.
    this.y_hand = y_hand;
    //this.prediction_box_area = prediction_box_area;

    //Bir önceki tur tamamlandıktan sonra (abs_char_offset)'i sıfırlamak lazım.
    //Bu turda bu değer sıfır kalabilir. Sıfır kalırsa ekran kaymaya devam etmesin.
    myCharacter.abs_char_offset = 0;

    //Karakteri güncelle.
    myCharacter.update(t, x_hand);

    //Stickleri güncelle
    update_sticks(t);

    //Yeni stickler spawnlanması gerekiyorsa spawnla.
    spawn_new_sticks();

    //Karakter ve sticklerin temas edip etmediğini kontrol et.
    final col_list = physicsEngine.detect_stick_collison([
      myCharacter.old_y_speed,
      myCharacter.old_center_x,
      myCharacter.old_center_y,
      myCharacter.center_x,
      myCharacter.center_y,
      myCharacter.radius,
      myCharacter.y_speed,
    ], all_sticks);

    //Eğer temas varsa (y_correction) değeri kadar karakter zıplatılacak.
    //Not: Stick türüne bağlı olarak...

    double y_correction;
    String stick_type;
    if (col_list[0] != null && col_list[1] != null) {
      y_correction = col_list[0];
      stick_type = all_sticks[col_list[1]].stick_type;
      //Eğer cezalı veya ödüllü sticklere temas gerçekleştiyse
      //oyun modunu değiştirir.
      change_game_mode(stick_type, col_list[1]);

      //Karakterin zıplamasını sağlar.Karakterin y konumunu tekrardan günceller.
      myCharacter.bounce_the_ball(y_correction, stick_type);
      playAudio();
    }

    //Karakterin ölüp ölmediği temas gerçekleşip gerçekleşmediği kontrol
    //edildikten sonra gerçekleştiriliyor.
    bool is_char_died = myCharacter.is_char_died();

    updateScore();

    if (is_char_died) {
      if (AppParams.isTutorial || AppParams.isTraining) {
        if (AppParams.totalScore > 5000) {
          return true;
        } else {
          myCharacter.y_speed = AppParams.gameSize[1] * 0.2;
          // tutorialPage.moving_hand_timer = 2;
          return false;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  void playAudio() {
    if (AppParams.voicePref == true) {
      FlameAudio.play("ball_hit.mp3");
    }
  }

  //Yeni stickler spawnlar.
  //Spawnlama işlemini gerçekleştirirken y konumunu belirler.
  //Daha sonra GameDesign'dan stick speed'i belirlemesini ister.
  //Ardından yine GameDesign'dan bir adet stick çeşidi belirlemesini belirler.
  //Bu parametrelere göre yeni bir stick oluşturur.
  void spawn_new_sticks() {
    if (all_sticks.length <= gameDesign.max_sticks) {
      //Spawnlanacak stick y konumunu GameDesign aracılığıyla belirle.
      double spawn_y;
      double spawn_y_fac = gameDesign.calc_spawn_y_fac();

      spawn_y = all_sticks[all_sticks.length - 1].center_y -
          AppParams.gameSize[1] * spawn_y_fac;

      //Spawnlanacak stick'in hareket edip etmeyeceğini
      //ve eğer edicekse hızını GameDesign aracılığıyla belirle.
      double stick_speed = gameDesign.calc_stick_speed(AppParams.gameSize[0]);

      //Oyunun durumuna bağlı olarak GameDesign'ın bir stick çeşidi seçmesini iste.
      //Daha sonra stick'i listeye ekle.
      String stick_type = gameDesign.select_stick_type();
      if (stick_type == "normal") {
        all_sticks.add(NormalStick(spawn_y, stick_speed));
      } else if (stick_type == "bonus") {
        all_sticks.add(BonusStick(spawn_y, stick_speed));
      } else if (stick_type == "boosted") {
        all_sticks.add(BoostedStick(spawn_y, stick_speed));
      } else {
        all_sticks.add(InverseStick(spawn_y, stick_speed));
      }
    }
  }

  void update_sticks(double t) {
    int i = 0;

    while (i < all_sticks.length) {
      bool is_died = all_sticks[i]
          .update(t, myCharacter.abs_char_offset, prediction_box_area);
      if (is_died == true) {
        all_sticks.remove(all_sticks[i]);
        i = i - 1;
      }
      i = i + 1;
    }
  }

  void change_game_mode(String stick_type, int stickIndex) {
    if (stick_type == "bonus") {
      randomizeSticks();
    } else if (stick_type == "inverse") {
      deleteBouncedStick(stickIndex);
    }
  }

  //Random stick'e temas sağlandığında stick x konumlarının
  //rastgele olarak değişmesini sağlar.
  //TODO: Randomization işlemini kontrol et.
  void randomizeSticks() {
    var rng = Random();

    for (var i = 0; i < all_sticks.length; i++) {
      all_sticks[i].center_x = rng
              .nextInt(
                  (AppParams.gameSize[0] - (2 * all_sticks[i].width)).floor())
              .toDouble() +
          (all_sticks[i].width);
    }
  }

  void deleteBouncedStick(int stickIndex) {
    all_sticks.removeAt(stickIndex);
  }

  void updateScore() {
    int _score;
    if (myCharacter.abs_char_offset == null) {
      _score = 0;
    } else {
      _score = myCharacter.abs_char_offset.toInt();
    }
    AppParams.totalScore =
        AppParams.totalScore + myCharacter.abs_char_offset.toInt();
  }

  void render(final Canvas _canvas) {
    gameRender.render(
      _canvas,
      renderAllSticks,
      myCharacter.render,
      y_hand,
      prediction_box_area,
    );
  }

  void renderAllSticks(final Canvas _canvas) {
    for (var i = 0; i < all_sticks.length; i++) {
      all_sticks[i].render(_canvas);
    }
  }
}
