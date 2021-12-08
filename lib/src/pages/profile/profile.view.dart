import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'components/profile_body.dart';
import 'components/profile_count.dart';
import 'components/profile_header.dart';

class ProfileView extends StatefulWidget {
  String userId;
  ProfileView({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final userController = Get.find<UserController>();
  UserModel userModel = UserModel(followersList: [], followingList: [], storiesList: []);
  @override
  void initState() {
    super.initState();
    if (widget.userId == userController.appUser.id) {
      userModel = userController.appUser;
    } 
    // else {
    //   userController.getUserProfile(userId: widget.userId);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     BlocProvider.of<AuthenticationCubit>(context, listen: false)
        //         .fetchLoggedUser(context: context);
        //   },
        // ),
        // backgroundColor: KConstantColors.bgColor,
        body: widget.userId == userController.appUser.id
            ? profileWidget()
            : FutureBuilder<DocumentSnapshot>(
                future: userController.getUserProfile(userId: widget.userId),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    userModel = UserModel.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>,
                    );
                    // userModel = snapshot.data as UserModel;
                    // User user = snapshot.data as User;
                    // return Text(user.email.toString(),
                    //     style: KCustomTextstyle.kBold(context, 12),);
                    return profileWidget();
                  }
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  );
                }),
      ),
    );
  }

  Widget profileWidget() {
    _divider() {
      return Divider(
        thickness: 0.1,
        // color: KConstantColors.conditionalColor(context: context),
      );
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox1,
                ProfileHeader(
                  userModel: userModel,
                ),
                // _divider(),
                vSizedBox1,
                ProfileCount(
                  userModel: userModel,
                ),
                vSizedBox1,
                _divider(),
                ProfileBody(
                  userModel: userModel,
                )
              ]),
        ),
      ),
    );
  }
}
