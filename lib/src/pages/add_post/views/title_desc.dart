import '../../../controllers/add_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class TitleDesc extends StatelessWidget {
  TitleDesc({Key? key}) : super(key: key);
  final addBlogController = Get.find<AddPostController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            minLines: 5,
            maxLength: 250,
            controller: addBlogController.descCtrl,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              labelText: "*Add a title",
              hintText: "Add a title",
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
