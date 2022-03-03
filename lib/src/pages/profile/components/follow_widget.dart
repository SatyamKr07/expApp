import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../central/services/my_logger.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    if (userController.appUser.followingList.contains(widget.userModel.id)) {
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
          // "followingCount": l += 1,
        }).then((value) async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(widget.userModel.id)
              .update({
            "followersList": FieldValue.arrayUnion([userController.appUser.id]),
            // "followersCount": l,
          });
          setState(() {
            isFollowing = true;
            userController.appUser.followingList.add(widget.userModel.id);
            userController.update(['SHOW_FOLLOWING_COUNT']);
            // userController.appUser.followingCount = l;
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
          // "followingCount": l -= 1,
        }).then(
          (value) async {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(widget.userModel.id)
                .update({
              "followersList":
                  FieldValue.arrayRemove([userController.appUser.id]),
              // "followersCount": l,
            });
            setState(() {
              isFollowing = false;
              userController.appUser.followingList.remove(widget.userModel.id);
              // userController.appUser.followingCount = l;
              userController.update(['SHOW_FOLLOWING_COUNT']);
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
    return !isFollowing
        ? ElevatedButton.icon(
            onPressed: () {
              handleFollow();
              // userController.handleFollow(userId: userModel.id);
            },
            label: Text("Follow"),
            style: ElevatedButton.styleFrom(
              primary: Color(0xff212228),
              onPrimary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color(0xffEB1047)),
              ),
            ),
            icon: Icon(Icons.add),
          )
        : ElevatedButton(
            onPressed: () {
              handleFollow();
              // userController.handleFollow(userId: userModel.id);
            },
            child: Text("Unfollow"),
            style: ElevatedButton.styleFrom(
              primary: Color(0xff1F2125),
              onPrimary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color(0xffEB1047)),
              ),
            ),
          );
  }
}
