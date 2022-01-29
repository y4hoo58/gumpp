// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'dart:typed_data';
import 'dart:isolate';
import 'dart:async';

//import 'package:torch_light/torch_light.dart';

import 'package:gumpp/helpers/hand_detection/camera_helper.dart';
import 'package:gumpp/helpers/hand_detection/hand_detection_isolate.dart';
import 'package:gumpp/helpers/hand_detection/hand_det_const.dart';
import 'package:gumpp/app_params.dart';

class HandDetection {
  IsolateUtils isolateUtils = IsolateUtils();
  CameraHelper cameraHelper = CameraHelper();

  List<double> box_areas = [];

  var center_xs = Float32List(896);
  var center_ys = Float32List(896);

  double x_hand = 0.5;
  double y_hand = 0.5;

  double p_weight = 0;
  double prediction_count = 0;
  double max_area = 1;

  Future<void> initialization() async {
    await cameraHelper.initCamHelper();
    await isolateUtils.start();
    await startCamStream();
    mainLoop();
  }

  /* 
    cameraController null olduğu süre boyunca devamlı döngü atar.
    null olmayı bırakıp bir değer aldığı zaman stream'i başlatır ve döngüden çıkar.
  */
  Future<void> startCamStream() async {
    while (1 > 0) {
      if (CameraHelper.cameraController != null) {
        await cameraHelper.startStream();

        break;
      } else {
        Future.delayed(const Duration(milliseconds: 1));
      }
    }
  }

  /* 
    Bir kere çalıştırıldıktan sonra bir daha durmaz.
    Eğer gamestate 0 ise oyun oynanıyodur ve bu loop sürekli döner.
    Eğer gamestate 0 değilse bekleme moduna alır ve her 100ms de bir 
    döngü döner. 
    Asla durmaz!!
  */
  void mainLoop() async {
    while (1 > 0) {
      if (AppParams.gameState == 0) {
        if (cameraHelper.isNewBuffer) {
          cameraHelper.isNewBuffer = false;
          await predict(cameraHelper.buffer);
        } else {
          await Future.delayed(const Duration(milliseconds: 1));
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  /* 
    isolate'i durdur.
    Kamerayı kapat.
    Daha sonra cameraHelper'ı null yap.
    cameraController'ı static olduğu için null yap. camerahelper'ı silince
    null a dönmüyor çünkü.
  */
  Future<void> disposeDetectionLoop() async {
    isolateUtils.stop();
    await cameraHelper.disposeCam();
    //CameraHelper.cameraController = null;
    //cameraHelper = null;
  }

  Future<void> predict(var buffer) async {
    final isolateData = IsolateData(buffer, AppParams.interpreterAddress);

    Map<int, dynamic> outputs = await inference(isolateData);

    decode_boxes(outputs[0], outputs[1]);
    detect_xhand(outputs[1]);
  }

  Future<Map<int, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils.sendPort
        .send(isolateData..responsePort = responsePort.sendPort);

    final results = await responsePort.first;
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
      if (classificator[0][i][0] > HDetConst.detection_threshold) {
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

    //AppParams.isHandOnImage = false;
    if (x_weighted != 0 && total_weight != 0) {
      //AppParams.isHandOnImage = true;
      if (AppParams.isFrontCam == true) {
        x_hand = x_weighted / total_weight;
        x_hand = (((x_hand - 0.35) / (0.3)));
        x_hand = x_hand * 0.5;

        y_hand = y_weighted / total_weight;
        y_hand = (y_hand - 0.2) / (0.6);

        p_weight = total_weight / prediction_count;
        this.max_area = max_area * 128 * 128;
      } else if (AppParams.isFrontCam == false) {
        x_hand = x_weighted / total_weight;
        x_hand = (((x_hand - 0.35) / (0.3)));

        y_hand = y_weighted / total_weight;
        y_hand = (1 - y_hand).abs();
        y_hand = (y_hand - 0.2) / (0.6);
        p_weight = total_weight / prediction_count;
        this.max_area = max_area * 128 * 128;
      }
      box_areas = [];
    } else {
      p_weight = 0;
    }
  }

  void decode_boxes(List<List<List<dynamic>>> raw_boxes,
      List<List<List<dynamic>>> classificator) {
    for (var i = 0; i < HDetConst.options_num_boxes; i++) {
      if (classificator[0][i][0] < HDetConst.detection_threshold) {
        box_areas.add(0);
        continue;
      } else {
        double x_center = raw_boxes[0][i][0];
        double y_center = raw_boxes[0][i][1];
        double w = raw_boxes[0][i][2];
        double h = raw_boxes[0][i][3];

        x_center =
            (x_center / HDetConst.options_x_scale * 1) + HDetConst.anchorsX[i];
        y_center =
            (y_center / HDetConst.options_x_scale * 1) + HDetConst.anchorsY[i];

        h = h / (HDetConst.options_h_scale * 1);
        w = w / (HDetConst.options_w_scale * 1);

        center_xs[i] = (x_center);
        center_ys[i] = (y_center);

        final double ymin = y_center - (h / 2);
        final double xmin = x_center - (w / 2);
        final double ymax = y_center + (h / 2);
        final double xmax = x_center + (w / 2);

        final double box_area = ((ymax - ymin).abs()) * ((xmax - xmin).abs());

        box_areas.add(box_area);
      }
    }
  }
}
