import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/widgets/build_swiper.dart';
import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:commentor/src/pages/add_post/views/add_tags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/add_pic.dart';
import 'views/title_desc.dart';

class AddPost extends StatelessWidget {
  bool updatePost;
  String postId;
  AddPost({Key? key, this.updatePost = false, this.postId = ""})
      : super(key: key);
  final addBlogController = Get.find<AddPostController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(
        id: 'ADD_POST_PAGE',
        builder: (_) {
          return _.isUploading == true
              ? Material(child: Center(child: CircularProgressIndicator()))
              : Scaffold(
                  appBar: AppBar(
                    title: Text(!updatePost ? "New Post" : "Update Post"),
                    actions: const [],
                  ),
                  body: ListView(
                    children: [
                      TitleDesc(),
                      if (!updatePost) ...[
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text("*Choose pics / video"),
                        ),
                        AddPic(),
                        GetBuilder<AddPostController>(
                          id: "ADD_IMAGES_SWIPER",
                          builder: (_) => BuildSwiper(
                            imageUrls: const [],
                            editPage: true,
                            aspectRatio: 4 / 3,
                            mediaList: addBlogController.mediaList,

                            // imagesCount: addExchangeCtrl.imagesCount,
                          ),
                        ),
                        AddTags(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              primary: Colors.red,
                            ),
                            onPressed: () async {
                              if (!updatePost) {
                                await addBlogController.uploadPost();
                              } else {
                                await addBlogController.updatePost(
                                    docId: postId);
                              }

                              // logger.d('imagesUrl :${addBlogController.blogModel.picList}');
                            },
                            child: Text(!updatePost ? 'Post' : "Update"),
                          ),
                        ),
                      ]
                    ],
                  ),
                );
        });
  }
}
