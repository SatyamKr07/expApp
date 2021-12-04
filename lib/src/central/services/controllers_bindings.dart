import 'package:commentor/src/central/services/image_service.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:commentor/src/controllers/home_controller.dart';
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
  }
}
