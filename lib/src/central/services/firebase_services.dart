import 'dart:io';

import 'package:commentor/src/models/media_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class FirebaseStorageService extends GetxController {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_storage.Reference ref;

  Future uploadImageToFirebaseStorage({
    required List<MediaModel> mediaPath,
    required List<MediaModel> mediaUrlWithTypeToStore,
  }) async {
    for (var media in mediaPath) {
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
        });
      });
    }
  }
  //  Future uploadImageToFirebaseStorage({
  //   required List<String> imagesPath,
  //   required List<String> imagesUrlToStore,
  // }) async {
  //   for (var imgPath in imagesPath) {
  //     String filename = DateTime.now().millisecondsSinceEpoch.toString() +
  //         Path.basename(imgPath);
  //     ref = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('images/$filename');
  //     // .child('images/${Path.basename(imgPath)}');
  //     await ref.putFile(File(imgPath)).whenComplete(() async {
  //       await ref.getDownloadURL().then((value) {
  //         imagesUrlToStore.add(value);
  //       });
  //     });
  //   }
  // }
}
