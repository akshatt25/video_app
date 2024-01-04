import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<String> pickImages() async {
  String videoPath = "";
  try {
    var file = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );
    if (file != null) {
      videoPath = file.files[0].path!;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return videoPath;
}
