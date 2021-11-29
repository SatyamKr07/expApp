import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  String filterCategory = "All Posts";

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
}
