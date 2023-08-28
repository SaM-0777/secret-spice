import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';
import 'package:secret_spice/features/camera_preview/actions/classifier/classifier.dart';
import 'package:secret_spice/features/camera_preview/actions/classifier/classifier_category.dart';

import 'camera_control.dart';
import 'flash_button.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.cameraController,
  });

  final CameraController cameraController;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FlashMode _flashMode = FlashMode.off;
  late Classifier _classifier;
  late ClassifierCategory _prediciton;

  @override
  void initState() {
    super.initState();
    _loadClassifier();
    // Classifier.loadLabels("assets/model/labels.txt");
  }

  Future<void> _loadClassifier() async {
    final classifier = await Classifier.loadWith(
      labelsFileName: "assets/model/labels.txt",
      modelFileName: "assets/model/model_unquant.tflite",
    );

    _classifier = classifier!;
  }

  Future<void> classifyImage(XFile image) async {
    final ClassifierCategory prediction = await _classifier.predict(image);
    debugPrint("Final Prediction : $prediction");
    setState(() {
      _prediciton = prediction;
    });
  }

  void toggleFlash() {
    if (_flashMode == FlashMode.off) {
      widget.cameraController.setFlashMode(FlashMode.torch);
      setState(() {
        _flashMode = FlashMode.torch;
      });
    } else {
      widget.cameraController.setFlashMode(FlashMode.off);
      setState(() {
        _flashMode = FlashMode.off;
      });
    }
  }

  Future<void> onTapTakeImage() async {
    try {
      XFile picture = await widget.cameraController.takePicture();
      await classifyImage(picture);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: CameraPreview(widget.cameraController)
        ),
        SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Secret Spices",
                  style: heading4.copyWith(color: white),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: FlashButton(
                  flashMode: _flashMode,
                  onTap: toggleFlash,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons/ScanIcon.svg",
                  width: min(MediaQuery.of(context).size.width * 0.9, 512),
                  height: min(MediaQuery.of(context).size.width * 0.9, 512),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CameraControl(
                  onTap: onTapTakeImage,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
