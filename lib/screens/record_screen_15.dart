import 'dart:io';
import 'package:flutter_countdown_timer/index.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:video_app/screens/confirm_screen.dart';
import 'package:video_app/services/gallery_video.dart';
import 'package:video_app/widgets/recrod_border.dart';
import 'package:video_app/widgets/snackBar.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:video_app/constants/global_variables.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../widgets/pop_up_menu.dart';

class RecordScreen15 extends StatefulWidget {
  const RecordScreen15({super.key});

  @override
  State<RecordScreen15> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen15> {
  List<CameraDescription>? cameras;
  static CameraController? cameraController;
  int duration = 15;
  bool _isRecording = false;
  CountDownController controller = CountDownController();

  @override
  void initState() {
    startCamera();

    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();

    super.dispose();
  }

  void startCamera() async {
    cameras = await availableCameras();
    _initCamera(cameras!.first);
  }

  startVideo() async {
    if (!_isRecording) {
      await cameraController!.prepareForVideoRecording();
      await cameraController!.startVideoRecording();
      setState(() {
        _isRecording = true;
        controller.start();
        debugPrint(controller.isStarted.toString());
      });
    }
    // final route = MaterialPageRoute(
    //   fullscreenDialog: true,
    //   builder: (_) => VideoPage(filePath: file.path),
    // );
    // Navigator.push(context, route);
    else {}
  }

  stopRecording() async {
    final file = await cameraController!.stopVideoRecording();
    setState(() {
      _isRecording = false;
      controller.reset();
    });
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConfirmScreen(
                videoFile: File(file.path), videoPath: file.path)));
    await GallerySaver.saveVideo(file.path);
    // File(file.path).deleteSync();
  }

  void _toggleCameraLens() async {
    if (controller.isStarted) {
      await cameraController!.stopVideoRecording();
    }
    setState(() {
      _isRecording = false;
      controller.reset();
    });
    // get current lens direction (front / rear)
    final lensDirection = cameraController!.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = cameras!.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = cameras!.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      _initCamera(newDescription);
    } else {
      print('Asked camera not available');
    }
  }

  Future<void> _initCamera(CameraDescription description) async {
    cameraController =
        CameraController(description, ResolutionPreset.max, enableAudio: true);

    try {
      await cameraController!.initialize();
      // to notify the  that camera has been initialized and now camera preview can be done
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: GlobalVariables.richBlack,
        body: SizedBox(
          height: 1,
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          backgroundColor: GlobalVariables.richBlack,
          body: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CameraPreview(cameraController!),
                ),
              ),
              //gallery
              Positioned(
                bottom: 30,
                left: 20,
                height: 50,
                width: 50,
                child: _isRecording
                    ? SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.transparent,
                          height: 50,
                          width: 50,
                          child: IconButton(
                            onPressed: () async {
                              String gPath = await pickImages();
                              if (gPath == "") {
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmScreen(
                                            videoFile: File(gPath),
                                            videoPath: gPath)));
                              }
                            },
                            icon: Icon(Icons.image),
                            iconSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              // flip button
              Positioned(
                bottom: 30,
                right: 20,
                height: 50,
                width: 50,
                child: _isRecording
                    ? SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.transparent,
                          height: 50,
                          width: 50,
                          child: IconButton(
                            onPressed: () {
                              _toggleCameraLens();
                            },
                            icon: Icon(Icons.flip_camera_android),
                            iconSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              // circular border
              Positioned.fill(
                bottom: 32.5,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularCountDownTimer(
                      onChange: (String t) {
                        print(t);
                      },
                      onComplete: () {},
                      autoStart: false,
                      controller: controller,
                      strokeWidth: 5,
                      backgroundColor: Colors.transparent,
                      width: 65,
                      height: 65,
                      duration: duration,
                      fillColor: GlobalVariables.yoGreen,
                      // fillColor: Gloa,
                      ringColor: controller.isStarted
                          ? Colors.transparent
                          : Colors.white),
                ),
              ),
              // Record Button
              Positioned.fill(
                bottom: 30,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      if (!_isRecording)
                        startVideo();
                      else if (controller.isStarted && !controller.isPaused) {
                        controller.pause();

                        print("${controller.isStarted} started ");
                        print("${controller.isPaused} Paused ");

                        cameraController!.pauseVideoRecording();
                      } else {
                        print("yes inside");
                        controller.resume();
                        cameraController!.resumeVideoRecording();
                        print("${controller.isStarted} started ");
                        print("${controller.isPaused} Paused ");
                      }

                      // if (controller.isStarted && controller.isPaused) {
                      //   controller.resume();
                      // }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              // white border
                              color: Colors.transparent,
                              width: 5,
                              strokeAlign: BorderSide.strokeAlignInside),
                          borderRadius: BorderRadius.circular(50)),
                      child: const DecoratedIcon(
                        decoration: IconDecoration(
                            border: IconBorder(
                                color: Color.fromARGB(0, 174, 145, 145),
                                width: 20)),
                        icon: Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                bottom: 40,
                right: 175,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      child: _isRecording
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  cameraController!.stopVideoRecording();
                                  _isRecording = false;
                                  controller.reset();
                                  setState(() {});
                                });
                              },
                              style: const ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              child: const Text(
                                "Reset",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : const SizedBox(
                              height: 10,
                            )),
                ),
              ),

              Positioned.fill(
                bottom: 40,
                left: 175,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      child: _isRecording
                          ? ElevatedButton(
                              onPressed: () {
                                stopRecording();
                              },
                              style: const ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              child: const Text(
                                "Next",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : const SizedBox(
                              height: 10,
                            )),
                ),
              ),

              Positioned(
                top: 20,
                left: 18,
                bottom: 0,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                        onTap: () {
                          showSnackBar(context, "Recording Cancelled");
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ))),
              ),
              // box
              Positioned(
                right: 20,
                bottom: 125,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 75,
                    width: 45,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.3), // Translucent white background
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // Offset for the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            showPopupMenu(
                                context, details.globalPosition, controller);
                          },
                          child: Icon(
                            Icons.more_time_rounded,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    // return const Scaffold(
    //   body: Text('PFPpa'),
    // );
  }
}
