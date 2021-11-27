class UserModel {
  UserModel({
    this.id = "",
    this.displayName = "No display name",
    this.email = "No email",
    this.profilePic = "No profile pic",
  });

  String id;
  String displayName;
  String email;
  String profilePic;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        displayName: json["displayName"],
        email: json["email"],
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "email": email,
        "profilePic": profilePic,
      };
}
