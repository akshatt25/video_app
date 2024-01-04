import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:video_app/screens/home_screen.dart';
import 'dart:ui' as ui;

import 'package:video_app/screens/record_screen_15.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CountDownController controller = CountDownController();

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        home: Scaffold(
          body: Stack(
            children: [
              HomeScreen(),
            ],
          ),
        ));
  }
}
