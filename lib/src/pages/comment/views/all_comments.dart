import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/models/comment_model.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/pages/home/views/post_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

import 'comment_template.dart';

class AllComments extends StatelessWidget {
  AllComments({Key? key, required this.postModel}) : super(key: key);
  final homeController = Get.find<HomeController>();
  PostModel postModel;
  List<CommentModel> commentsList = [];
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
      id: 'ALL_COMMENTS',
      builder: (_) => StreamBuilder<QuerySnapshot>(
        stream: homeController.fetchComments(postId: postModel.postId),
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
          commentsList = snapshot.data!.docs.map((DocumentSnapshot document) {
            return CommentModel.fromJson(
              document.data() as Map<String, dynamic>,
              document,
            );
          }).toList();
          logger.d("blogList", commentsList.length.toString());

          return ListView.builder(
            itemCount: snapshot.data!.docs.length + 1,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: PostBlock(postModel: postModel),
                );
              }
              CommentModel commentModel = commentsList[index - 1];
              return Column(
                children: [
                  if (userController.appUser.id ==
                      commentsList[index - 1].postedBy.id)
                    Dismissible(
                      direction: DismissDirection.endToStart,
                      background: SizedBox.shrink(),
                      secondaryBackground: secondarystackBehindDismiss(),
                      onDismissed: (direction) {
                        homeController.handleDeleteDoc(
                          docId: commentsList[index - 1].commentId,
                          colName: 'comments',
                        );
                      },
                      key: Key(commentsList[index - 1].commentId),
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
