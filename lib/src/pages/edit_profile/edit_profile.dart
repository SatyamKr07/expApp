import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: ListView(
        children: [
          TextField(
            // controller: addBlogController.descCtrl,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              labelText: "*Description",
              hintText: "Description",
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
