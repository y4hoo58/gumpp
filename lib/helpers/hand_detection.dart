// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'dart:typed_data';
import 'dart:isolate';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_flashlight/flutter_flashlight.dart';
import 'package:torch_light/torch_light.dart';

import 'package:gumpp/helpers/hand_detection_isolate.dart';
import 'package:gumpp/components/game_constants.dart';

class HandDetection {
  HandDetection(this.orientation);
  IsolateUtils isolateUtils = IsolateUtils();

  List<CameraDescription> cameras; //Available kameraların tutulacağı list.
  CameraController cameraController;
  Interpreter interpreter;

  //Tflite model outputs.
  var classificators = Float32List(1 * 896 * 1).reshape([1, 896, 1]);
  var regressors = Float32List(1 * 896 * 18).reshape([1, 896, 18]);

  //Float coordinates(0-1) of the detected hand.
  double x_hand;
  double y_hand;

  String orientation = "rear_cam"; //Kullanılacak olan kamera.

  //Anchors..
  List<double> anchors_x = ax;
  List<double> anchors_y = ay;
  List<double> box_areas = [];

  //Prediction confidence ortalaması.
  //Henüz bu değere dışarıdan erişim yok.
  //TODO: Karakter render'ında kullanılacak.
  double p_weight = 0;

  //Max.confidence'a sahip olan prediction box'ın alanı.
  //Jumpgame.update bu değeri alıp GameEngine.update'e veriyor. Daha sonra GameEngine
  //class'ında global değişkene atanıyor. Bu global değişken karakter renderlanması esnasında
  //kullanıcının yönlendirilmesi için kullanılıyor.
  //[JumpGame.update->GameEngine.update->GameEngine.global]
  //TODO: Karakter render'ında (p_weight) değişkeni de kullanılacak.
  double prediction_box_area;

  //Bildiğimiz threshold.
  //Kullanım yerleri :
  //[HandDetection.detect_xhand] ve [HandDetection.decode_boxes]
  double detection_threshold = 0.5;

  //Decoded centers..
  var center_xs = Float32List(896);
  var center_ys = Float32List(896);
  var outputs;
  var buffer = Float32List.view(Float32List(1 * 128 * 128 * 3).buffer);

  bool is_camera_working = false;
  double prediction_count = 0;

  //Initialization processes..
  void initialization() async {
    await isolateUtils.start();
    await initialize_camera();
  }

  //Isolate'i çalıştırır.
  //Isolate'ten aldığı output'u [HandDetection.decode_boxes]'a ve daha sonra [HandDetection.detect_xhand]'e
  //gönderir. Bu metodlar çağrıldıktan sonra (x_hand) ve (y_hand) gibi değişkenler
  //belirlenmiş olur.
  //Bu metod sadece [HandDetection.yuv240torgb] tarafından çağrılır.
  void predict() async {
    var isolateData =
        IsolateData(buffer, interpreter.address, regressors, classificators);

    Map<int, dynamic> outputs = await inference(isolateData);

    decode_boxes(outputs[0], outputs[1]);
    detect_xhand(outputs[1]);
  }

  //Tflite modelinin başka bir isolate'te çalışmasını sağlar.
  //[HandDetection.predict] tarafından çağrılır.
  Future<Map<int, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils.sendPort
        .send(isolateData..responsePort = responsePort.sendPort);

