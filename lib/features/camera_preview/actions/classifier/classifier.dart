import 'dart:io';

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
    final List<String> rawLebels = rawText.split("\n");

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

  Future<Uint8List> _preProcess(XFile imageInput) async {
    final imageFile = File(imageInput.path);
    //Uint8List imageBytes = await image.readAsBytes();
    final Image decodedImage = decodeImage(imageFile.readAsBytesSync())!;

    // Resize the image to match the input tensor size
    final inputSize = _model.inputShape[1];
    debugPrint("Input Size :  $inputSize");
    final resizedImage = copyResize(decodedImage, width: inputSize, height: inputSize);

    //debugPrint("$inputSize");
    //debugPrint("$resizedImage");

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

  Future<ClassifierCategory> predict(XFile image) async {
    // pre process
    final Uint8List inputBuffer = await _preProcess(image);
    final outputBuffer = List.filled(1 * 15, 0).reshape([1, 15]);

    debugPrint("Input Buffer: $inputBuffer");

    _model.interpreter.run(inputBuffer, outputBuffer);

    // post process
    final List<ClassifierCategory> output = _postProcess(outputBuffer);
    debugPrint("$output");
    return output.last;
  }

  List<ClassifierCategory> _postProcess(List<dynamic> outputBuffer) {
    // outputBuffer : [[0.0001, 0.0002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.010, 0.011, 0.012, 0.13, 0.14, 0.15]]
    final List<double> rawOutput = (outputBuffer.first as List<double>).cast<double>();
    final categoryList = <ClassifierCategory>[];

    for (int i = 0; i < rawOutput.length; i++) {
      categoryList.add(ClassifierCategory(_labels[i], rawOutput[i]));
    }

    categoryList.sort((a, b) {
      return b.score.compareTo(a.score);
    });

    return categoryList;
  }
}
