import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../central/services/my_logger.dart';

class UserController extends GetxController {
  UserModel appUser = UserModel();
  // late Future<QuerySnapshot> userModelFuture;

  Stream<QuerySnapshot> fetchUserPost({required String userId}) {
    return FirebaseFirestore.instance
        .collection("posts")
        .where('uploaderId', isEqualTo: userId)
        .orderBy('postedOn', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getUserProfile({required String userId}) async {
    // userModelFuture =
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    // return userModelFuture;
  }

  Future handleFollow({required String userId}) async{
    
  }
}
