import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
}
