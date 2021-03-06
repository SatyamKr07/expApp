import 'package:cached_network_image/cached_network_image.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/user.dart';
import '../../../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ProfileWidget extends StatelessWidget {
  final UserModel user;
  final String date;

  ProfileWidget({
    required this.user,
    required this.date,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: ListTile(
          leading: user.profilePic == ""
              ? const ClipOval(
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        AssetImage('assets/images/default_profile_pic.png'),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: user.profilePic,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  // errorWidget: Image.asset(
                  //               'assets/images/default_profile_pic.png'),
                ),
          title: Text(
            user.displayName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          // trailing: user.id != userController.appUser.id
          //     ? SizedBox.shrink()
          //     : 
        ),
      )

      // Container(
      //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       CachedNetworkImage(
      //         imageUrl: user.profilePic,
      //         placeholder: (context, url) => CircularProgressIndicator(),
      //         errorWidget: (context, url, error) => Icon(Icons.error),
      //         imageBuilder: (context, imageProvider) => Container(
      //           width: 40.0,
      //           height: 40.0,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             image: DecorationImage(
      //                 image: imageProvider, fit: BoxFit.cover),
      //           ),
      //         ),
      //         // errorWidget: Image.asset(
      //         //               'assets/images/default_profile_pic.png'),
      //       ),
      //       SizedBox(width: 16),
      //       Expanded(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             Text(
      //               user.displayName,
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.white,
      //               ),
      //             ),
      //             Text(
      //               date,
      //               style: TextStyle(color: Colors.white38),
      //             )
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      );
}
