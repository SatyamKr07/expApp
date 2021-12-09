import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/image_service.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/media_model.dart';
import 'package:commentor/src/models/story_model.dart';
import 'package:get/get.dart';
import 'package:commentor/src/central/services/firebase_services.dart';
import 'package:image_picker/image_picker.dart';

class DisplayStoryController extends GetxController {
  //get all users list for stories
  List usersList = [];
  Stream<QuerySnapshot> filterUser(emailQuery) {
    // logger.d('category $category');
    // filterCategory = category!;
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   update(['FILTER_CATEGORY_DROPDOWN', 'ALL_POSTS']);
    // });

    logger.d('fetching stories');
    return FirebaseFirestore.instance
        .collection("users")
        .where("id", whereIn: userController.appUser.followingList)
        .where(
      "storiesList",
      isNotEqualTo: [],
    ).snapshots();
  }

  bool isUploading = false;
  List<dynamic> storiesList = [];
  List<String> storyImgPaths = [];
  List<MediaModel> mediaList = [];
  final imageService = Get.find<ImageService>();
  final firebaseServices = Get.find<FirebaseStorageService>();

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final userController = Get.find<UserController>();
  bool isDeleting = false;
  Future pickStory() async {
    List<XFile> multiImages = await imageService.getImagesFromGallery();
    // List multiImages = await myUtils.pickMultiImages();
    // images.addAll(multiImages);
    for (var element in multiImages) {
      MediaModel media = MediaModel()..url = element.path;
      mediaList.add(media);
      storyImgPaths.add(element.path);
    }

    // exchangeModel.post!.mediaList.addAll(iterable)
    logger.d('pickedImages');
    update(['ADD_IMAGES_SWIPER']);
  }

  Future uploadStories() async {
    isUploading = true;
    update(['ADD_STORY_PAGE']);

    try {
      for (var imgPath in storyImgPaths) {
        String downloadUrl = await firebaseServices
            .uploadImageToFirebaseStorage(imagePath: imgPath);
        StoryModel storyModel = StoryModel(imageUrl: downloadUrl);
        storiesList.add(storyModel.toJson());
      }
      await _usersCollection
          .doc(userController.appUser.id)
          .update({"storiesList": storiesList})
          .then((docRef) {})
          .catchError((error) {
            logger.e('firestore error $error');
          });
    } catch (e) {
      logger.e(e);
      isUploading = false;
      update(['ADD_STORY_PAGE']);
    } finally {
      storiesList = [];
      mediaList = [];
      // postModel = PostModel(
      //   postedOn: DateTime.now(),
      //   mediaList: [],
      //   likesArray: [],
      // );
      isUploading = false;
      update(['ADD_STORY_PAGE']);
      Get.back();
      Get.back();
    }
  }

  deleteStory({required StoryModel storyModel}) async {
    isDeleting = true;
    update(['DELETE_STORY']);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userController.appUser.id)
        .update({
      "storiesList": FieldValue.arrayRemove([storyModel.toJson()])
    }).then((value) {
      isDeleting = false;
      update(['DELETE_STORY']);
    }).onError((error, stackTrace) {
      logger.e("error deleting story $error");
    });
  }
}
