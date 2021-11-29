import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/models/comment_model.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';

import 'comment_template.dart';

class AllComments extends StatelessWidget {
  AllComments({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  List<CommentModel> blogList = [];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'ALL_POSTS',
      builder: (_) => StreamBuilder<QuerySnapshot>(
        stream: homeController.fetchComments(),
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
                document.data() as Map<String, dynamic>);
          }).toList();
          logger.d("blogList", blogList.length.toString());

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              CommentModel commentModel = blogList[index];
              return CommentTemplate(
                commentModel: commentModel,
              );
            },
          );
        },
      ),
    );
  }
}
