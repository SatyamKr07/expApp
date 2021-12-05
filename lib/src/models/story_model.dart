class StoryModel {
  StoryModel({
    this.imageUrl = "",
  });

  String imageUrl;

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
      };
}



// enum MediaType { image, text }

// class StoryModel {
//   final MediaType mediaType;
//   final String url;
//   final double duration;
//   final String caption;
//   final String date;
//   final Color color;

//   StoryModel({
//     required this.mediaType,
//     required this.caption,
//     required this.date,
//     this.url="",
//     this.duration = 5.0,
//     this.color = Colors.grey,
//   });
// }
