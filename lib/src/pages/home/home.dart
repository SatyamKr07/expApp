import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/pages/add_blog/add_blog.dart';
import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/pages/home/views/all_posts_list.dart';
import 'package:commentor/src/pages/profile/profile_page.dart';
import 'package:commentor/src/pages/search_user/search_user.dart';
import 'package:commentor/src/settings/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

import 'views/all_posts_list.dart';
import 'views/story_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final userController = Get.find<UserController>();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(FontAwesomeIcons.bell)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            IconButton(
                onPressed: () {
                  Get.toNamed("/settings");
                  // Navigator.restorablePushNamed(
                  //     context, SettingsView.routeName);
                },
                icon: Icon(Icons.settings)),
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
          backgroundColor: Theme.of(context).backgroundColor),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          // GetBuilder<HomeController>(
          //   id: "FILTER_CATEGORY_DROPDOWN",
          //   builder: (_) => DropdownButton<String>(
          //     // value: _.blogModel.category,
          //     value: _.filterCategory,
          //     onChanged: _.filterPosts,
          //     items: const [
          //       DropdownMenuItem(
          //         value: "All Posts",
          //         child: Text('All Posts'),
          //       ),
          //       DropdownMenuItem(
          //         value: "sports",
          //         child: Text('Sports'),
          //       ),
          //       DropdownMenuItem(
          //         value: "movies",
          //         child: Text('Movies'),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 24),
            child: StoryListView(),
          ),

          AllPostsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "ADDEXCHANGETAG",
        onPressed: () async {
          Get.to(() => AddBlog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
