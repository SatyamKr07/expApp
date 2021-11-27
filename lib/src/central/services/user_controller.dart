import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'my_logger.dart';

class UserController extends GetxController {
  UserModel appUser = UserModel();

  Stream<QuerySnapshot> filterUser(emailQuery) {
    // logger.d('category $category');
    // filterCategory = category!;
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   update(['FILTER_CATEGORY_DROPDOWN', 'ALL_POSTS']);
    // });

    if (emailQuery == "") {
      logger.d('fetching all posts');
      return FirebaseFirestore.instance.collection("users").snapshots();
    } else {
      logger.d("fetching else category = $emailQuery");
      return FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailQuery)
          .snapshots();
    }

    // .then();
  }
}
