import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/controllers/story_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'story_page.dart';

class StoryListPage extends StatelessWidget {
  final storyController = Get.find<DisplayStoryController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: StreamBuilder(
        stream: storyController.filterUser(""),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            storyController.usersList =
                snapshot.data!.docs.map((DocumentSnapshot document) {
              return UserModel.fromJson(
                  document.data() as Map<String, dynamic>);
            }).toList();

            return usersListView(storyController.usersList);
          } else if (snapshot.hasError) {
            return const Text("Some error occured");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      //  ListView.builder(
      //   shrinkWrap: true,
      //   scrollDirection: Axis.horizontal,
      //   itemCount: users.length,
      //   physics: const ClampingScrollPhysics(),
      //   itemBuilder: (BuildContext context, int index) {
      //     return GestureDetector(
      // onTap: () {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => StoryPage(user: users[index]),
      //     ),
      //   );
      // },
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 4),
      //         child:

      //         CircleAvatar(
      //           backgroundImage: AssetImage(users[index].imgUrl),
      //           backgroundColor: Colors.deepPurpleAccent,
      //           radius: 3.h,
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  Widget usersListView(List usersList) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: usersList.length,
      itemBuilder: (BuildContext context, int index) {
        UserModel user = usersList[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StoryPage(userModel: usersList[index]),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: CachedNetworkImage(
              imageUrl: user.profilePic,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              // errorWidget: Image.asset(
              //               'assets/images/default_profile_pic.png'),
            ),
          ),
        );
      },
    );
  }
}

// import 'package:commentor/src/data/users.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// import 'story_page.dart';

// class StoryListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Container(
//         // appBar: AppBar(
//         //   title: Text("story"),
//         // ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             height: 200,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               // shrinkWrap: true,
//               // physics: const ClampingScrollPhysics(),
//               children: users
//                   .map(
//                     (user) => SizedBox(
//                       width: 100.w,
//                       height: 6.h,
//                       child: Row(
//                         children: [
//                           // Expanded(
//                           //   flex: 1,
//                           //   child: GestureDetector(
//                           //     onTap: () {},
//                           //     child: Padding(
//                           //       padding: const EdgeInsets.symmetric(horizontal: 4),
//                           //       child: CircleAvatar(
//                           //           backgroundColor: Colors.deepPurpleAccent, radius: 3.h),
//                           //     ),
//                           //   ),
//                           // ),
//                           Expanded(
//                             flex: 5,
// child: ListView.builder(
//   shrinkWrap: true,
//   scrollDirection: Axis.horizontal,
//   itemCount: users.length,
//   physics: const ClampingScrollPhysics(),
//   itemBuilder: (BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) =>
//                 StoryPage(user: user),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             horizontal: 4),
//         child: CircleAvatar(
//           backgroundImage: AssetImage(user.imgUrl),
//           backgroundColor: Colors.deepPurpleAccent,
//           radius: 3.h,
//         ),
//       ),
//                                 );
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     // CircleAvatar(backgroundImage: AssetImage(user.imgUrl)),
//                     //     ListTile(
//                     //   title: Text(
//                     //     user.name,
//                     //     style: TextStyle(
//                     //       fontSize: 18,
//                     //       fontWeight: FontWeight.bold,
//                     //     ),
//                     //   ),
//                     //   leading: CircleAvatar(
//                     //       backgroundImage: AssetImage(user.imgUrl)),
//                     //   onTap: () {
//                     //     Navigator.of(context).push(
//                     //       MaterialPageRoute(
//                     //         builder: (context) => StoryPage(user: user),
//                     //       ),
//                     //     );
//                     //   },
//                     // ),
//                   )
//                   .toList(),
//             ),
//           ),
//         ),
//       );
// }
