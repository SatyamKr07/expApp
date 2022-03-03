import '../../../controllers/add_post_controller.dart';
import '../../../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class WriteCommentArea extends StatelessWidget {
  WriteCommentArea({Key? key, required this.postId}) : super(key: key);
  final addPostController = Get.find<AddPostController>();
  String postId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            const SizedBox(width: 15),
            const Icon(Icons.comment),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  // onTap: () => discussCtrl?.scrollToTop(),
                  onTap: () {
                    // setState(() {
                    //   logger.d('write comment textField');
                    // });
                    // addPostController.commentTextCtrl = TextEditingController();
                  },
                  maxLines: null,
                  // style: const TextStyle(color: Colors.black38, fontSize: 15),
                  controller: addPostController.commentTextCtrl,
                  decoration: const InputDecoration.collapsed(
                    border: UnderlineInputBorder(),
                    hintText: 'Type your comment here',
                    // hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                addPostController.postComment(postId: postId);
              },
            ),
          ],
        ),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(25))

            // color: Colors.white,
            ),
      ),
    );
  }
}
