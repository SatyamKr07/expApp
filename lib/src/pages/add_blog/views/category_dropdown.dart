import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class CategoryDropdown extends StatelessWidget {
  CategoryDropdown({Key? key}) : super(key: key);
  final addBlogController = Get.find<AddBlogController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GetBuilder<AddBlogController>(
        id: "CATEGORY_DROPDOWN",
        builder: (_) => DropdownButton<String>(
          value: addBlogController.blogModel.category,
          onChanged: addBlogController.selectCategory,
          items: const [
            DropdownMenuItem(
              value: "*choose category",
              child: Text('*Choose Category'),
            ),
            DropdownMenuItem(
              value: "sports",
              child: Text('Sports'),
            ),
            DropdownMenuItem(
              value: "movies",
              child: Text('Movies'),
            ),
          ],
        ),
      ),
    );
  }
}
