import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'classifier.dart';

class ClassifierMeter extends Classifier {
  ClassifierMeter({int? numThreads}) : super(numThreads: numThreads);

  @override
  String get modelName => 'modles/waterMeters/meter.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(28, 28);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
}
