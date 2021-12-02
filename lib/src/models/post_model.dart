// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'media_model.dart';

class PostModel {
  PostModel({
    this.uploaderId = '',
    this.uploaderName = '',
    this.uploaderPic = '',
    this.postId = '',
    this.description = '',
    required this.mediaList,
    required this.likesArray,
    this.likesCount = 0,
    required this.postedOn,
    this.commentsCount = 0,
  });

  String uploaderId;
  String uploaderName;
  String uploaderPic;
  String postId;
  String description;
  List<MediaModel> mediaList;
  List<String> likesArray;
  int likesCount;
  DateTime postedOn;
  int commentsCount;

  factory PostModel.fromJson(Map<String, dynamic> json, DocumentSnapshot doc) =>
      PostModel(
        uploaderId: json["uploaderId"],
        uploaderName: json["uploaderName"],
        uploaderPic: json["uploaderPic"],
        postId: doc.id,
        description: json["description"],
        mediaList: json["mediaList"] == null
            ? []
            : List<MediaModel>.from(
                json["mediaList"].map((x) => MediaModel.fromJson(x))),
        likesArray: json["likesArray"] == null
            ? []
            : List<String>.from(json["likesArray"].map((x) => x)),
        likesCount: json["likesCount"],
        postedOn: json["postedOn"].toDate(),
        commentsCount: json["commentsCount"],
      );

  Map<String, dynamic> toJson() => {
        "uploaderId": uploaderId,
        "uploaderName": uploaderName,
        "uploaderPic": uploaderPic,
        // "postId": postId,
        "description": description,
        "mediaList": List<dynamic>.from(mediaList.map((x) => x.toJson())),
        "likesArray": List<dynamic>.from(likesArray.map((x) => x)),
        "likesCount": likesCount,
        "postedOn": postedOn,
        "commentsCount": commentsCount,
      };
}
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'media_model.dart';
// import 'user_model.dart';

// class PostModel {
//   PostModel({
//     this.title = "",
//     this.description = "",
//     required this.picList,
//     this.category = "",
//     required this.postedBy,
//     required this.postedOn,
//     this.postId = '',
//     required this.postLikesArray,
//     required this.uploaderId,
//     required this.mediaList,
//   });

//   String title;
//   String description;
//   List<String> picList;
//   String category;
//   UserModel postedBy;
//   DateTime postedOn;
//   String postId;
//   List<dynamic> postLikesArray;
//   String uploaderId;
//   List<MediaModel> mediaList;

//   factory PostModel.fromJson(Map<String, dynamic> json, DocumentSnapshot doc) =>
//       PostModel(
//         title: json["title"],
//         description: json["description"],
//         picList: List<String>.from(json["picList"].map((x) => x)),
//         category: json["category"],
//         postedBy: UserModel.fromJson(json['postedBy']),
//         postedOn: json['postedOn'].toDate(),
//         postId: doc.id,
//         postLikesArray: json['postLikesArray'] ?? [],
//         uploaderId: json['uploaderId'] ?? '',
//         mediaList: json["mediaList"] == null
//             ? []
//             : List<MediaModel>.from(
//                 json["mediaList"].map((x) => MediaModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "description": description,
//         "picList": List<dynamic>.from(picList.map((x) => x)),
//         "category": category,
//         "postedBy": postedBy.toJson(),
//         "postedOn": postedOn,
//         "postLikesArray": postLikesArray,
//         "uploaderId": uploaderId,
//         "mediaList": List<dynamic>.from(mediaList.map((x) => x.toJson())),
//       };
// }
