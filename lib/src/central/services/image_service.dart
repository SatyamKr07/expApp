import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import 'my_logger.dart';

class ImageService extends GetxController {
  //Image Service
  final _picker = ImagePicker();

  Future getPhotoFromCamera({bool allowCrop = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        if (!allowCrop) {
          return pickedFile;
        }
        // File? croppedFile = await ImageCropper.cropImage(
        //     sourcePath: pickedFile.path,
        //     compressQuality: 5,
        //     compressFormat: ImageCompressFormat.png,
        //     maxWidth: 700,
        //     maxHeight: 700,
        //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        //     androidUiSettings: const AndroidUiSettings(
        //         toolbarTitle: 'Cropper',
        //         toolbarColor: Colors.deepOrange,
        //         toolbarWidgetColor: Colors.white,
        //         initAspectRatio: CropAspectRatioPreset.original,
        //         lockAspectRatio: true),
        //     iosUiSettings: const IOSUiSettings(
        //       title: 'Crop Image (4:3)',
        //     ));

        // if (croppedFile != null) {
        //   return croppedFile as XFile;
        // }
      } else {
        return;
      }
    } catch (e) {
      logger.e('getImageFromCamera error: ${e.toString()}');
    }
  }

  Future getImagesFromGallery() async {
    final List<XFile>? galleryImagesList = await _picker.pickMultiImage(
      imageQuality: 50,
    );
    if (galleryImagesList != null) {
      return galleryImagesList;
    }
  }

  Future pickSingleImageFromGallery() async {
    final XFile? singleImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (singleImage != null) {
      return singleImage;
    }
  }

  Future getVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 5),
    );
    if (video != null) {
      // try {
      //   MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      //     video.path,
      //     quality: VideoQuality.MediumQuality,
      //     includeAudio: true,
      //     deleteOrigin: true, // It's false by default
      //   );
      // } catch (e) {
      //   logger.e('compression error $e');
      //   VideoCompress.cancelCompression();
      // }
      return video;
    }
  }
}
