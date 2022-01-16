import 'package:commentor/src/controllers/add_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class AddPic extends StatelessWidget {
  AddPic({Key? key}) : super(key: key);
  final addBlogController = Get.find<AddPostController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () async {
                await addBlogController.pickImageFromGallery();
              },
              icon: const Icon(
                Icons.photo_outlined,
                color: Color(0xff6485AC),
                // color: Colors.white,

                size: 32,
              ),
            ),
            IconButton(
              onPressed: () async {
                // await addExchangeCtrl.pickMultiFiles();
                await addBlogController.pickVideoFromGallery();
              },
              icon: const Icon(
                Icons.video_collection,
                color: Color(0xff6485AC),
                // color: Colors.white,
                size: 32,
              ),
            ),
            // IconButton(
            //   onPressed: () async {
            //     await addBlogController.clickBlogPhoto();
            //   },
            //   icon: const Icon(
            //     Icons.camera_alt_outlined,
            //     color: Colors.black,
            //     size: 32,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
