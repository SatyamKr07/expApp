import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:commentor/src/central/widgets/build_better_player.dart';
import 'package:commentor/src/models/media_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_io/io.dart';

import 'build_video_player.dart';
import 'my_loading_widget.dart';

class BuildSwiper extends StatefulWidget {
  BuildSwiper({
    Key? key,
    required this.imageUrls,
    this.editPage = false,
    this.aspectRatio = 1,
    required this.mediaList,
  }) : super(key: key);

  List imageUrls;
  bool editPage;
  double aspectRatio;
  List<MediaModel> mediaList;

  @override
  State<BuildSwiper> createState() => _BuildSwiperState();
}

class _BuildSwiperState extends State<BuildSwiper> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            // height: 400,
            aspectRatio: widget.aspectRatio,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
          items: widget.mediaList.map((media) {
            return Builder(
              builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!widget.editPage) ...[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            width: Get.width,
                            height: Get.width * 3 / 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.grey[200]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints(maxHeight: Get.width),
                                  child: (media.type == "image")
                                      ? CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: media.url,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const Center(
                                            child: MyLoadingWidget(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              IconButton(
                                            icon: const Icon(
                                                Icons.replay_outlined),
                                            onPressed: () {
                                              setState(() {});
                                            },
                                          ),
                                        )
                                      : BuildBetterPlayer(videoUrl: media.url)

                                  // BuildVideoPlayer(
                                  //     videoUrl: media.url,
                                  //     isEditPage: false,
                                  //   ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: Get.width * 3 / 4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.grey[200]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxHeight: Get.width),
                                    // child: BuildVideoPlayer(
                                    //   videoUrl: media.url,
                                    // ),
                                    child: (media.type == "image")
                                        ? Image.file(
                                            File(media.url),
                                            // File(media.url),
                                            fit: BoxFit.cover,
                                          )
                                        : BuildBetterPlayer(
                                            videoUrl: media.url,
                                            isEditPage: true,
                                          )

                                    // BuildVideoPlayer(
                                    //     videoUrl: media.url,
                                    //     isEditPage: true,
                                    //   ),
                                    ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.mediaList.remove(media);
                                  // widget.imageUrls.remove(media.url);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.delete_forever_rounded,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                );
              },
            );
          }).toList(),
        ),
        if (widget.mediaList.length > 1)
          Positioned(
            bottom: 8,
            // left: Get.width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.mediaList.asMap().entries.map((entry) {
                return GestureDetector(
                  child: Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 1 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
