import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/widgets/build_swiper.dart';
import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:commentor/src/controllers/story_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStory extends StatelessWidget {
  AddStory({Key? key}) : super(key: key);
  final storyController = Get.find<DisplayStoryController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DisplayStoryController>(
        id: 'ADD_STORY_PAGE',
        builder: (_) {
          return _.isUploading == true
              ? Material(child: Center(child: CircularProgressIndicator()))
              : Scaffold(
                  appBar: AppBar(
                    title: const Text("Add Stories"),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          await storyController.uploadStories();

                          // logger.d('imagesUrl :${addBlogController.blogModel.picList}');
                        },
                        child: const Text('Upload'),
                      ),
                    ],
                  ),
                  body: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text("*Choose pics / video"),
                      ),
                      IconButton(
                        onPressed: () async {
                          await storyController.pickStory();
                        },
                        icon: const Icon(
                          Icons.photo_outlined,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                      GetBuilder<DisplayStoryController>(
                        id: "ADD_IMAGES_SWIPER",
                        builder: (_) => BuildSwiper(
                          imageUrls: const [],
                          editPage: true,
                          aspectRatio: 4 / 3,
                          mediaList: storyController.mediaList,

                          // imagesCount: addExchangeCtrl.imagesCount,
                        ),
                      )
                    ],
                  ),
                );
        });
  }
}
