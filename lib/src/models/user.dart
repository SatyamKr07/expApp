import 'package:commentor/src/models/story_model.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String imgUrl;
  final List<StoryModel> stories;

  const User({
    required this.name,
    required this.imgUrl,
    required this.stories,
  });
}
