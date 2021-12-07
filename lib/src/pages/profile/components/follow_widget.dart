import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FollowWidget extends StatefulWidget {
  UserModel userModel;
  FollowWidget({Key? key, required this.userModel}) : super(key: key);

  @override
  State<FollowWidget> createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> {
  final userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    checkIfFollowing();
  }

  late bool isFollowing;
  checkIfFollowing() {
    logger.d("checkIfFollowing");
    if (userController.appUser.followingList!.contains(widget.userModel.id)) {
      isFollowing = true;
    } else {
      isFollowing = false;
    }
  }

  handleFollow() async {
    logger.d('handleFollow');
    try {
      if (!isFollowing) {
        // widget.postModel.likesCount++;
        int l = userController.appUser.followingCount;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userController.appUser.id)
            .update({
          "followingList": FieldValue.arrayUnion([widget.userModel.id]),
          "followingCount": l += 1,
        }).then((value) async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(widget.userModel.id)
              .update({
            "followersList": FieldValue.arrayUnion([userController.appUser.id]),
            "followersCount": l,
          });
          setState(() {
            isFollowing = true;
            userController.appUser.followingList!.add(widget.userModel.id);
            userController.appUser.followingCount = l;
          });
          logger.d("liked successfully : $isFollowing");
        }).onError((error, stackTrace) {
          // widget.postModel.likesCount--;
          logger.d('liking error $error');
          // isFollowing = false;
        });
      } else {
        // widget.postModel.likesCount--;
        int l = userController.appUser.followingCount;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userController.appUser.id)
            .update({
          "followingList": FieldValue.arrayRemove([widget.userModel.id]),
          "followingCount": l -= 1,
        }).then(
          (value) async {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(widget.userModel.id)
                .update({
              "followersList":
                  FieldValue.arrayRemove([userController.appUser.id]),
              "followersCount": l,
            });
            setState(() {
              isFollowing = false;
              userController.appUser.followingList!.remove(widget.userModel.id);
              userController.appUser.followingCount = l;
            });
            logger.d(
                "handleFollow successfully :isFollwing value is $isFollowing");
          },
        ).onError((error, stackTrace) {
          // widget.postModel.likesCount++;
          logger.d('handleFollow error $error');
          // isFollowing = false;
        });
      }
    } catch (e) {
      logger.e('catch handleFollow error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        handleFollow();
        // userController.handleFollow(userId: userModel.id);
      },
      child: Text(isFollowing ? "Following" : "Follow"),
    );
  }
}
