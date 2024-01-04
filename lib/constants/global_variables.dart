import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static const richBlack = Color.fromARGB(255, 0, 16, 17);
  static const darkGreen = Color.fromARGB(255, 9, 58, 62);
  static const yoGreen = Color.fromARGB(
    255,
    58,
    175,
    185,
  );
  static const blue = Color.fromARGB(255, 100, 233, 238);
  static const lBlue = Color.fromARGB(255, 151, 200, 235);

  static const grad = LinearGradient(colors: [
    Color.fromARGB(255, 9, 58, 62),
    Color.fromARGB(
      255,
      58,
      175,
      185,
    ),
  ], stops: [
    0.5,
    1.0
  ]);
}
