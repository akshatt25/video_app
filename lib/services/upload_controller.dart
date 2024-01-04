import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';
import '../models/video.dart';

//firebase
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

class UploadController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // _getThumbnail(String videoPath) async {
  //   final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
  //   return thumbnail;
  // }

  // Future<String> _uploadImageToStorage(String id, String videoPath) async {
  //   Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
  //   UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
  //   TaskSnapshot snap = await uploadTask;
  //   String downloadUrl = await snap.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // upload video
  uploadVideo(String videoPath) async {
    try {
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      // String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        videoUrl: videoUrl,
        // thumbnail: thumbnail,
      );

      await firestore.collection('videos').doc('Video $len').set(
            video.toJson(),
          );
      Get.back();
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}
