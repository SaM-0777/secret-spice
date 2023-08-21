import 'package:flutter/material.dart';

import 'package:secret_spice/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:secret_spice/features/camera_preview/presentations/screens/camera_preview_screen.dart';
import 'package:secret_spice/features/register/presentation/screens/register_screen.dart';
import 'package:secret_spice/features/recommendation/presentation/screens/recommendation_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/authentication": (context) => const AutheticationScreen(),
  "/register": (context) => const RegisterScreen(),
  "/recommendation": (context) => const RecommendationScreen(),
  "/camera-preview": (context) => const CameraPreviewScreen(),
};
