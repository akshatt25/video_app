import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String videoUrl;
  // String thumbnail;

  Video({
    required this.videoUrl,
    // required this.thumbnail,
  });

  Map<String, dynamic> toJson() => {
        "videoUrl": videoUrl,
        // "thumbnail": thumbnail,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      videoUrl: snapshot['videoUrl'],
      // thumbnail: snapshot['thumbnail'],
    );
  }
}
