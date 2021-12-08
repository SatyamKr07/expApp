import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/pages/add_post/add_post.dart';
import 'package:commentor/src/pages/home/views/post_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';

class ShowPost extends StatelessWidget {
  PostModel postModel;
  ShowPost({Key? key, required this.postModel}) : super(key: key);
  final homeController = Get.find<HomeController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: ListView(
          children: [
            PostBlock(
              postModel: postModel,
            ),
            if (postModel.uploaderId == userController.appUser.id) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final addPostController = Get.find<AddPostController>();
                    addPostController.descCtrl.text = postModel.description;
                    Get.to(() => AddPost(
                          updatePost: true,
                          postId: postModel.postId,
                        ));
                    // handleFollow();
                    // userController.handleFollow(userId: userModel.id);
                  },
                  child: Text("Update"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    primary: Colors.black,
                  ),
                ),
              ),
              GetBuilder<HomeController>(
                // init: HomeController(),
                // initState: (_) {},
                id: "DELETE_POST_BTN",
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: homeController.isDeleting
                          ? null
                          : () async {
                              await homeController.handleDeletePost(
                                colName: "posts",
                                docId: postModel.postId,
                              );
                              Get.back();

                              // handleFollow();
                              userController.update(['PROFILE_BODY']);
                            },
                      label: Text(
                        homeController.isDeleting
                            ? "Deleting Post..."
                            : "Delete",
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        primary: Colors.red,
                      ),
                      icon: Icon(Icons.delete_forever),
                    ),
                  );
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
