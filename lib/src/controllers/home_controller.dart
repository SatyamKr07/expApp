import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  String filterCategory = "All Posts";
  final userController = Get.find<UserController>();

  Stream<QuerySnapshot> fetchPosts() {
    return FirebaseFirestore.instance
        .collection("blogs")
        .orderBy('postedOn', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchComments({required String postId}) {
    logger.d('fetching all comments');
    return FirebaseFirestore.instance
        .collection("comments")
        .where("postId", isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<bool> onLikeButtonTapped(
      {bool isLiked = false, String docId = ''}) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    logger.d('onLikeButtonTapped');
    if (!isLiked) {
      FirebaseFirestore.instance.collection("blogs").doc(docId).update({
        "likes": FieldValue.arrayUnion([userController.appUser.id])
      }).then((value) {
        return isLiked = true;
      }).onError((error, stackTrace) {
        logger.d('liking error $error');
        return isLiked = false;
      });
    } else {
      FirebaseFirestore.instance.collection("blogs").doc(docId).update({
        "likes": FieldValue.arrayRemove([userController.appUser.id])
      }).then((value) => isLiked = false);
    }

    return isLiked;
  }

  Future<bool> onLikeButtonTapped2(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    logger.d('onLikeButtonTapped2');
    if (!isLiked) {
      FirebaseFirestore.instance.collection("blogs").doc("docId").update({
        "likes": FieldValue.arrayUnion([userController.appUser.id])
      }).then((value) {
        return isLiked = true;
      }).onError((error, stackTrace) {
        logger.d('liking error $error');
        return isLiked = false;
      });
    } else {
      FirebaseFirestore.instance.collection("blogs").doc("docId").update({
        "likes": FieldValue.arrayRemove([userController.appUser.id])
      }).then((value) => isLiked = false);
    }

    return isLiked;
  }

  bool checkIfLiked(PostModel postModel) {
    if (postModel.postLikesArray.contains(userController.appUser.id)) {
      return true;
    }
    return false;
  }
}
