import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeController extends GetxController {
  String filterCategory = "All Posts";
  final userController = Get.find<UserController>();
  bool isDeleting = false;
  PersistentTabController pageController = PersistentTabController();
  changePage({required int index}) {
    logger.d('changePage $index');
    pageController.jumpToTab(index);
    update(['BOTTOM_BAR']);
  }

  Stream<QuerySnapshot> fetchPosts() {
    logger.d('fetchPosts');
    logger.d('followingList : ${userController.appUser.followingList}');
    logger.d('userId : ${userController.appUser.id}');
    return FirebaseFirestore.instance
        .collection("posts")
        .where(
          "uploaderId",
          whereIn: userController.appUser.followingList,
        )
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

  bool checkIfLiked(PostModel postModel) {
    logger.d("checkIfLiked");
    if (postModel.likesArray.contains(userController.appUser.id)) {
      logger.d("liked");
      return true;
    }
    logger.d("not liked");
    return false;
  }

  handleDeleteDoc({required String colName, required String docId}) async {
    await FirebaseFirestore.instance
        .collection(colName)
        .doc(docId) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) {
      logger.d('Deleted doc with id $docId');
    }).catchError((error) => logger.e('Delete failed: $error'));
  }

  handleDeletePost({required String colName, required String docId}) async {
    isDeleting = true;
    update(['DELETE_POST_BTN']);
    // await Future.delayed(Duration(seconds: 3));
    // isDeleting = false;
    // update(['DELETE_POST_BTN']);
    await FirebaseFirestore.instance
        .collection(colName)
        .doc(docId) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) {
      logger.d('Deleted doc with id $docId');
      isDeleting = false;
      update(['DELETE_POST_BTN']);
    }).catchError((error) {
      logger.e('Delete failed: $error');
      isDeleting = false;
      update(['DELETE_POST_BTN']);
    });
  }

  // handleDeletePost({required String docId})
}
