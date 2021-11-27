import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/central/widgets/build_swiper.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:commentor/src/pages/home/views/blog_description.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlogTemplate extends StatelessWidget {
  BlogTemplate({Key? key, required this.blogModel}) : super(key: key);
  PostModel blogModel;
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(blogModel.postedBy.profilePic),
          ),
          title: Text(blogModel.postedBy.displayName),
          subtitle: Text(
            timeago.format((blogModel.postedOn)),
          ),
        ),
        BuildSwiper(picList: blogModel.picList),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Wrap(children: [
            Text(
              blogModel.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                //  fontSize: 16
              ),
            ),
            InkWell(
              onTap: () {
                homeController.changeFilter(blogModel.category);
              },
              child: Text(
                " #${blogModel.category}",
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: BlogDescription(blogModel: blogModel),
        ),
      ],
    );
  }
}
