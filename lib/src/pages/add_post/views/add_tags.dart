import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTags extends StatelessWidget {
  AddTags({Key? key}) : super(key: key);
  final addBlogController = Get.find<AddPostController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Add Tags"),
          TextField(
            controller: addBlogController.tag1TextCtrl,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              labelText: "Tag 1",
              hintText: "Tag 1",
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextField(
            controller: addBlogController.tag2TextCtrl,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              labelText: "Tag 2",
              hintText: "Tag 2",
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextField(
            controller: addBlogController.tag3TextCtrl,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              labelText: "Tag 3",
              hintText: "Tag 3",
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
