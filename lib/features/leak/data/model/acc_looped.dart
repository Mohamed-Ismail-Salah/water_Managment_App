import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierAccLooped {
  Interpreter? _interpreter;
  ClassifierAccLooped() {
    _loadModel();
  }
  void _loadModel() async {
    _interpreter = await Interpreter.fromAsset(
        'modles/leak/looped/waterleak-acc-looped-cnn.tflite');
    print('Interpreter loaded successfully');
  }

  List<dynamic> classify(List input) {
    var output = List<dynamic>.filled(5, 0).reshape([1, 5]);
    _interpreter?.run(input, output);

    return output[0];
  }
}
