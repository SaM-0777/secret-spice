import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:secret_spice/main.dart';

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreen();
}

class _CameraPreviewScreen extends State<CameraPreviewScreen> {
  late CameraController cameraController;

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
      return const Scaffold(
        //backgroundColor: kBackground,
      );
    }
    return Scaffold(
      //backgroundColor: kBackground,
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CameraPreview(cameraController)
          )
        ]
      ),
    );
  }
}
