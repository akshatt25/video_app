import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app/constants/global_variables.dart';
import 'package:video_app/screens/home_screen.dart';
import 'package:video_app/screens/video_screen.dart';
import 'package:video_app/services/upload_controller.dart';

import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  bool isUploading = false;

  UploadController uploadController = Get.put(UploadController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.richBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 25),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: VideoPlayer(controller)),
            ),
            const SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  isUploading = true;
                });
                // File file = File(widget.videoPath);
                await uploadController.uploadVideo(widget.videoPath);
                setState(() {
                  isUploading = false;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  alignment: Alignment.center,
                  width: 250,
                  height: 40,
                  color: GlobalVariables.lBlue,
                  child: const Text(
                    "Share",
                    style: TextStyle(
                        color: GlobalVariables.darkGreen, fontSize: 25),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            newMethod
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  bool get newMethod => isUploading;
}
