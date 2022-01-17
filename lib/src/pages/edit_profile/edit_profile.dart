import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:commentor/src/central/services/image_service.dart';
import 'package:commentor/src/central/services/my_logger.dart';
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
    return GetBuilder<EditProfileController>(
        id: 'PROFILE_PAGE',
        builder: (_) => editProfileController.updateStatus == "UPDATING"
            ? Material(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Plese Wait..."),
                      vSizedBox2,
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text("Edit Profile"),
                  actions: const [],
                ),
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            GetBuilder<EditProfileController>(
                              id: 'PROFILE_PIC',
                              builder: (_) => Column(
                                children: [
                                  if (editProfileController
                                      .isProfilePicPickedFromGallery)
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(
                                        File(editProfileController
                                            .profilePicPath),
                                        // fit: BoxFit.cover,
                                      ),
                                    )
                                  else
                                    CircleAvatar(
                                      radius: 50,
                                      child: userController
                                                  .appUser.profilePic ==
                                              ""
                                          ? const ClipOval(
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                    'assets/images/default_profile_pic.png'),
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: userController
                                                  .appUser.profilePic,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 100.0,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              // errorWidget: Image.asset(
                                              //               'assets/images/default_profile_pic.png'),
                                            ),
                                    ),
                                ],
                              ),
                            ),
                            vSizedBox1,
                            TextButton(
                                onPressed: () {
                                  editProfileController.getImagesFromGallery();
                                },
                                child: Text("Change Profile Pic",
                                    style: TextStyle(color: Colors.red))),
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
                            vSizedBox1,
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
                            vSizedBox1,
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
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      SizedBox(
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GetBuilder<EditProfileController>(
                            id: 'PROFILE_PAGE',
                            builder: (_) => ElevatedButton(
                              onPressed: editProfileController.updateStatus ==
                                      "UPDATING"
                                  ? null
                                  : () async {
                                      await editProfileController
                                          .updateDetails()
                                          .then((value) {
                                        logger.d('update button clicked');
                                        if (editProfileController
                                                .updateStatus ==
                                            "UPDATED") {
                                          var d = value;
                                          logger.d('value is $d');
                                          logger.d("UPDATED");
                                          Get.back();
                                          Get.back();
                                        }
                                      });
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff212228),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  side: BorderSide(color: Color(0xffEB1047)),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  editProfileController.updateStatus ==
                                          "UPDATING"
                                      ? "Saving"
                                      : "Save Changes",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
