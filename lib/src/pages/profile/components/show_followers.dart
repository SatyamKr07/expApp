import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';

import '../profile.view.dart';
import 'follow_widget.dart';

class ShowFollowers extends StatefulWidget {
  const ShowFollowers({Key? key}) : super(key: key);

  @override
  State<ShowFollowers> createState() => _ShowFollowersState();
}

class _ShowFollowersState extends State<ShowFollowers> {
  final userController = Get.find<UserController>();

  List usersList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (userController.appUser.followersList
    //     .contains(userController.appUser.id)) {
    //   // setState(() {});
    //   userController.appUser.followersList.remove(userController.appUser.id);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .where("id", whereIn: userController.appUser.followersList)
          .get(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (snapshot.hasData) {
          usersList = snapshot.data!.docs.map((DocumentSnapshot document) {
            return UserModel.fromJson(document.data() as Map<String, dynamic>);
          }).toList();
          // userModel = UserModel.fromJson(
          //   snapshot.data!.data() as Map<String, dynamic>,
          // );
          // userModel = snapshot.data as UserModel;
          // User user = snapshot.data as User;
          // return Text(user.email.toString(),
          //     style: KCustomTextstyle.kBold(context, 12),);
          return usersListView(usersList);
        }
        return const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget usersListView(List usersList) {
    return Scaffold(
      backgroundColor: Color(0xff1D1E22),
      appBar: AppBar(title: const Text("Followers")),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: usersList.length,
        itemBuilder: (BuildContext context, int index) {
          UserModel user = usersList[index];
          return InkWell(
            onTap: () {
              Get.to(() => ProfileView(
                    userId: usersList[index].id,
                  ));
            },
            child: user.id == userController.appUser.id
                ? Container()
                : ListTile(
                    leading: usersList[index].profilePic == ""
                        ? const ClipOval(
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage(
                                  'assets/images/default_profile_pic.png'),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: usersList[index].profilePic,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            // errorWidget: Image.asset(
                            //               'assets/images/default_profile_pic.png'),
                          ),
                    title: Text(user.displayName),
                    subtitle: Text(user.username),
                    trailing: FollowWidget(userModel: usersList[index]),
                  ),
          );
        },
      ),
    );
  }
}
