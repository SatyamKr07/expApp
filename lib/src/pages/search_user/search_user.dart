import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/central/services/user_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  String userEmailQuery = "";
  List usersList = [];
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          maxLines: null,
          decoration: const InputDecoration(
            labelStyle: TextStyle(
              // color: Colors.grey,
              fontSize: 14,
            ),
            labelText: "Search using email id",
            hintText: "email id",
            hintStyle: TextStyle(
              // color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          onChanged: (val) {
            userEmailQuery = val;
            setState(() {});
          },
        ),
      ),
      body: StreamBuilder(
        stream: userController.filterUser(userEmailQuery),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            usersList = snapshot.data!.docs.map((DocumentSnapshot document) {
              return UserModel.fromJson(
                  document.data() as Map<String, dynamic>);
            }).toList();
            return usersListView(usersList);
          } else if (snapshot.hasError) {
            return const Text("Some error occured");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget usersListView(List usersList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: usersList.length,
      itemBuilder: (BuildContext context, int index) {
        UserModel user = usersList[index];
        return ListTile(
          title: Text(user.email),
          subtitle: Text(user.displayName),
        );
      },
    );
  }
}
