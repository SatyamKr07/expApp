import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/central/widgets/build_swiper.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({Key? key}) : super(key: key);
  final userController = Get.find<UserController>();
  List<PostModel> postList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: userController.fetchUserPost(),
          builder: (context, snapshot) {
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
            return GridView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BuildSwiper(
                    // picList: postList[index].picList,
                    imageUrls: const [],
                    mediaList: const [],
                  ),
                );
              },
            );
          }),
    );
  }
}
