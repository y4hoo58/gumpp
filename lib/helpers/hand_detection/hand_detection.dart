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
  CameraHelper cameraHelper;

  int interpreterAddress;

  List<double> box_areas = [];

  var center_xs = Float32List(896);
  var center_ys = Float32List(896);

  double x_hand = 0.5;
  double y_hand = 0.5;

  double p_weight = 0;
  double prediction_count = 0;
  double max_area = 1;

  bool isLoop;
  bool isFrontCam = AppParams.isFrontCam;

  HandDetection() {
    interpreterAddress = AppParams.interpreterAddress;
  }

  void initialization() async {
    cameraHelper = CameraHelper();
    await isolateUtils.start();
    await startLoop();
  }

  void startLoop() async {
    if (isLoop == null || isLoop == false) {
      isLoop = true;
      if (cameraHelper.cameraController != null) {
        await cameraHelper.startStream();
      }
      mainLoop();
    }
  }

  void stopLoop() async {
    if (isLoop) {
      isLoop = false;
      await cameraHelper.stopStream();
    }
  }

  void mainLoop() async {
    while (isLoop) {
      if (cameraHelper.isNewBuffer == true) {
//        Stopwatch predictWatch = new Stopwatch()..start();

        cameraHelper.isNewBuffer = false;
        if (AppParams.gameState == 0) {
          await predict(cameraHelper.buffer);
        }

//        await Future.delayed(Duration(milliseconds: 10));

//        int pwatch = predictWatch.elapsed.inMicroseconds;
      } else {
        await Future.delayed(Duration(milliseconds: 1));
      }
    }
  }

  void disposeDetectionLoop() async {
    isolateUtils.stop();
    await cameraHelper.disposeCam();
    cameraHelper = null;
  }

  void predict(var buffer) async {
    final isolateData = IsolateData(buffer, interpreterAddress);

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
      if (isFrontCam == true) {
        x_hand = x_weighted / total_weight;
        x_hand = (((x_hand - 0.35) / (0.3)));
        x_hand = x_hand * 0.5;

        y_hand = y_weighted / total_weight;
        y_hand = (y_hand - 0.2) / (0.6);

        p_weight = total_weight / prediction_count;
        this.max_area = max_area * 128 * 128;
      } else if (isFrontCam == false) {
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
