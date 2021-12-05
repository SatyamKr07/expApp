import 'dart:io';

import 'package:commentor/src/models/media_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'my_logger.dart';

class FirebaseStorageService extends GetxController {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_storage.Reference ref;

  Future uploadMediaToFirebaseStorage({
    required List<MediaModel> mediaPath,
    required List<MediaModel> mediaUrlWithTypeToStore,
  }) async {
    for (var media in mediaPath) {
      logger.d("uploadMediaToFirebaseStorage mediaToUpload : ${media.url}");
      String filename = DateTime.now().millisecondsSinceEpoch.toString() +
          Path.basename(media.url);
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('media/$filename');
      // .child('images/${Path.basename(imgPath)}');
      MediaModel downloadedMedia = MediaModel();
      if (media.type == "image") {
        downloadedMedia.type = "image";
      } else {
        downloadedMedia.type = "video";
      }
      await ref.putFile(File(media.url)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          downloadedMedia.url = value;
          mediaUrlWithTypeToStore.add(downloadedMedia);
          logger.d("FirebaseStorage mediaToUploaded : ${media.url}");
        }).onError((error, stackTrace) {
          logger.e('error uploading media');
        });
      });
    }
  }

  Future<String> uploadImageToFirebaseStorage({
    required String imagePath,
  }) async {
    String downloadUrl = "";
    logger.d("uploadImageToFirebaseStorage");
    String filename = DateTime.now().millisecondsSinceEpoch.toString() +
        Path.basename(imagePath);
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/$filename');
    // .child('images/${Path.basename(imgPath)}');
    await ref.putFile(File(imagePath)).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        downloadUrl = value;
        logger.d('download url : $downloadUrl');
      });
    });
    return downloadUrl;
  }
}
