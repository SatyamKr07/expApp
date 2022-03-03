import '../../../controllers/user_controller.dart';
import '../../../models/user_model.dart';
import 'show_followers.dart';
import 'show_following.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
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
        GetBuilder<UserController>(
          id: 'SHOW_FOLLOWERS_COUNT',
          builder: (_) {
            return InkWell(
              onTap: () {
                Get.to(() => ShowFollowers());
              },
              child: _profileComponent(
                count: userModel.followersList.length - 1,
                // count: userModel.followersCount,
                title: "Followers",
              ),
            );
          },
        ),
        GetBuilder<UserController>(
          id: 'SHOW_FOLLOWING_COUNT',
          builder: (_) {
            return InkWell(
              onTap: () {
                Get.to(() => ShowFollowing());
              },
              child: _profileComponent(
                count: userModel.followingList.length - 1,
                // count: userModel.followingCount,
                title: "Following",
              ),
            );
          },
        ),
        _profileComponent(
          count: userModel.totalCommentsCount,
          title: "Comments",
        ),
        _profileComponent(
          count: userModel.totalLikesCount,
          title: "Likes",
        ),
      ],
    );
  }
}
