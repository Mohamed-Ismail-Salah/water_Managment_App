import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierWater2 {
  Interpreter? _interpreter;

  ClassifierWater2() {
    _loadModel();
  }

  void _loadModel() async {
    _interpreter = await Interpreter.fromAsset(
        'assets/modles/waterQuality/waterQ2.tflite');
    print('Interpreter loaded successfully');
  }

  List<dynamic> classify(List input) {
    var output = List<dynamic>.filled(1, 0).reshape([1, 1]);
    _interpreter?.run(input, output);

    return output[0];
  }
}
