import 'package:commentor/src/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentTemplate extends StatelessWidget {
  CommentTemplate({Key? key, required this.commentModel}) : super(key: key);
  CommentModel commentModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CircleAvatar(
          child: Image.network(commentModel.postedBy.profilePic),
        ),
      ),
      title: Text(commentModel.postedBy.displayName),
      subtitle: Text(commentModel.commentText),
      trailing: Icon(
        FontAwesomeIcons.heart,
        size: 18,
        color: Colors.grey,
        // color: KConstantColors.conditionalColor(context: context),
      ),
      // Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: const [
      //     Expanded(
      //       child: Icon(
      //         FontAwesomeIcons.heart,
      //         size: 18,
      //         color: Colors.grey,
      //         // color: KConstantColors.conditionalColor(context: context),
      //       ),
      //     ),
      //     Expanded(
      //       child: Text(
      //         "1234",
      //         // style: KCustomTextstyle.kMedium(context, 10),
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
