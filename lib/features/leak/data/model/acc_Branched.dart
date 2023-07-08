import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierAccBranched {
  Interpreter? _interpreter;
  ClassifierAccBranched() {
    _loadModel();
  }
  void _loadModel() async {
    _interpreter = await Interpreter.fromAsset(
        'modles/leak/branched/Accelerometer-Branched.tflite');
    print('Interpreter loaded successfully');
  }

  List<dynamic> classify(List input) {
    var output = List<dynamic>.filled(5, 0).reshape([1, 5]);
    _interpreter?.run(input, output);

    return output[0];
  }
}
