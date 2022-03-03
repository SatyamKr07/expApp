import 'package:cloud_firestore/cloud_firestore.dart';
import '../../central/services/my_logger.dart';
import '../../controllers/home_controller.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';
import 'views/all_comments.dart';
import 'views/write_comment_area.dart';
import '../home/views/post_block.dart';
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