    var results = await responsePort.first;
    return results;
  }

  void detect_xhand(List<List<List<dynamic>>> classificator) {
    double x_weighted = 0; //Ağırlıklandırılmış x değeri.
    double y_weighted = 0; //Ağırlıklandırılmış y değeri.
    double total_weight =
        0; //Threshold'dan daha büyük olan predictionların, confidence skoruna göre belirlenen ağırlıklarının toplamı.
    double prediction_count =
        0; //Confidence'ı threshold'dan daha büyük olan prediction sayısı.
    double max_area; //Maximum confidence'ın alanı.
    double max_confidence; //Maximum confidence.

    //Tüm predictionlar loop yapıp, confidence skora göre ağırlıklandırılmış x ve y değerleri elde edilir.
    //Non-max suppression yapmaya gerek kalmaz. Çünkü daha doğal bir dağılım elde etmek ve konumdaki atlamaların
    //önüne geçmek için threshold'dan daha büyük olan tüm predictionlar x değerine confidence skorunun ağırlığına göre
    //katkıda bulunur.
    for (var i = 0; i < 896; i++) {
      //Prediction confidence threshold değerinden düşükse hesaplara katılmaz.
      if (classificator[0][i][0] > detection_threshold) {
        x_weighted =
            x_weighted + (center_xs[i] * pow(classificator[0][i][0].abs(), 2));
        y_weighted =
            y_weighted + (center_ys[i] * pow(classificator[0][i][0].abs(), 2));

        total_weight = total_weight + pow(classificator[0][i][0].abs(), 2);
        prediction_count++;

        // El büyüklüğünü classification confidence'a göre belirle.
        if (max_area == null) {
          max_confidence = classificator[0][i][0];
          max_area = box_areas[i];
        } else {
          if (classificator[0][i][0] > max_confidence) {
            max_confidence = classificator[0][i][0];
            max_area = box_areas[i];
          }
        }
      }
    }

    if (x_weighted != 0 && total_weight != 0) {
      if (orientation == "front_cam") {
        x_hand = x_weighted / total_weight;
        //x_hand = (1 - x_hand).abs();
        x_hand = (((x_hand - 0.35) / (0.3)));
        x_hand = x_hand * 0.5;

        y_hand = y_weighted / total_weight;
        y_hand = (1 - y_hand).abs();
        p_weight = total_weight / prediction_count;
      } else if (orientation == "rear_cam") {
        x_hand = x_weighted / total_weight;
        //x_hand = (1 - x_hand).abs();
        x_hand = (((x_hand - 0.35) / (0.3)));

        y_hand = y_weighted / total_weight;
        p_weight = total_weight / prediction_count;
      }
      prediction_box_area = 128 * 128 * max_area;

      box_areas = [];
    } else {
      p_weight = 0;
    }
  }

  ///////////////////////////////////////////////////////////////
  ///Camera Stream..
  ///////////////////////////////////////////////////////////////

  //Kamerayı başlatır. Ancak stream'e başlamaz.
  //Class initialization metodu içerisinden otomatik olarak çağrılır.
  //Onun haricinde bu metodu başka hiç bir metod çağırmaz.
  void initialize_camera() async {
    //Avaiable cameraların listesini alır.
    cameras = await availableCameras();

    List<int> cam_indexes =
        []; //Sadece ön veya sadece arka kameraları tutacak liste.

    //Tüm kameralar için loop yap.
    for (var i = 0; i < cameras.length; i++) {
      if (orientation == "front_cam") {
        if (cameras[i].lensDirection == CameraLensDirection.front) {
          cam_indexes.add(i);
        }
      } else if (orientation == "rear_cam") {
        if (cameras[i].lensDirection == CameraLensDirection.back) {
          cam_indexes.add(i);
        }
      }
    }

    //TODO: minzoomlevel a göre seçim yapılacak.
    try {
      cameraController = CameraController(
          cameras[cam_indexes[1]], ResolutionPreset.low,
          enableAudio: false, imageFormatGroup: ImageFormatGroup.yuv420);
    } on Exception {
      cameraController = CameraController(
          cameras[cam_indexes[0]], ResolutionPreset.low,
          enableAudio: false);
    }

    start_stream();
  }

  //Imagestream'i başlatır. Her bir yeni image geldiği zaman [HandDetection.onLatestImageAvailable] çağrılır.
  //(is_camera_working) true yapılır. Bu sayede [JumpGame.update] kameranın çalıştığından haberdar olur.
  //TODO: cameracontroller ayarlarını buradan taşımak gerekir mi?
  void start_stream() async {
    await cameraController.initialize().then((_) async {
      await cameraController.startImageStream(onLatestImageAvailable);
    });

    //TODO : auto nasıl gerekip gerekmediğini biliyorsa o şekilde belirle sende..
    //cameraController.setFlashMode(FlashMode.auto);
    cameraController.setZoomLevel(await cameraController.getMinZoomLevel());

    cameraController.setFocusPoint(Offset(0.5, 0.5));
    cameraController.setFocusMode(FocusMode.auto);
    cameraController.setFocusPoint(Offset(0.5, 0.5));

    cameraController.lockCaptureOrientation();

    if (orientation == "rear_cam") {
      try {
        await TorchLight.enableTorch();
      } on Exception catch (_) {
        // Handle error
      }
    }
    is_camera_working = true;
  }

  //Kamera'yı kapatmak yerine geçici olarak durdurur. Bu sayede geri açılması
  //daha hızlı olur.
  //TODO: [GameEngine.update] kısmında oyun durduğu zaman kullanılacak.
  void stop_stream() async {
    if (orientation == "rear_cam") {
      try {
        await TorchLight.disableTorch();
      } on Exception catch (_) {
        // Handle error
      }
    }

    await cameraController.stopImageStream();
    is_camera_working = false;
  }

  //Kamerayı kapatır. Geri açılması bu yüzden uzun sürer.
  //TODO: Menu tuşuna basıldığı zaman bu metod çağrılması gerekiyor.
  void dispose_camera() async {
    Flashlight.lightOff();
    cameraController.dispose();
    is_camera_working = false;
  }

  //[HandDetection.start_stream] tarafından çağrılır.
  //ImageFormatGroup'a göre hangi dönüştürme metodunun çağrılacağını belirler.
  //TODO: Eğer ios ve android için iki farklı uygulama yazılacaksa bunu kaldırıp
  //TODO: direkt [HandDetection.yuv240torgb] çağrılabilir.
  onLatestImageAvailable(CameraImage cameraImage) async {
    if (cameraImage.format.group == ImageFormatGroup.yuv420) {
      yuv240torgb(cameraImage);
    }
  }

  //Yuv240 image'i rgb değerlere dönüştürüp daha sonra (buffer) listesine kaydeder.
  //Bu metod (buffer) ı hazır hale getirdikten sonra [HandDetection.predict] metodunu çağırır.
  //Uygulamanın bu şekilde daha düzgün çalışıldığı gözlemlendi.
  //(buffer) listesi [HandDetection.predict] de prediction için isolate e yollanır.
  //Bu metodu sadece [HandDetection.onLatestImageAvailable] metodu çağırır.
  //TODO: Burada hazır hale getirilen (buffer)'ın ters mi düz mü olduğu kontrol edilecek.
  //TODO: Ön ve arka kameralar için ayrı iki adet metod olucak.
  void yuv240torgb(CameraImage cameraImage) async {
    int width = cameraImage.width;

    int uvRowStride = cameraImage.planes[1].bytesPerRow;
    int uvPixelStride = cameraImage.planes[1].bytesPerPixel;

    double r, g, b, y, u, v;
    int buffer_index = 0;
    double w = 319;
    while (w > 224) {
      double h = 0;
      while (h < 8) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);
        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }
      while (h < 232) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);
        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h = h + 2;
      }
      while (h < 240) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);
        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }

      w = w - 3;
    }
    while (w > 96) {
      double h = 0;
      while (h < 8) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);
        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }
      while (h < 232) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);
        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h = h + 2;
      }
      while (h < 240) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);
        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }
      w = w - 2;
    }
    while (w > 0) {
      double h = 0;
      while (h < 8) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);
        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }
      while (h < 232) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);
        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h = h + 2;
      }
      while (h < 240) {
        final int uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();

        final int index = (h * width + w).round();

        y = (cameraImage.planes[0].bytes[index]).toDouble();
        u = (cameraImage.planes[1].bytes[uvIndex]).toDouble();
        v = (cameraImage.planes[2].bytes[uvIndex]).toDouble();

        r = (y + v * 1436 / 1024 - 179);
        g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91);
        b = (y + u * 1814 / 1024 - 227);

        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }
      w = w - 3;
    }
    predict();
  }

  //Bu metod'un iki adet parametresi var:
  //(raw_boxes): (outputs[0])
  //(classificator): (outputs[1])
  //Tflite modelinin ham outputunu prediction confidence'a bağlı olarak
  //işleyip (x_center) ve (y_center) değerlerini elde eder. Daha sonra bu değerleri
  //(center_xs) ve (center_ys) listelerinde yerlerine yerleştirir.[HandDetection.detect_xhand] bu listelerdeki
  //değelere göre (x_hand) ve (y_hand) değerlerini bulur. Aynı zamanda (box_area)........
  //TODO: [HandDetection.detect_xhand] ve [HandDetection.decode_boxes] metodları tek bir çatı aldında toplanacak.
  void decode_boxes(List<List<List<dynamic>>> raw_boxes,
      List<List<List<dynamic>>> classificator) {
    //Single shot detector Tflite modeli için kullanılan parametreler.
    int options_num_boxes = 896;
    double options_x_scale = 128.0;
    double options_h_scale = 128.0;
    double options_w_scale = 128.0;

    //Her bir output box için loop atar.
    for (var i = 0; i < options_num_boxes; i++) {
      if (classificator[0][i][0] < detection_threshold) {
        box_areas.add(0);
        continue;
      } else {
        double x_center = raw_boxes[0][i][0];
        double y_center = raw_boxes[0][i][1];
        double w = raw_boxes[0][i][2];
        double h = raw_boxes[0][i][3];

        x_center = (x_center / options_x_scale * 1) + anchors_x[i];
        y_center = (y_center / options_x_scale * 1) + anchors_y[i];

        h = h / (options_h_scale * 1);
        w = w / (options_w_scale * 1);

        center_xs[i] = (x_center);
        center_ys[i] = (y_center);

        double ymin = y_center - (h / 2);
        double xmin = x_center - (w / 2);
        double ymax = y_center + (h / 2);
        double xmax = x_center + (w / 2);

        double box_area = ((ymax - ymin).abs()) * ((xmax - xmin).abs());

        box_areas.add(box_area);
      }
    }
  }
}
