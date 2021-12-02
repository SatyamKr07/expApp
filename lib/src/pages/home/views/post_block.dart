import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/central/widgets/build_swiper.dart';
import 'package:commentor/src/controllers/home_controller.dart';
import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/pages/comment/comments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostBlock extends StatefulWidget {
  PostModel postModel;
  PostBlock({Key? key, required this.postModel}) : super(key: key);

  @override
  State<PostBlock> createState() => _PostBlockState();
}

class _PostBlockState extends State<PostBlock> {
  final homeController = Get.find<HomeController>();

  bool isLiked = false;

  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    checkIfLiked(widget.postModel);
  }

  checkIfLiked(PostModel postModel) {
    logger.d("checkIfLiked post ${postModel.postId}");
    if (postModel.likesArray.contains(userController.appUser.id)) {
      isLiked = true;
    } else {
      isLiked = false;
    }
  }

  Future onLikeButtonTapped({String docId = ''}) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    logger.d('onLikeButtonTapped');
    try {
      if (!isLiked) {
        // widget.postModel.likesCount++;
        int l = widget.postModel.likesCount;
        FirebaseFirestore.instance.collection("posts").doc(docId).update({
          "likesArray": FieldValue.arrayUnion([userController.appUser.id]),
          "likesCount": l += 1,
        }).then((value) {
          setState(() {
            isLiked = true;
            widget.postModel.likesCount = l;
          });
          logger.d("liked successfully : $isLiked");
        }).onError((error, stackTrace) {
          // widget.postModel.likesCount--;
          logger.d('liking error $error');
          // isLiked = false;
        });
      } else {
        // widget.postModel.likesCount--;
        int l = widget.postModel.likesCount;
        FirebaseFirestore.instance.collection("posts").doc(docId).update({
          "likesArray": FieldValue.arrayRemove([userController.appUser.id]),
          "likesCount": l -= 1,
        }).then(
          (value) {
            setState(() {
              isLiked = false;
              widget.postModel.likesCount = l;
            });
            logger.d("unliked successfully :liked value is $isLiked");
          },
        ).onError((error, stackTrace) {
          // widget.postModel.likesCount++;
          logger.d('unliking error $error');
          // isLiked = false;
        });
      }
      homeController.update(['LIKE_BUTTON']);
    } catch (e) {
      logger.e('catch like error $e');
    }
    // return isLiked;
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
                      widget.postModel.uploaderName,
                      // style: KCustomTextstyle.kMedium(context, 10),
                    ),
                    // Text(
                    //   "satyamismyname@gmail.com",
                    //   // style: KCustomTextstyle.kMedium(context, 10),
                    // ),
                    Text(
                      timeago.format((widget.postModel.postedOn)),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(() => Comments(
                          postId: widget.postModel.postId,
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
                widget.postModel.description,
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
                      child: BuildSwiper(
                        aspectRatio: 4 / 3,
                        imageUrls: const [],
                        mediaList: widget.postModel.mediaList,
                        editPage: false,
                      )
                      //  BuildSwiper(
                      //   picList: widget.postModel.picList,
                      //   aspectRatio: 4 / 3,
                      // )

                      //  Image.network(
                      //   // "https://im0-tub-ru.yandex.net/i?id=84dbd50839c3d640ebfc0de20994c30d&n=27&h=480&w=480g",
                      //   postModel.picList[0],
                      //   height: Get.width * 3 / 4,
                      //   width: Get.width,
                      //   fit: BoxFit.cover,
                      // ),
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
                      child: InkWell(
                        onTap: () {
                          onLikeButtonTapped(
                            docId: widget.postModel.postId,
                          );
                        },
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
                              Column(
                                children: [
                                  if (isLiked)
                                    const Icon(FontAwesomeIcons.solidHeart,
                                        size: 18, color: Colors.red

                                        // color: KConstantColors.conditionalColor(context: context),
                                        )
                                  else
                                    const Icon(
                                      FontAwesomeIcons.heart,
                                      size: 18,
                                      color: Colors.grey,
                                      // color: KConstantColors.conditionalColor(context: context),
                                    )
                                ],
                              ),

                              hSizedBox2,
                              Text(
                                widget.postModel.likesCount.toString(),
                                // style: KCustomTextstyle.kMedium(context, 10),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
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
