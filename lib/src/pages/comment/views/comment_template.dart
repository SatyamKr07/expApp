import 'package:commentor/src/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentTemplate extends StatelessWidget {
  CommentTemplate({Key? key, required this.commentModel}) : super(key: key);
  CommentModel commentModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(
            "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
      ),
      title: Text(commentModel.userName),
      subtitle: Text(commentModel.commentText),
      trailing: const Icon(Icons.link),
    );
  }
}
