import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:secret_spice/core/constants/colors.dart';
import 'package:secret_spice/features/home/presentations/widgets/appbar.dart';
import 'package:secret_spice/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      return Scaffold(
        appBar: buildAppbar(),
        backgroundColor: kBackground,
      );
    }
    return Scaffold(
      appBar: buildAppbar(),
      backgroundColor: kBackground,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: CameraPreview(cameraController)
          )
        ]
      ),
    );
  }
}
