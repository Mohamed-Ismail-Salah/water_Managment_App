import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  Interpreter? _interpreter;
  Classifier() {
    _loadModel();
  }
  void _loadModel() async {
    _interpreter =
        await Interpreter.fromAsset('modles/rain/conv1d (rain 2).tflite');
    print('Interpreter loaded successfully');
  }

  List<dynamic> classify(List input) {
    var output = List<dynamic>.filled(1, 0).reshape([1, 1]);
    _interpreter?.run(input, output);

    return output[0];
  }
}
