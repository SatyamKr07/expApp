// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class CommentModel {
  CommentModel({
    this.commentText = "",
    required this.postId,
    required this.timestamp,
    this.likes = 0,
    required this.postedBy,
    this.commentId = '',
  });

  String commentText;
  String postId;
  DateTime timestamp;
  int likes;
  UserModel postedBy;
  String commentId;

  factory CommentModel.fromJson(
          Map<String, dynamic> json, DocumentSnapshot doc) =>
      CommentModel(
        commentText: json["commentText"],
        timestamp: json['timestamp'].toDate(),
        likes: json["likes"],
        postedBy: UserModel.fromJson(json['postedBy']),
        postId: json["postId"],
        commentId: doc.id,
      );

  Map<String, dynamic> toJson() => {
        "commentText": commentText,
        // "postId": postId,
        "timestamp": timestamp,
        "likes": likes,
        "postedBy": postedBy.toJson(),
        "postId": postId,
      };
}
