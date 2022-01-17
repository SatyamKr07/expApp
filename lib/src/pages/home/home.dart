import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/pages/add_story/add_story.dart';
import 'package:commentor/src/pages/home/views/all_posts_list.dart';
import 'package:commentor/src/pages/story/story_list_page.dart';
import 'package:commentor/src/settings/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

import 'views/all_posts_list.dart';
import 'views/story_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userController = Get.find<UserController>();

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddStory());
            },
            icon: const Icon(Icons.add),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Row(children: [
          const Icon(CupertinoIcons.home, size: 16),
          hSizedBox2,
          const Text(
            "Home",
            // style: KCustomTextstyle.kBold(context, 12),
          )
        ]),
        backgroundColor: Colors.black,
        // backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
            () {
              // homeController.update(['ALL_POSTS']);
              setState(() {});
              // showing snackbar
              // _scaffoldKey.currentState.showSnackBar(
              //   SnackBar(
              //     content: const Text('Page Refreshed'),
              //   ),
              // );
            },
          );
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          // shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 24),
              child: SizedBox(
                height: 50,
                child: (userController.appUser.followingList.isEmpty ||
                        userController.appUser.followingList == null)
                    ? Container()
                    : StoryListPage(),
              ),
              // child: StoryListView(),
            ),
            AllPostsList(),
          ],
        ),
      ),
    );
  }
}
