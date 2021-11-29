// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  CommentModel({
    this.commentText = "",
    this.userId = "",
    this.userName = "",
    this.postId = "",
    required this.timestamp,
    this.likes = 0,
  });

  String commentText;
  String userId;
  String userName;
  String postId;
  Timestamp timestamp;
  int likes;

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentText: json["commentText"],
        userId: json["userId"],
        userName: json["userName"],
        postId: json["postId"],
        timestamp: json["timestamp"],
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "commentText": commentText,
        "userId": userId,
        "userName": userName,
        "postId": postId,
        "timestamp": timestamp,
        "likes": likes,
      };
}
