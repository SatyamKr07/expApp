// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

PostModel blogModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String blogModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.title = "",
    this.description = "",
    required this.picList,
    this.category = "",
    required this.postedBy,
    required this.postedOn,
  });

  String title;
  String description;
  List<String> picList;
  String category;
  UserModel postedBy;
  DateTime postedOn;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        title: json["title"],
        description: json["description"],
        picList: List<String>.from(json["picList"].map((x) => x)),
        category: json["category"],
        postedBy: UserModel.fromJson(json['postedBy']),
        postedOn: (json['postedOn']).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "picList": List<dynamic>.from(picList.map((x) => x)),
        "category": category,
        "postedBy": postedBy.toJson(),
        "postedOn": postedOn,
      };
}
