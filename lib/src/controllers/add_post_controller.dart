import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/firebase_services.dart';
import 'package:commentor/src/central/services/image_service.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/models/comment_model.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'home_controller.dart';

class AddPostController extends GetxController {
  PostModel postModel = PostModel(
    picList: [],
    category: "*choose category",
    postedBy: UserModel(),
    postedOn: DateTime.now(),
  );

  CommentModel commentModel = CommentModel(
    timestamp: DateTime.now(),
    postedBy: UserModel(),
    postId: '',
  );

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  final imageService = Get.find<ImageService>();
  final firebaseServices = Get.find<FirebaseStorageService>();
  bool isUploading = false;

  final CollectionReference _mainCollection =
      FirebaseFirestore.instance.collection('blogs');

  final userController = Get.find<UserController>();
  final homeController = Get.find<HomeController>();

  List<XFile>? multiImages = [];
  List<String> imagesPath = [];

  TextEditingController commentTextCtrl = TextEditingController();
  final CollectionReference _commentCollection =
      FirebaseFirestore.instance.collection('comments');

  Future pickBlogImageFromGallery() async {
    multiImages = (await imageService.getImagesFromGallery());
    // multiImages!.addAll(await imageService.getImagesFromGallery());
    if (multiImages != null) {
      for (var element in multiImages!) {
        imagesPath.add(element.path);
        // postModel.picList.add(element.path);
      }
      logger.d('exchangeImages ${postModel.picList}');
      update(['ADD_IMAGES_SWIPER']);
    }
  }

  Future clickBlogPhoto() async {
    multiImages!.last = (await imageService.getPhotoFromCamera());
    if (multiImages != null) {
      imagesPath.add(multiImages!.last.path);
      update(['ADD_IMAGES_SWIPER']);
    }
  }

  void selectCategory(String? category) {
    postModel.category = category!;
    update(['CATEGORY_DROPDOWN']);
  }

  Future uploadImages() async {
    try {
      await firebaseServices.uploadImageToFirebaseStorage(
        imagesPath: imagesPath,
        imagesUrlToStore: postModel.picList,
      );
    } catch (e) {
      logger.e('error in uploading images $e');
    } finally {}
  }

  Future postBlog() async {
    feedBlogData();
    if (!validateData()) {
      Get.snackbar("Opps!", "All *marked fields are compusory");
      return;
    }
    isUploading = true;
    update(['ADD_BLOG_PAGE']);
    try {
      await uploadImages();
      _mainCollection
          .add(postModel.toJson())
          .then((docRef) {})
          .catchError((error) {
        logger.e('firestore error $error');
      });
    } catch (e) {
      logger.e(e);
      isUploading = false;
      update(['ADD_BLOG_PAGE']);
    } finally {
      postModel = PostModel(
        picList: [],
        category: "*choose category",
        postedBy: UserModel(),
        postedOn: DateTime.now(),
      );
      isUploading = false;
      // update(['ADD_BLOG_PAGE']);
      Get.back();
      Get.back();
    }
  }

  feedBlogData() {
    postModel.title = titleCtrl.text;
    postModel.description = descCtrl.text;
    postModel.postedBy = userController.appUser;
    postModel.postedOn = DateTime.now();
  }

  validateData() {
    if (postModel.title == "" ||
        postModel.description == "" ||
        imagesPath.isEmpty ||
        postModel.category == "*choose category") {
      return false;
    }
    return true;
  }

  postComment({required String postId}) async {
    commentModel.postedBy = userController.appUser;
    commentModel.commentText = commentTextCtrl.text;
    commentModel.likes = 0;
    commentModel.timestamp = DateTime.now();
    commentModel.postId = postId;
    try {
      _commentCollection.add(commentModel.toJson()).then((docRef) {
        commentModel = CommentModel(
            timestamp: DateTime.now(),
            postedBy: userController.appUser,
            postId: '');
        commentTextCtrl.text = "";
      }).catchError((error) {
        logger.e('firestore error $error');
      });
    } catch (e) {
      logger.e(e);
      // isUploading = false;
      // update(['ADD_BLOG_PAGE']);
    } finally {
      // isUploading = false;
      // // update(['ADD_BLOG_PAGE']);
      // Get.back();
      // Get.back();
      // homeController.changeFilter("All Posts");
    }
  }
}
