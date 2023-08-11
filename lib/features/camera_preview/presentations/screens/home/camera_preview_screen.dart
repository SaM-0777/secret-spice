import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:secret_spice/core/constants/theme/colors.dart';
import 'package:secret_spice/core/constants/theme/typography.dart';

import 'package:secret_spice/main.dart';

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreen();
}

class _CameraPreviewScreen extends State<CameraPreviewScreen> {
  late CameraController cameraController;
  late XFile image;
  FlashMode _flashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            SystemNavigator.pop();
            break;
          default:
            // show error modal
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Scaffold(
        backgroundColor: white,
        body: const Center(),
      );
    }
    return Scaffold(
      body: Stack(children: <Widget>[
        SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: CameraPreview(cameraController)),
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
                child: GestureDetector(
                    onTap: () {
                      if (_flashMode == FlashMode.off) {
                        cameraController.setFlashMode(FlashMode.torch);
                        setState(() {
                          _flashMode = FlashMode.torch;
                        });
                      } else {
                        cameraController.setFlashMode(FlashMode.off);
                        setState(() {
                          _flashMode = FlashMode.off;
                        });
                      }
                    },
                    child: _flashMode == FlashMode.off
                        ? SvgPicture.asset(
                            "assets/icons/FlashOnIcon.svg",
                            width: 24,
                            height: 24,
                          )
                        : SvgPicture.asset(
                            "assets/icons/FlashOffIcon.svg",
                            width: 24,
                            height: 24,
                          )),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: neutral900.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Tap the shutter button to search",
                        style: body1.copyWith(color: white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            try {
                              setState(() async {
                                image = await cameraController.takePicture();
                              });
                              if (kDebugMode) {
                                print(image.path);
                              }
                            } catch (e) {}
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                width: 1,
                                color: white,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/SearchIcon.svg",
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 1, color: white),
                              top: BorderSide(width: 1, color: white),
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
