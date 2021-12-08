import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/models/comment_model.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/pages/comment/views/all_comments.dart';
import 'package:commentor/src/pages/comment/views/write_comment_area.dart';
import 'package:commentor/src/pages/home/views/post_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

import 'views/comment_template.dart';

class Comments extends StatelessWidget {
  PostModel postModel;
  Comments({
    Key? key,
    required this.postModel,
  }) : super(key: key);
  // String postId;
  final homeController = Get.find<HomeController>();
  List<CommentModel> blogList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Comment"),
        ),
        body: Column(
          children: [
            Expanded(child: AllComments(postModel: postModel)),
            WriteCommentArea(
              postId: postModel.postId,
            ),
          ],
        ));
  }
}
