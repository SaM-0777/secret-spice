import 'package:flutter/material.dart';

import 'package:secret_spice/features/authentication/presentation/screens/authentication_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/authentication": (context) => const AutheticationScreen(),
};
