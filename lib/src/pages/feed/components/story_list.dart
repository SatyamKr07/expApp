import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StoryListView extends StatefulWidget {
  @override
  _StoryListViewState createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 6.h,
      child: Row(
        children: [
          // Expanded(
          //   flex: 1,
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 4),
          //       child: CircleAvatar(
          //           backgroundColor: Colors.deepPurpleAccent, radius: 3.h),
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                        backgroundColor: Colors.deepPurpleAccent,
                        radius: 3.h),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
