import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/pages/home/views/post_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

class AllPostsList extends StatelessWidget {
  AllPostsList({Key? key}) : super(key: key);
  List<PostModel> postList = [];
  final homeController = Get.find<HomeController>();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    logger.d('in build followingList ${userController.appUser.followingList}');

    return GetBuilder<HomeController>(
      id: 'ALL_POSTS',
      builder: (_) => (userController.appUser.followingList.length == 1)
          ? Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: Get.height,
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: const [
                    Center(
                      child: Text(
                          "No posts! Follow users to see their posts in your feed"),
                    ),
                  ],
                ),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: homeController.fetchPosts(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Something went wrong'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text("Loading...")),
                  );
                }
                postList = snapshot.data!.docs.map((DocumentSnapshot document) {
                  // PostModel postModel;
                  return PostModel.fromJson(
                    document.data() as Map<String, dynamic>,
                    document,
                  );
                }).toList();

                logger.d("postList", postList.length.toString());

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    PostModel postModel = postList[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: PostBlock(
                        postModel: postModel,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
