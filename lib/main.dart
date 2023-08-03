import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:secret_spice/core/constants/route/route.dart';

import 'package:secret_spice/features/authentication/presentation/screens/authentication_screen.dart';

//import 'package:secret_spice/features/home/presentations/pages/home/home.dart';


List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secret Spices',
      routes: routes,
      theme: ThemeData(
        fontFamily: "Mulish"
      ),
      home: const AutheticationScreen(),
    );
  }
}
