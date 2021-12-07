import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileCount extends StatelessWidget {
  UserModel userModel;
  ProfileCount({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _profileComponent({required double count, required String title}) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$count k",
            // style: KCustomTextstyle.kBold(context, 12),
          ),
          Text(
            title,
            // style: KCustomTextstyle.kMedium(context, 10),
          )
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _profileComponent(count: 0, title: "Followers"),
        _profileComponent(count: 0, title: "Following"),
        _profileComponent(count: 0, title: "Comments"),
        _profileComponent(count: 0, title: "Likes"),
      ],
    );
  }
}
