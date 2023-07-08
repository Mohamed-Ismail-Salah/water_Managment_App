import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierEnergyConsumption {
  Interpreter? _interpreter;
  ClassifierEnergyConsumption() {
    _loadModel();
  }
  void _loadModel() async {
    _interpreter =
        await Interpreter.fromAsset('modles/waterTreatment/Energy-Consumption.tflite');
    print('Interpreter loaded successfully');
  }

  List<dynamic> classify(List input) {
    var output = List<dynamic>.filled(1, 0).reshape([1, 1]);
    _interpreter?.run(input, output);

    return output[0];
  }
}
