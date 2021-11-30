import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/models/comment_model.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

import 'comment_template.dart';

class AllComments extends StatelessWidget {
  AllComments({Key? key, required this.postId}) : super(key: key);
  final homeController = Get.find<HomeController>();
  String postId;
  List<CommentModel> blogList = [];
  final userController = Get.find<UserController>();

  Widget secondarystackBehindDismiss() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(Icons.delete, color: Colors.white),
            // Text('Move to trash', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'ALL_POSTS',
      builder: (_) => StreamBuilder<QuerySnapshot>(
        stream: homeController.fetchComments(postId: postId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          blogList = snapshot.data!.docs.map((DocumentSnapshot document) {
            return CommentModel.fromJson(
              document.data() as Map<String, dynamic>,
              document,
            );
          }).toList();
          logger.d("blogList", blogList.length.toString());

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              CommentModel commentModel = blogList[index];
              return Column(
                children: [
                  if (userController.appUser.id == blogList[index].postedBy.id)
                    Dismissible(
                      direction: DismissDirection.endToStart,
                      background: SizedBox.shrink(),
                      secondaryBackground: secondarystackBehindDismiss(),
                      onDismissed: (direction) {
                        homeController.handleDeleteComment(
                          docId: blogList[index].commentId,
                        );
                      },
                      key: Key(blogList[index].commentId),
                      child: CommentTemplate(
                        commentModel: commentModel,
                      ),
                    )
                  else
                    CommentTemplate(
                      commentModel: commentModel,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
