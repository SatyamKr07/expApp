import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  String filterCategory = "All Posts";

  changeFilter(String? category) {
    logger.d('category $category');
    filterCategory = category!;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      update(['FILTER_CATEGORY_DROPDOWN', 'ALL_POSTS']);
    });
    // filterPosts();
  }

  Stream<QuerySnapshot> filterPosts() {
    // logger.d('category $category');
    // filterCategory = category!;
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   update(['FILTER_CATEGORY_DROPDOWN', 'ALL_POSTS']);
    // });

    if (filterCategory == "All Posts") {
      logger.d('fetching all posts');
      return FirebaseFirestore.instance
          .collection("blogs")
          .orderBy('postedOn', descending: true)
          .snapshots();
    } else {
      logger.d("fetching else category = $filterCategory");
      return FirebaseFirestore.instance
          .collection('blogs')
          .where('category', isEqualTo: filterCategory)
          // .orderBy('postedOn')
          .snapshots();
    }

    // .then();
  }

  void handleTagClick(String category) {}
}
