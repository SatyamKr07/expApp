import 'package:commentor/src/controllers/story_controller.dart';
import 'package:commentor/src/models/user.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/story_widget.dart';

class StoryPage extends StatefulWidget {
  final UserModel userModel;

  const StoryPage({
    required this.userModel,
    Key? key,
  }) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late PageController controller;
  final storyController = Get.find<DisplayStoryController>();
  @override
  void initState() {
    super.initState();

    final initialPage = storyController.usersList.indexOf(widget.userModel);
    controller = PageController(initialPage: initialPage);
    // controller = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PageView(
        controller: controller,
        children: storyController.usersList
            .map((user) => StoryWidget(
                  userModel: user,
                  controller: controller,
                ))
            .toList(),
      );
}
