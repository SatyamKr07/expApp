import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/widgets/build_swiper.dart';
import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:commentor/src/pages/add_blog/views/add_pic.dart';
import 'package:commentor/src/pages/add_blog/views/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/title_desc.dart';

class AddBlog extends StatelessWidget {
  AddBlog({Key? key}) : super(key: key);
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
                    title: const Text("Add Blog"),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          await addBlogController.postBlog();

                          // logger.d('imagesUrl :${addBlogController.blogModel.picList}');
                        },
                        child: const Text('Upload'),
                      ),
                    ],
                  ),
                  body: ListView(
                    children: [
                      TitleDesc(),
                      CategoryDropdown(),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text("*Choose/Click pics"),
                      ),
                      AddPic(),
                      GetBuilder<AddPostController>(
                        id: "ADD_IMAGES_SWIPER",
                        builder: (_) => BuildSwiper(
                          picList: addBlogController.imagesPath,
                          editPage: true,
                        ),
                      )
                    ],
                  ),
                );
        });
  }
}
