import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';

import '../profile.view.dart';
import 'follow_widget.dart';

class ShowFollowing extends StatefulWidget {
  const ShowFollowing({Key? key}) : super(key: key);

  @override
  State<ShowFollowing> createState() => _ShowFollowingState();
}

class _ShowFollowingState extends State<ShowFollowing> {
  final userController = Get.find<UserController>();

  List usersList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userController.appUser.followingList
        .contains(userController.appUser.id)) {
      // setState(() {});
      userController.appUser.followingList.remove(userController.appUser.id);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (!userController.appUser.followingList
        .contains(userController.appUser.id)) {
      // setState(() {});
      userController.appUser.followingList.add(userController.appUser.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .where("id", whereIn: userController.appUser.followingList)
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
      appBar: AppBar(title: const Text("Following")),
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
            child: ListTile(
              title: Text(user.email),
              subtitle: Text(user.displayName),
              trailing: FollowWidget(userModel: usersList[index]),
            ),
          );
        },
      ),
    );
  }
}
