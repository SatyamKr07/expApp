import 'package:cloud_firestore/cloud_firestore.dart';
import '../central/services/firebase_services.dart';
import '../central/services/image_service.dart';
import '../central/services/my_logger.dart';
import 'user_controller.dart';
import '../models/comment_model.dart';
import '../models/media_model.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';
import '../pages/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'home_controller.dart';

class AddPostController extends GetxController {
  PostModel postModel = PostModel(
    likesArray: [],
    mediaList: [],
    postedOn: DateTime.now(),
  );

  CommentModel commentModel = CommentModel(
    timestamp: DateTime.now(),
    postedBy: UserModel(followersList: [], followingList: [], storiesList: []),
    postId: '',
  );

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  final imageService = Get.find<ImageService>();
  final firebaseServices = Get.find<FirebaseStorageService>();
  bool isUploading = false;

  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final userController = Get.find<UserController>();
  final homeController = Get.find<HomeController>();

  List<XFile>? multiImages = [];
  List<String> imagesPath = [];
  List<MediaModel> mediaList = [];

  TextEditingController commentTextCtrl = TextEditingController();
  TextEditingController tag1TextCtrl = TextEditingController();
  TextEditingController tag2TextCtrl = TextEditingController();
  TextEditingController tag3TextCtrl = TextEditingController();
  final CollectionReference _commentCollection =
      FirebaseFirestore.instance.collection('comments');

  Future pickImageFromGallery() async {
    List<XFile> multiImages = await imageService.getImagesFromGallery();
    // List multiImages = await myUtils.pickMultiImages();
    // images.addAll(multiImages);
    for (var element in multiImages) {
      MediaModel media = MediaModel()..url = element.path;
      mediaList.add(media);
    }

    // exchangeModel.post!.mediaList.addAll(iterable)
    logger.d('pickedImages');
    update(['ADD_IMAGES_SWIPER']);
  }

  // Future clickBlogPhoto() async {
  //   multiImages!.last = (await imageService.getPhotoFromCamera());
  //   if (multiImages != null) {
  //     imagesPath.add(multiImages!.last.path);
  //     update(['ADD_IMAGES_SWIPER']);
  //   }
  // }

  Future pickVideoFromGallery() async {
    final XFile? video = await imageService.getVideoFromGallery();

    if (video != null) {
      MediaModel videoMedia = MediaModel()
        ..type = "video"
        ..url = video.path;
      // images.add(video);
      mediaList.add(videoMedia);
      update(['ADD_IMAGES_SWIPER']);
    }
  }

  Future uploadImages() async {
    try {
      await firebaseServices.uploadMediaToFirebaseStorage(
          mediaPath: mediaList, mediaUrlWithTypeToStore: postModel.mediaList);
    } catch (e) {
      logger.e('error in uploading images $e');
    } finally {}
  }

  Future uploadPost() async {
    feedPostData();
    if (!validateData()) {
      Get.snackbar("Opps!", "All *marked fields are compusory");
      return;
    }
    isUploading = true;
    update(['ADD_POST_PAGE']);
    try {
      await uploadImages();
      await _postsCollection
          .add(postModel.toJson())
          .then((docRef) {})
          .catchError((error) {
        logger.e('firestore error $error');
      });
      isUploading = false;
      update(['ADD_POST_PAGE']);
      homeController.changePage(index: 0);
      mediaList = [];
      descCtrl.text = "";
    } catch (e) {
      logger.e(e);
      isUploading = false;
      update(['ADD_POST_PAGE']);
    } finally {
      postModel = PostModel(
        postedOn: DateTime.now(),
        mediaList: [],
        likesArray: [],
      );
      isUploading = false;
      update(['ADD_POST_PAGE']);
      // Get.back();
      // Get.back();
    }
  }

  feedPostData() {
    postModel.uploaderId = userController.appUser.id;
    postModel.uploaderName = userController.appUser.displayName;
    postModel.uploaderPic = userController.appUser.profilePic;
    postModel.description = descCtrl.text;
    postModel.postedOn = DateTime.now();
  }

  validateData() {
    if (postModel.description == "" || mediaList.isEmpty) {
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
      _commentCollection
          .add(commentModel.toJson())
          .then((docRef) {
            _postsCollection
                .doc(postId)
                .update({"commentsCount": postModel.commentsCount += 1});
            commentModel = CommentModel(
                timestamp: DateTime.now(),
                postedBy: userController.appUser,
                postId: '',
                commentId: '');
            commentTextCtrl.text = "";
          })
          .then((value) => {
                userController.appUser.totalCommentsCount += 1,
                _usersCollection.doc(userController.appUser.id).update({
                  "totalCommentsCount":
                      userController.appUser.totalCommentsCount
                })
              })
          .catchError((error) {
            logger.e('firestore error $error');
          });
    } catch (e) {
      logger.e(e);
      // isUploading = false;
      // update(['ADD_POST_PAGE']);
    } finally {
      // isUploading = false;
      // // update(['ADD_POST_PAGE']);
      // Get.back();
      // Get.back();
      // homeController.changeFilter("All Posts");
    }
  }

  updatePost({required String docId}) async {
    isUploading = true;
    update(['ADD_POST_PAGE']);
    await _postsCollection.doc(docId).update({
      "description": descCtrl.text,
    }).then((docRef) {
      logger.d("updated successfully");
      isUploading = false;
      update(['ADD_POST_PAGE']);
      Get.back();
      Get.back();
    }).catchError((error) {
      logger.e('firestore error $error');
    });
  }
}
