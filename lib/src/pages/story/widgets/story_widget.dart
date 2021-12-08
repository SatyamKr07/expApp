import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/controllers/story_controller.dart';
import 'package:commentor/src/controllers/user_controller.dart';
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
  final myStoryController = Get.find<DisplayStoryController>();
  int storyIndex = 0;

  void addStoryItems() {
    for (final story in widget.userModel.storiesList) {
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

    final currentIndex = myStoryController.usersList.indexOf(widget.userModel);
    final isLastPage = myStoryController.usersList.length - 1 == currentIndex;

    if (isLastPage) {
      Navigator.of(context).pop();
    }
  }

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          StoryView(
            storyItems: storyItems,
            controller: controller,
            onComplete: handleCompleted,
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            },
            onStoryShow: (storyItem) {
              // storyIndex = storyItems.indexOf(storyItem);
              if (storyIndex > 0) {
                setState(() {
                  // date = widget.userModel.stories[index].date;
                });
              }
            },
          ),
          Stack(
            children: [
              ProfileWidget(
                user: widget.userModel,
                date: date,
              ),
              // if (widget.userModel.id == userController.appUser.id)
              //   Positioned(
              //     right: 16,
              //     top: 36,
              //     child: InkWell(
              //       onTap: () {
              //         controller.pause();
              //         storyItems.removeAt(storyIndex);
              //         // storyItems.
              //         controller.play();
              //       },
              //       child: Icon(Icons.delete_forever, color: Colors.red),
              //     ),
              //   ),
            ],
          ),
        ],
      ),
    );
  }
}
