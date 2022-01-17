import 'package:commentor/src/central/services/auth_ctrl.dart';
import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:commentor/src/pages/sign_in_screen/login_screen.dart';
import 'package:commentor/src/pages/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  final authCtrl = Get.find<AuthCtrl>();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xff1A1C1E),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Row(
                    children: const [
                      Icon(Icons.settings),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // const SizedBox(height: 64),
              const SizedBox(height: 32),
              vSizedBox2,
              ListTile(
                leading: Icon(Icons.lock),
                title: Text("Change your password"),
                trailing: Icon(Icons.arrow_forward, color: Color(0xff2B313E)),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Notifications"),
                trailing: Icon(Icons.arrow_forward, color: Color(0xff2B313E)),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.help),
                title: Text("Help"),
                trailing: Icon(Icons.arrow_forward, color: Color(0xff2B313E)),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
                trailing: Icon(Icons.arrow_forward, color: Color(0xff2B313E)),
              ),
              Divider(),
              InkWell(
                onTap: () async {
                  await authCtrl.signOut(context: context);
                  userController.appUser = UserModel(
                      followersList: [], followingList: [], storiesList: []);
                  Get.offAll(() => LoginScreen());
                },
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text("Sign Out", style: TextStyle(color: Colors.red)),
                  trailing: Icon(Icons.arrow_forward, color: Color(0xff2B313E)),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
