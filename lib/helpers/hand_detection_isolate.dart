import 'dart:isolate';

import 'package:tflite_flutter/tflite_flutter.dart';

class IsolateData {
  var input;
  var regressors;
  var classificators;

  int interpreterAddress;

  SendPort responsePort;

  IsolateData(this.input, this.interpreterAddress, this.regressors,
      this.classificators);
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
        Map<int, dynamic> outputs = {
          0: isolateData.regressors,
          1: isolateData.classificators
        };

        Interpreter _interpreter =
            Interpreter.fromAddress(isolateData.interpreterAddress);

        _interpreter.runForMultipleInputs([isolateData.input.buffer], outputs);

        isolateData.responsePort.send(outputs);
      }
    }
  }
}
