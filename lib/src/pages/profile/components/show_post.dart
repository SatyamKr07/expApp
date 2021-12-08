import 'package:commentor/src/models/post_model.dart';
import 'package:commentor/src/pages/home/views/post_block.dart';
import 'package:flutter/material.dart';

class ShowPost extends StatelessWidget {
  PostModel postModel;
  ShowPost({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: PostBlock(
          postModel: postModel,
        ),
      ),
    );
  }
}
