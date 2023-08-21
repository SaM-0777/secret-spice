import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:secret_spice/features/camera_preview/actions/classifier/classifier_category.dart';

import '../classifier/classifier_model.dart';


class Classifier {
  final List<String> _labels;
  final ClassifierModel _model;

  Classifier._({
    required List<String> labels,
    required ClassifierModel model,
  })  : _labels = labels,
        _model = model;

  static Future<List<String>> _loadLabels(String labelsFileName) async {
    final String rawText = await rootBundle.loadString(labelsFileName);
    final List<String> rawLebels = rawText.split("/n");

    final List<String> labels = rawLebels.map<String>((label) {
      return label.trim().replaceAll(RegExp(r'\d+'), '').trim();
    }).toList(growable: false);

    return labels;
  }

  static Future<ClassifierModel> _loadModel(String modelFileName) async {
    final Interpreter interpreter = await Interpreter.fromAsset(modelFileName);

    // Input and Output shape from model
    final inputShape = interpreter.getInputTensor(0).shape;
    final outputShape = interpreter.getOutputTensor(0).shape;

    debugPrint('Input shape: $inputShape');
    debugPrint('Output shape: $outputShape');

    // Input shape: [1, 224, 224, 3]
    // Output shape: [1, 15]
    // Input type: float32
    // Output type: float32

    // Input and Output type from model
    final inputType = interpreter.getInputTensor(0).type;
    final outputType = interpreter.getOutputTensor(0).type;

    debugPrint('Input type: $inputType');
    debugPrint('Output type: $outputType');

    return ClassifierModel(
      interpreter: interpreter,
      inputShape: inputShape,
      outputShape: outputShape,
      inputType: inputType,
      outputType: outputType,
    );
  }

  static Future<Classifier?> loadWith({
    required String labelsFileName,
    required String modelFileName,
  }) async {
    try {
      final labels = await _loadLabels(labelsFileName);
      final model = await _loadModel(modelFileName);
      return Classifier._(labels: labels, model: model);
    } catch (e) {
      debugPrint("Can't initialize Classifier: ${e.toString()}");
      if (e is Error) {
        debugPrintStack(stackTrace: e.stackTrace);
      }
      return null;
    }
  }

  Future<Uint8List> _preProcess(XFile image) async {
    Uint8List imageBytes = await image.readAsBytes();
    final Image decodedImage = decodeImage(imageBytes)!;

    // Resize the image to match the input tensor size
    final inputSize = _model.inputShape[1];
    final resizedImage =
        copyResize(decodedImage, width: inputSize, height: inputSize);

    debugPrint("$inputSize");
    debugPrint("$resizedImage");

    // Convert the resized image to a Float32List with normalized pixel values
    final normalizedImage = Float32List(inputSize * inputSize * 3);
    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final Pixel pixel = resizedImage.getPixel(x, y);
        normalizedImage[(y * inputSize + x) * 3 + 0] = pixel.rNormalized.toDouble();
        normalizedImage[(y * inputSize + x) * 3 + 1] = pixel.gNormalized.toDouble();
        normalizedImage[(y * inputSize + x) * 3 + 2] = pixel.bNormalized.toDouble();
      }
    }

    return normalizedImage.buffer.asUint8List();
  }

  void predict(XFile image) async {

    // pre process
    final Uint8List inputBuffer = await _preProcess(image);
    final outputBuffer = List.filled(1 * 15, 0).reshape([1, 15]);

    _model.interpreter.run(inputBuffer, outputBuffer);

    debugPrint("Type: ${outputBuffer.runtimeType}, $outputBuffer");

    // post process
    final List<ClassifierCategory> predictions = _postProcess(outputBuffer);
  }

  List<ClassifierCategory> _postProcess(List<dynamic> outputBuffer) {
    final categoryList = <ClassifierCategory>[];
    
    return categoryList;
  }
}
