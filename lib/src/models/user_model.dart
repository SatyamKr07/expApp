// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'story_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id = "",
    this.username = "",
    this.displayName = "",
    this.bio = "",
    this.email = "",
    this.profilePic = "",
    this.topCommentsCount = 0,
    this.trendingCommentsCount = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.totalCommentsCount = 0,
    this.totalLikesCount = 0,
    this.totalPostsCount = 0,
    this.storiesList,
    this.followingList,
    this.followersList,
  });

  String id;
  String username;
  String displayName;
  String bio;
  String email;
  String profilePic;
  int topCommentsCount;
  int trendingCommentsCount;
  int followersCount;
  int followingCount;
  int totalCommentsCount;
  int totalLikesCount;
  int totalPostsCount;
  List<StoryModel>? storiesList;
  List<dynamic>? followingList;
  List<dynamic>? followersList;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? '',
        username: json["username"] ?? '',
        displayName: json["displayName"] ?? '',
        bio: json["bio"] ?? '',
        email: json["email"] ?? '',
        profilePic: json["profilePic"] ?? '',
        topCommentsCount: json["topCommentsCount"] ?? 0,
        trendingCommentsCount: json["trendingCommentsCount"] ?? 0,
        followersCount: json["followersCount"] ?? 0,
        followingCount: json["followingCount"] ?? 0,
        totalCommentsCount: json["totalCommentsCount"] ?? 0,
        totalLikesCount: json["totalLikesCount"] ?? 0,
        totalPostsCount: json["totalPostsCount"] ?? 0,
        storiesList: json["storiesList"] == null
            ? []
            : List<StoryModel>.from(
                json["storiesList"].map((x) => StoryModel.fromJson(x))),
        followingList: json["followingList"] ?? [],
        followersList: json['followersList'] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "displayName": displayName,
        "bio": bio,
        "email": email,
        "profilePic": profilePic,
        "topCommentsCount": topCommentsCount,
        "trendingCommentsCount": trendingCommentsCount,
        "followersCount": followersCount,
        "followingCount": followingCount,
        "totalCommentsCount": totalCommentsCount,
        "totalLikesCount": totalLikesCount,
        "totalPostsCount": totalPostsCount,
      };
}
