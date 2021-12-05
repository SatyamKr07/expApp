import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/story_controller.dart';
import 'package:commentor/src/models/story_model.dart';
import 'package:commentor/src/models/user.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:commentor/src/pages/story/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:story_view/story_view.dart';

class StoryWidget extends StatefulWidget {
  final UserModel userModel;
  final PageController controller;

  const StoryWidget({
    required this.userModel,
    required this.controller,
  });

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  final storyItems = <StoryItem>[];
  late StoryController controller;
  String date = '';
  final storyController = Get.find<DisplayStoryController>();

  void addStoryItems() {
    for (final story in widget.userModel.storiesList!) {
      logger.d("addStoryItems story is $story");
      storyItems.add(StoryItem.pageImage(
        url: story.imageUrl,
        controller: controller,
        caption: "",
        duration: const Duration(
          seconds: 3,
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    controller = StoryController();
    addStoryItems();
    // date = widget.userModel.stories[0].date;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleCompleted() {
    widget.controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    final currentIndex = storyController.usersList.indexOf(widget.userModel);
    final isLastPage = storyController.usersList.length - 1 == currentIndex;

    if (isLastPage) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          StoryView(
            storyItems: storyItems,
            // storyItems: [
            //   StoryItem.pageImage(
            //     url:
            //         "https://firebasestorage.googleapis.com/v0/b/cool-blog-54040.appspot.com/o/media%2F1638632979684scaled_image_picker6454576566595141795.jpg?alt=media&token=4efd6316-1618-4f52-a17e-6c3c82461832",
            //     controller: controller,
            //     caption: "",
            //     duration: const Duration(
            //       seconds: 3,
            //     ),
            //   )
            // ],
            controller: controller,
            onComplete: handleCompleted,
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            },
            onStoryShow: (storyItem) {
              final index = storyItems.indexOf(storyItem);

              if (index > 0) {
                setState(() {
                  // date = widget.userModel.stories[index].date;
                });
              }
            },
          ),
          ProfileWidget(
            user: widget.userModel,
            date: date,
          ),
        ],
      ),
    );
  }
}
