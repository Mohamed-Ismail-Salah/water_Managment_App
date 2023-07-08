import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierChemicalOxygenDemand {
  Interpreter? _interpreter;
  ClassifierChemicalOxygenDemand() {
    _loadModel();
  }
  void _loadModel() async {
    _interpreter =
        await Interpreter.fromAsset('modles/waterTreatment/Chemical-Oxygen-Demand.tflite');
    print('Interpreter loaded successfully');
  }

  List<dynamic> classify(List input) {
    var output = List<dynamic>.filled(1, 0).reshape([1, 1]);
    _interpreter?.run(input, output);

    return output[0];
  }
}
