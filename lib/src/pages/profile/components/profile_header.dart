import 'package:cached_network_image/cached_network_image.dart';
import 'package:commentor/src/central/services/auth_ctrl.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/pages/edit_profile/edit_profile.dart';
import 'package:commentor/src/pages/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';

class ProfileHeader extends StatelessWidget {
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    // AuthenticationCubit authenticationCubit =
    //     BlocProvider.of<AuthenticationCubit>(context, listen: false);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // FutureBuilder(
              //     future: authenticationCubit.fetchLoggedUser(context: context),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return SizedBox(
              //             height: 20,
              //             width: 20,
              //             child: CircularProgressIndicator());
              //       }
              //       if (snapshot.hasData) {
              //         User user = snapshot.data as User;
              //         return Text(user.email.toString(),
              //             style: KCustomTextstyle.kBold(context, 12));
              //       }
              //       return SizedBox(
              //           height: 20,
              //           width: 20,
              //           child: CircularProgressIndicator());
              //     }),
              IconButton(
                onPressed: () {
                  Get.to(() => EditProfile());
                },
                icon: Icon(
                  Icons.edit,
                  // color: KConstantColors.whiteColor,
                  size: 16,
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    // color: KConstantColors.whiteColor,
                  )),
              IconButton(
                  onPressed: () async {
                    await AuthCtrl.signOut(context: context);
                    Get.offAll(() => SignInScreen());
                  },
                  icon: Icon(
                    Icons.logout,
                    // color: KConstantColors.whiteColor,
                  ))
            ],
          ),
          vSizedBox3,
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      hSizedBox4,
                      hSizedBox2,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "0",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Top comments",
                            // style: KCustomTextstyle.kMedium(context, 10),
                          )
                        ],
                      ),
                      hSizedBox2,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "0",
                            // style: KCustomTextstyle.kBold(context, 16),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Trending comments",
                            // style: KCustomTextstyle.kMedium(context, 10),
                          )
                        ],
                      )
                    ],
                  ),
                  height: 10.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      // color: KConstantColors.bgColorFaint,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                child: GetBuilder<UserController>(
                  id: "PROFILE_PAGE",
                  builder: (_) {
                    return userController.appUser.profilePic == ""
                        ? const ClipOval(
                            child: CircleAvatar(
                              radius: 37,
                              backgroundImage: AssetImage(
                                  'assets/images/default_profile_pic.png'),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: userController.appUser.profilePic,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 76.0,
                              height: 76.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            // errorWidget: Image.asset(
                            //               'assets/images/default_profile_pic.png'),
                          );
                  },
                ),
              ),
              // ClipOval(
              //   child: GetBuilder<UserController>(
              //     id: "PROFILE_PAGE",
              //     builder: (_) {
              //       return CircleAvatar(
              //         radius: 40,
              //         backgroundImage: userController.appUser.profilePic == ""
              //             ? Image.asset('assets/images/default_profile_pic.png')
              //                 as ImageProvider
              //             : CachedNetworkImageProvider(
              //                 userController.appUser.profilePic,

              //                 // errorWidget: Image.asset(
              //                 //               'assets/images/default_profile_pic.png'),
              //               ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
          vSizedBox2,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userController.appUser.displayName,
                    // style: KCustomTextstyle.kBold(context, 14),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                Text(
                  userController.appUser.bio,
                  // style: KCustomTextstyle.kMedium(context, 10),
                ),
                vSizedBox2,
                Divider(),
              ],
            ),
          ),
          // vSizedBox2,
        ],
      ),
    );
  }
}
