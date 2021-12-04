import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/firebase_services.dart';
import 'package:commentor/src/central/services/image_service.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/media_model.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  UserModel userModel = UserModel();
  TextEditingController displayNameCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController bioCtrl = TextEditingController();
  final userController = Get.find<UserController>();
  final imageService = Get.find<ImageService>();
  bool isProfilePicPickedFromGallery = false;
  String profilePicPath = "";
  final firebaseServices = Get.find<FirebaseStorageService>();
  String updateStatus = "NOT_UPDATING";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    feedProfileDetails();
  }

  feedProfileDetails() {
    displayNameCtrl.text = userController.appUser.displayName;
    userNameCtrl.text = userController.appUser.username;
    bioCtrl.text = userController.appUser.bio;
    userModel.profilePic = userController.appUser.profilePic;
  }

  getImagesFromGallery() async {
    try {
      XFile? image = await imageService.pickSingleImageFromGallery();
      if (image != null) {
        profilePicPath = image.path;
        isProfilePicPickedFromGallery = true;
        update(['PROFILE_PIC']);
      }
    } catch (e) {
      logger.e('getImagesFromGallery error $e');
    }
  }

  Future updateDetails() async {
    updateStatus = "UPDATING";
    update(['PROFILE_PAGE']);
    detailsToUpdate();
    if (profilePicPath != "") {
      await uploadProfilePicToStorage();
    }
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userController.appUser.id)
        .update({
      "profilePic": userModel.profilePic,
      "displayName": userModel.displayName,
      "username": userModel.username,
      "bio": userModel.bio,
    }).then((value) {
      logger.d("profile updated successfully");
      updateStatus = "UPDATED";
      profilePicPath = "";
      update(['PROFILE_PAGE']);
      userController.appUser.displayName = userModel.displayName;
      userController.appUser.username = userModel.username;
      userController.appUser.bio = userModel.bio;

      if (userModel.profilePic != "") {
        userController.appUser.profilePic = userModel.profilePic;
        userController.update(['PROFILE_PAGE']);
      }
    }).onError(
      (error, stackTrace) {
        logger.e('error update profile details $error');
        updateStatus = "ERROR";
      },
    );
  }

  uploadProfilePicToStorage() async {
    logger.d("uploadProfilePicToStorage");
    List<MediaModel> tempMedia = [MediaModel()];
    List<MediaModel> urlStore = [];
    tempMedia[0].url = profilePicPath;
    try {
      await firebaseServices.uploadMediaToFirebaseStorage(
        mediaPath: tempMedia,
        mediaUrlWithTypeToStore: urlStore,
      );
      userModel.profilePic = urlStore[0].url;
    } catch (e) {
      logger.e('error uploading profile pic');
    }
  }

  detailsToUpdate() {
    userModel.displayName = displayNameCtrl.text;
    userModel.username = userNameCtrl.text;
    userModel.bio = bioCtrl.text;
  }
}
