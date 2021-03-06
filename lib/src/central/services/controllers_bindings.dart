import 'package:flutter/material.dart';

import 'image_service.dart';
import '../../controllers/edit_profile_controller.dart';
import '../../controllers/story_controller.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/add_post_controller.dart';
import '../../controllers/home_controller.dart';
import 'package:get/instance_manager.dart';

import 'firebase_services.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
    Get.lazyPut<AddPostController>(() => AddPostController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ImageService>(() => ImageService(), fenix: true);
    Get.lazyPut<FirebaseStorageService>(() => FirebaseStorageService(),
        fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(),
        fenix: true);
    Get.lazyPut<DisplayStoryController>(() => DisplayStoryController(),
        fenix: true);
  }
}


