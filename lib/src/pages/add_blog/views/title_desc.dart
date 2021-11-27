import 'package:commentor/src/controllers/add_blog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TitleDesc extends StatelessWidget {
  TitleDesc({Key? key}) : super(key: key);
  final addBlogController = Get.find<AddBlogController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: addBlogController.titleCtrl,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              labelText: "*Title",
              // hintText: "Title",
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextFormField(
            controller: addBlogController.descCtrl,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              labelText: "*Description",
              hintText: "Description",
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
