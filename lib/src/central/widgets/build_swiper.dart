import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_loading_widget.dart';

class BuildSwiper extends StatefulWidget {
  BuildSwiper({
    Key? key,
    required this.picList,
    this.editPage = false,
    this.aspectRatio = 1,
  }) : super(key: key);

  List<String> picList;
  bool editPage;
  double aspectRatio;

  @override
  State<BuildSwiper> createState() => _BuildSwiperState();
}

class _BuildSwiperState extends State<BuildSwiper> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
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
          items: widget.picList.map((pic) {
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
                            height: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.grey[200]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxHeight: Get.width),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: pic,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const Center(
                                    child: MyLoadingWidget(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      IconButton(
                                    icon: const Icon(Icons.replay_outlined),
                                    onPressed: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
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
                              height: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.grey[200]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints(maxHeight: Get.width),
                                  child: Image.file(
                                    File(pic),
                                    // File(pic.url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.picList.remove(pic);
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
        if (widget.picList.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.picList.asMap().entries.map((entry) {
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
      ],
    );
  }
}
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'my_loading_widget.dart';

// class BuildSwiper extends StatefulWidget {
//   BuildSwiper({
//     Key? key,
//     required this.picList,
//     this.editPage = false,
//     this.aspectRatio = 1,
//   }) : super(key: key);

//   List picList;
//   bool editPage;
//   double aspectRatio;

//   @override
//   State<BuildSwiper> createState() => _BuildSwiperState();
// }

// class _BuildSwiperState extends State<BuildSwiper> {
//   int _current = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       clipBehavior: Clip.hardEdge,
//       children: [
//         CarouselSlider(
//           options: CarouselOptions(
//             // height: 400,
//             aspectRatio: widget.aspectRatio,
//             viewportFraction: 1,
//             initialPage: 0,
//             enableInfiniteScroll: false,
//             reverse: false,
//             enlargeCenterPage: true,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _current = index;
//               });
//             },
//             scrollDirection: Axis.horizontal,
//           ),
//           items: widget.picList.map((i) {
//             return Builder(
//               builder: (_) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (!widget.editPage) ...[
//                       Expanded(
//                         child: InkWell(
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(0),
//                                 color: Colors.grey[200]),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(0),
//                               child: ConstrainedBox(
//                                 constraints:
//                                     BoxConstraints(maxHeight: Get.width),
//                                 child: CachedNetworkImage(
//                                   fit: BoxFit.contain,
//                                   imageUrl: i,
//                                   progressIndicatorBuilder:
//                                       (context, url, downloadProgress) =>
//                                           const Center(
//                                     child: MyLoadingWidget(),
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       IconButton(
//                                     icon: const Icon(Icons.replay_outlined),
//                                     onPressed: () {
//                                       setState(() {});
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ] else ...[
//                       Expanded(
//                         child: Stack(
//                           children: [
//                             Container(
//                               width: Get.width,
//                               height: Get.width * 3 / 4,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(0),
//                                   color: Colors.grey[200]),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(0),
//                                 child: ConstrainedBox(
//                                   constraints:
//                                       BoxConstraints(maxHeight: Get.width),
//                                   child: Image.file(
//                                     i,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   widget.picList.remove(i);
//                                 });
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Colors.white,
//                                   ),
//                                   child: const Padding(
//                                     padding: EdgeInsets.all(6.0),
//                                     child: Icon(
//                                       Icons.delete_forever_rounded,
//                                       color: Colors.red,
//                                       size: 24,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ]
//                   ],
//                 );
//               },
//             );
//           }).toList(),
//         ),
//         if (widget.picList.length > 1)
//           Positioned(
//             bottom: 8,
//             // left: Get.width / 2,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: widget.picList.asMap().entries.map((entry) {
//                 return GestureDetector(
//                   child: Container(
//                     width: 6.0,
//                     height: 6.0,
//                     margin: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 4.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: (Theme.of(context).brightness == Brightness.dark
//                               ? Colors.white
//                               : Colors.black)
//                           .withOpacity(_current == entry.key ? 1 : 0.4),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//       ],
//     );
//   }
// }
