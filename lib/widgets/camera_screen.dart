import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:gumpp/helpers/hand_detection/camera_helper.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State {
  @override
  void initState() {
    super.initState();
    initController();
  }

  double scale = 1;
  bool isInit = false;

  void initController() async {
    while (1 > 0) {
      if (CameraHelper.cameraController == null) {
        await Future.delayed(const Duration(microseconds: 1000));
      } else {
        try {
          if (CameraHelper.cameraController.hasListeners == false) {
            CameraHelper.cameraController.addListener(() {
              if (mounted) {
                setState(() {});
                isInit = true;
              }
            });
          }
        } on Exception {}
        await Future.delayed(const Duration(microseconds: 1000));
      }

      if (isInit == true) {
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //return Container();
    return IgnorePointer(
      child: Opacity(
        opacity: 0.2,
        child: Container(
          child: isInit == true ? _cameraPreviewWidget(context) : Container(),
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget(context) {
    final size = MediaQuery.of(context).size;

    var scale = size.aspectRatio * (320 / 240);
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(CameraHelper.cameraController),
      ),
    );
  }
}
