// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class PostModel {
  PostModel(
      {this.title = "",
      this.description = "",
      required this.picList,
      this.category = "",
      required this.postedBy,
      required this.postedOn,
      this.postId = ''});

  String title;
  String description;
  List<String> picList;
  String category;
  UserModel postedBy;
  DateTime postedOn;
  String postId;

  factory PostModel.fromJson(Map<String, dynamic> json, DocumentSnapshot doc) =>
      PostModel(
        title: json["title"],
        description: json["description"],
        picList: List<String>.from(json["picList"].map((x) => x)),
        category: json["category"],
        postedBy: UserModel.fromJson(json['postedBy']),
        postedOn: json['postedOn'].toDate(),
        postId: doc.id,
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
