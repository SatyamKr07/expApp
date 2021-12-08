import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/widgets/build_swiper.dart';
import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/add_pic.dart';
import 'views/title_desc.dart';

class AddPost extends StatelessWidget {
  AddPost({Key? key}) : super(key: key);
  final addBlogController = Get.find<AddPostController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(
        id: 'ADD_BLOG_PAGE',
        builder: (_) {
          return _.isUploading == true
              ? Material(child: Center(child: CircularProgressIndicator()))
              : Scaffold(
                  appBar: AppBar(
                    title: const Text("Add Post"),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            primary: Colors.black,
                            // primary: CupertinoColors.systemPurple,
                          ),
                          onPressed: () async {
                            await addBlogController.uploadPost();

                            // logger.d('imagesUrl :${addBlogController.blogModel.picList}');
                          },
                          child: const Text('Upload'),
                        ),
                      ),
                    ],
                  ),
                  body: ListView(
                    children: [
                      TitleDesc(),
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
                      )
                    ],
                  ),
                );
        });
  }
}
