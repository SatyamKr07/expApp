import 'package:commentor/src/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogDescription extends StatefulWidget {
  final PostModel blogModel;
  const BlogDescription({
    Key? key,
    required this.blogModel,
  }) : super(key: key);

  @override
  State<BlogDescription> createState() => _BlogDescriptionState();
}

class _BlogDescriptionState extends State<BlogDescription> {
  bool isExpanded = false;
  int descMaxLines = 2;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          isExpanded = !isExpanded;
          setState(() {});
        },
        child: buildDesc());
  }

  buildDesc() {
    return InkWell(
      onTap: () {
        setState(() {
          descMaxLines = descMaxLines == 2 ? 1000 : 2;
        });
      },
      child: Text(
        widget.blogModel.description,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 15),
        maxLines: descMaxLines,
      ),
    );
  }
}
