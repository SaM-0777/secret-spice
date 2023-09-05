import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secret_spice/core/actions/show_bottom_action_sheet.dart';
import 'package:secret_spice/core/constants/recipes/recipes.dart';

import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';
import 'package:secret_spice/core/db/models/recipe_model.dart';
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
  late XFile _picture;
  RecipeModel? _predictedRecipe;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    final classifier = await Classifier.loadWith(
      labelsFileName: "assets/model/labels.txt",
      modelFileName: "assets/model/model.tflite",
    );
    _classifier = classifier!;
  }

  Future<RecipeModel> classifyImage(XFile image) async {
    final ClassifierCategory prediction = await _classifier.predict(image);
    debugPrint("Final Prediction : $prediction");
    RecipeModel predictedRecipe = recipes.firstWhere((recipe) => recipe.name == prediction.label);
    return predictedRecipe;
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

  void showBottomActionSheet(RecipeModel recipe) {
    ShowBottomActionSheet showBottomActionSheet = ShowBottomActionSheet(context: context);
    showBottomActionSheet.showBottomActionSheet(recipe, () {
      setState(() {
        _predictedRecipe = null;
      });
    });
  }

  void toggleLoading([bool? loading]) {
    setState(() {
      _loading = loading ?? !_loading;
    });
  }

  Future<void> onTapTakeImage() async {
    try {
      toggleLoading(true);
      XFile picture = await widget.cameraController.takePicture();
      RecipeModel predictedRecipe = await classifyImage(picture);
      setState(() {
        _picture = picture;
        _predictedRecipe = predictedRecipe;
      });
      showBottomActionSheet(predictedRecipe);
    } catch (e) {
      debugPrint("Error taking image: $e");
    }
    toggleLoading(false);
  }

  Future<void> onTapPickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    toggleLoading(true);
    try {
      final XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final RecipeModel predictedRecipe = await classifyImage(pickedImage);
        setState(() {
          _picture = pickedImage;
          _predictedRecipe = predictedRecipe;
        });
        showBottomActionSheet(predictedRecipe);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
    toggleLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _predictedRecipe != null
      ? SizedBox(
        height: double.maxFinite,
        width: double.maxFinite, 
        child: Image.file(
          File(_picture.path),
          fit: BoxFit.fill,
          width: double.maxFinite,
          height: double.maxFinite,
        )
      )
      : Stack(children: <Widget>[
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
                  isDisabled: _loading,
                  onTap: onTapTakeImage,
                  onTapPickImage: onTapPickImage,
                  //isDisabled: !_loading,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
