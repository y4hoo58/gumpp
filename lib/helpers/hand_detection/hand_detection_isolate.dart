import 'dart:isolate';

import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';

class IsolateData {
  var input;
  //ar regressors;
  //var classificators;

  int interpreterAddress;

  SendPort responsePort;

  IsolateData(this.input, this.interpreterAddress);
}

/// Manages separate Isolate instance for inference
class IsolateUtils {
  static const String DEBUG_NAME = "InferenceIsolate";

  Isolate _isolate;
  ReceivePort _receivePort = ReceivePort();
  SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: DEBUG_NAME,
    );

    _sendPort = await _receivePort.first;
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final IsolateData isolateData in port) {
      if (isolateData != null) {
        //Tflite model outputs.
        var classificators = Float32List(1 * 896 * 1).reshape([1, 896, 1]);
        var regressors = Float32List(1 * 896 * 4).reshape([1, 896, 4]);

        Map<int, dynamic> outputs = {0: regressors, 1: classificators};

        final Interpreter _interpreter =
            Interpreter.fromAddress(isolateData.interpreterAddress);

        //TODO: Unutma bunu burada
        await Future.delayed(Duration(milliseconds: 1));

        _interpreter.runForMultipleInputs([isolateData.input.buffer], outputs);

        //TODO: Unutma bunu burada
        await Future.delayed(Duration(milliseconds: 1));
        isolateData.responsePort.send(outputs);
      }
    }
  }
}
