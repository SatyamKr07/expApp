// To parse this JSON data, do
//
//     final mediaModel = mediaModelFromJson(jsonString);

import 'dart:convert';

// MediaModel mediaModelFromJson(String str) =>
//     MediaModel.fromJson(json.decode(str));

// String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel {
  MediaModel({
    this.type = "image",
    this.url = "",
  });

  String type;
  var url;

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
      };
}
