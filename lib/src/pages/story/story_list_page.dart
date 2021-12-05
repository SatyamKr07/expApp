import 'package:commentor/src/data/users.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'story_page.dart';

class StoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StoryPage(user: users[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: CircleAvatar(
                backgroundImage: AssetImage(users[index].imgUrl),
                backgroundColor: Colors.deepPurpleAccent,
                radius: 3.h,
              ),
            ),
          );
        },
      ),
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
