import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ProfileCount extends StatelessWidget {
  UserModel userModel;
  ProfileCount({Key? key, required this.userModel}) : super(key: key);
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    _profileComponent({required int count, required String title}) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$count ",
            // style: KCustomTextstyle.kBold(context, 12),
          ),
          Text(
            title,
            // style: KCustomTextstyle.kMedium(context, 10),
          )
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _profileComponent(
          count: userController.appUser.followersCount,
          title: "Followers",
        ),
        _profileComponent(
          count: userController.appUser.followingCount,
          title: "Following",
        ),
        _profileComponent(
          count: userController.appUser.totalCommentsCount,
          title: "Comments",
        ),
        _profileComponent(
          count: userController.appUser.totalLikesCount,
          title: "Likes",
        ),
      ],
    );
  }
}
