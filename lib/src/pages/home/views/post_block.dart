import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/pages/comment/comments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostBlock extends StatelessWidget {
  PostModel postModel;
  PostBlock({Key? key, required this.postModel}) : super(key: key);
  final homeController = Get.find<HomeController>();
  bool isLiked = false;
  final userController = Get.find<UserController>();
  checkIfLiked(PostModel postModel) {
    if (postModel.postLikesArray.contains(userController.appUser.id)) {
      isLiked = true;
    } else {
      isLiked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    // var date = DateTime.parse(data['created_at'].toDate().toString());
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 40, right: 8),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                hSizedBox1,
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: CupertinoColors.systemPurple,
                  child: Icon(
                    CupertinoIcons.person,
                    // color: KConstantColors.conditionalColor(context: context),
                  ),
                ),
                hSizedBox2,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postModel.postedBy.email,
                      // style: KCustomTextstyle.kMedium(context, 10),
                    ),
                    // Text(
                    //   "satyamismyname@gmail.com",
                    //   // style: KCustomTextstyle.kMedium(context, 10),
                    // ),
                    Text(
                      timeago.format((postModel.postedOn)),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(() => Comments(
                          postId: postModel.postId,
                        ));
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.comment,
                            size: 14,
                            color: Colors.white,
                            // color: KConstantColors.whiteColor,
                          ),
                          hSizedBox2,
                          Text(
                            "Comment",
                            // style: KCustomTextstyle.kBold(context, 8),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemPurple,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                hSizedBox2
              ],
            ),
            vSizedBox2,
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                postModel.title,
                // style: KCustomTextstyle.kBold(context, 10),
              ),
            ),
            // Text(data['caption'], style: KCustomTextstyle.kBold(context, 10)),
            vSizedBox1,
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      // "https://im0-tub-ru.yandex.net/i?id=84dbd50839c3d640ebfc0de20994c30d&n=27&h=480&w=480g",
                      postModel.picList[0],
                      height: Get.width * 3 / 4,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                    // child: Image.network(data['imageUrl']),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.black54.withOpacity(.4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            // Icon(
                            //   FontAwesomeIcons.heart,
                            //   size: 18,
                            //   color: Colors.red,
                            //   // color: KConstantColors.conditionalColor(context: context),
                            // ),
                            GetBuilder<HomeController>(
                              // init: HomeController(),
                              id: 'LIKE_BUTTON',
                              initState: (_) {
                                isLiked =
                                    homeController.checkIfLiked(postModel);
                              },
                              builder: (_) {
                                return InkWell(
                                  onTap: () {
                                    homeController.onLikeButtonTapped(
                                      isLiked: isLiked,
                                      docId: postModel.postId,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      if (isLiked)
                                        const Icon(FontAwesomeIcons.heartbeat,
                                            size: 18, color: Colors.red

                                            // color: KConstantColors.conditionalColor(context: context),
                                            )
                                      else
                                        const Icon(
                                          FontAwesomeIcons.heartbeat,
                                          size: 18,
                                          color: Colors.grey,
                                          // color: KConstantColors.conditionalColor(context: context),
                                        )
                                    ],
                                  ),

                                  // LikeButton(
                                  //   isLiked: isLiked,
                                  //   // onTap: homeController.onLikeButtonTapped2,
                                  // ),
                                );
                              },
                            ),
                            hSizedBox2,
                            const Text(
                              "1234",
                              // style: KCustomTextstyle.kMedium(context, 10),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            vSizedBox1,
          ],
        ),
      ),
    );
  }
}
