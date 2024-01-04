import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app/constants/global_variables.dart';
import 'package:video_app/screens/record_screen_15.dart';
import 'package:video_app/controller/video_controller.dart';

import '../widgets/video_player_iten.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: GlobalVariables.richBlack,
        body: Obx(() {
          return Stack(
            children: [
              PageView.builder(
                itemCount: videoController.videoList.length,
                controller: PageController(initialPage: 0, viewportFraction: 1),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final data = videoController.videoList[index];
                  return VideoPlayerItem(
                    videoUrl: data.videoUrl,
                  );
                },
              ),
              Positioned(
                  top: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecordScreen15(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'icons/camera.png',
                      height: 30,
                      width: 30,
                    ),
                  ))
            ],
          );
        }),
      ),
    );
  }
}
