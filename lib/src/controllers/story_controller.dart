import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:get/get.dart';

class StoryController extends GetxController {
  //get all users list for stories
  List usersList = [];
  Stream<QuerySnapshot> filterUser(emailQuery) {
    // logger.d('category $category');
    // filterCategory = category!;
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   update(['FILTER_CATEGORY_DROPDOWN', 'ALL_POSTS']);
    // });

    logger.d('fetching all posts');
    return FirebaseFirestore.instance.collection("users").snapshots();
  }
}
