import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/shared/dimensions.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'components/post_block.dart';
import 'components/story_list.dart';

class FeedView extends StatefulWidget {
  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    // AddpostCubit addpostCubit(bool renderUI) =>
    //     BlocProvider.of<AddpostCubit>(context, listen: renderUI);
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.bell)),
            IconButton(onPressed: () {}, icon: Icon(Icons.menu))
          ],
          automaticallyImplyLeading: false,
          title: Row(children: [
            Icon(CupertinoIcons.home, size: 16),
            hSizedBox2,
            Text(
              "Home",
            )
          ]),
          backgroundColor: Theme.of(context).backgroundColor),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          children: [
            StoryListView(),
            Divider(
              thickness: 0.1,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return PostBlock();
                },
              ),
              // child: StreamBuilder<QuerySnapshot>(
              //   stream: addpostCubit(false).fetchPosts(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //     if (snapshot.hasData) {
              //       return ListView(
              //           children: snapshot.data!.docs
              //               .map((DocumentSnapshot document) {
              //         Map<String, dynamic> data =
              //             document.data()! as Map<String, dynamic>;
              //         if (data.length == 0) {
              //           return Center(child: Text("No groups available"));
              //         }
              //         return PostBlock(data: data);
              //       }).toList());
              //     }
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   },
              // ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).pushNamed(
          //   "/add-post",
          // );
          // Get.to(() => AddPost());
        },
      ),
    );
  }
}
