import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../central/services/my_logger.dart';

class UserController extends GetxController {
  UserModel appUser = UserModel();

  Stream<QuerySnapshot> fetchUserPost() {
    return FirebaseFirestore.instance
        .collection("posts")
        .where('uploaderId', isEqualTo: appUser.id)
        .orderBy('postedOn', descending: true)
        .snapshots();
  }
}
