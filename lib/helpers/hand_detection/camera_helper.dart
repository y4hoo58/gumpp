// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:torch_light/torch_light.dart';
import 'package:gumpp/app_params.dart';

class CameraHelper {
  static CameraController cameraController;
  List<CameraDescription> cameras;

  bool isFrontCam = AppParams.isFrontCam;

  bool isNewBuffer = false;
  bool isCamContWorking;
  bool isStreaming;

  double pixelAverage = 0;

  final buffer = Float32List.view(Float32List(1 * 128 * 128 * 3).buffer);
  CameraHelper() {
    cameraController = null;
  }

  Future<void> initCamHelper() async {
    await initCam();
  }

  Future<void> initCam() async {
    cameras = await availableCameras();

    List<int> cam_indexes = [];

    for (var i = 0; i < cameras.length; i++) {
      if (isFrontCam == true) {
        if (cameras[i].lensDirection == CameraLensDirection.front) {
          cam_indexes.add(i);
        }
      } else if (isFrontCam == false) {
        if (cameras[i].lensDirection == CameraLensDirection.back) {
          cam_indexes.add(i);
        }
      }
    }

    //TODO :
    // 1-) Kamera seçme işlemi hangi kamera daha geniş alanı kapsıyorsa ona göre yapılmalı.
    // 2-) Exception durumu iyi ayarlanmalı.
    try {
      cameraController = CameraController(
          cameras[cam_indexes[1]], ResolutionPreset.low,
          enableAudio: false, imageFormatGroup: ImageFormatGroup.yuv420);
    } on Exception {
      cameraController = CameraController(
          cameras[cam_indexes[0]], ResolutionPreset.low,
          enableAudio: false, imageFormatGroup: ImageFormatGroup.yuv420);
    }

    isCamContWorking = true;
  }

  onLatestImageAvailable(CameraImage cameraImage) async {
    if (cameraImage.format.group == ImageFormatGroup.yuv420) {
      await yuv240torgb(cameraImage);
    }
  }

  //TODO:
  // 1-) Fonksiyonun içerisinde gerçekleştirilen işlemlerin sırası ayarlanacak.
  // 2-) Debugging de bir sıkıntılar dan bahsediyor ama ??
  Future<void> startStream() async {
    if (isStreaming == false || isStreaming == null) {
      isStreaming = true;

      while (1 > 0) {
        if (cameraController != null) {
          try {
            await cameraController.initialize().then((_) async {
              await cameraController.startImageStream(onLatestImageAvailable);
            });

            break;
          } on Exception {}
        } else {
          await Future.delayed(Duration(milliseconds: 1));
        }
      }

      try {
        cameraController.setZoomLevel(await cameraController.getMinZoomLevel());
        cameraController.setFocusMode(FocusMode.auto);
        cameraController.lockCaptureOrientation();
      } on Exception {
        //TODO: ...
      }

      if (isFrontCam == false) {
        try {
          if (AppParams.flashMode == 1) {
            await TorchLight.enableTorch();
            AppParams.isFlashOn = true;
          }
        } on Exception catch (_) {}
      }
    }
  }

  Future<void> disposeCam() async {
    if (isCamContWorking == true) {
      isCamContWorking = false;

      await cameraController.dispose();
      cameraController = null;

      if (isFrontCam == false) {
        try {
          await TorchLight.disableTorch();
          AppParams.isFlashOn = false;
        } on Exception catch (_) {}
      }
    }
  }

  void yuv240torgb(CameraImage cameraImage) async {
    isNewBuffer = false;
    final int width = cameraImage.width;
    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int uvPixelStride = cameraImage.planes[1].bytesPerPixel;

    double pixelTotal = 0;
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

        pixelTotal = pixelTotal + (r + g + b);
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

        pixelTotal = pixelTotal + (r + g + b);

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

        pixelTotal = pixelTotal + (r + g + b);

        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }

      w = w - 3;
    }
    await Future.delayed(const Duration(microseconds: 100));
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

        pixelTotal = pixelTotal + (r + g + b);

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

        pixelTotal = pixelTotal + (r + g + b);

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

        pixelTotal = pixelTotal + (r + g + b);

        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }
      w = w - 2;
    }
    await Future.delayed(const Duration(microseconds: 100));
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

        pixelTotal = pixelTotal + (r + g + b);

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

        pixelTotal = pixelTotal + (r + g + b);

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

        pixelTotal = pixelTotal + (r + g + b);

        buffer[49151 - buffer_index++] = 2 * (b / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (g / 255) - 1;
        buffer[49151 - buffer_index++] = 2 * (r / 255) - 1;
        h++;
      }
      w = w - 3;
    }
    pixelAverage = pixelTotal / (128 * 128 * 3);
    await Future.delayed(const Duration(microseconds: 100));

    isNewBuffer = true;
  }
}
