import 'dart:io';

import 'package:commentor/src/central/services/image_service.dart';
import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/controllers/edit_profile_controller.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  final editProfileController = Get.find<EditProfileController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                editProfileController.updateDetails();
              },
              child: Text("Update"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            GetBuilder<EditProfileController>(
              id: 'PROFILE_PIC',
              builder: (_) => Column(
                children: [
                  if (editProfileController.isProfilePicPickedFromGallery)
                    CircleAvatar(
                      radius: 50,
                      child: Image.file(
                        File(editProfileController.profilePicPath),
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: 50,
                      child: userController.appUser.profilePic == ""
                          ? ClipOval(
                              child: Image.asset(
                                  'assets/images/default_profile_pic.png'),
                            )
                          : ClipOval(
                              child: Image.network(
                                  userController.appUser.profilePic),
                            ),
                    ),
                ],
              ),
            ),
            vSizedBox1,
            ElevatedButton(
                onPressed: () {
                  editProfileController.getImagesFromGallery();
                },
                child: Text("Change Profile Pic")),
            vSizedBox1,
            TextField(
              controller: editProfileController.displayNameCtrl,
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                labelText: "*Display Name",
                hintText: "eg. Satya",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            TextField(
              controller: editProfileController.userNameCtrl,
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                labelText: "*Username",
                hintText: "",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            TextField(
              controller: editProfileController.bioCtrl,
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                labelText: "bio",
                hintText: "",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
