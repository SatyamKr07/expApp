import 'package:cached_network_image/cached_network_image.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                onPressed: () {},
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.grid_3x3,
                    // color: KConstantColors.whiteColor,
                  ))
            ],
          ),
          vSizedBox3,
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      // color: KConstantColors.bgColorFaint,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              ClipOval(
                child: CircleAvatar(
                  radius: 40,
                  child: CachedNetworkImage(
                    imageUrl: userController.appUser.profilePic,
                  ),
                ),
              ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                Text(
                  "Some bio",
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
