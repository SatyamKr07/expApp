import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:flutter/material.dart';

import 'components/profile_body.dart';
import 'components/profile_count.dart';
import 'components/profile_header.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    _divider() {
      return Divider(
        thickness: 0.1,
        // color: KConstantColors.conditionalColor(context: context),
      );
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     BlocProvider.of<AuthenticationCubit>(context, listen: false)
      //         .fetchLoggedUser(context: context);
      //   },
      // ),
      // backgroundColor: KConstantColors.bgColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox1,
                  ProfileHeader(),
                  // _divider(),
                  vSizedBox1,
                  ProfileCount(),
                  vSizedBox1,
                  _divider(),
                  ProfileBody()
                ]),
          ),
        ),
      ),
    );
  }
}
