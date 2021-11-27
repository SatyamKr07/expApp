import 'package:commentor/src/central/services/auth_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'google_signin_btn.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final authCtrl = Get.find<AuthCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                children: const [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Welcome to Commentor App!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Please Sign in!',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              emailPasswordTextField(),
              const SizedBox(height: 32),

              GoogleSignInButton()
              // FutureBuilder(
              //   future: Authentication.initializeFirebase(context: context),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return const Text('Error initializing Firebase');
              //     } else if (snapshot.connectionState == ConnectionState.done) {
              //       return GoogleSignInButton();
              //     }
              //     return const CircularProgressIndicator(
              //       valueColor: AlwaysStoppedAnimation<Color>(
              //         Colors.orange,
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String email = "";
  String password = "";
  emailPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'Email'),
            onChanged: (val) {
              email = val;
            },
          ),
          TextField(
            obscuringCharacter: "*",
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Password'),
            onChanged: (val) {
              password = val;
            },
          ),
          SizedBox(height: 20),
          messageText(),
          SizedBox(height: 20),
          GetBuilder<AuthCtrl>(
              id: "loginBtnId",
              builder: (_) {
                return _.isSigningIn
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.blue))
                    : ElevatedButton(
                        child: const Text("Login/Create Account"),
                        onPressed: () {
                          // Authentication authentication = Authentication();

                          authCtrl.singInUsingEmail(email, password);
                        });
              })
        ],
      ),
    );
  }

  // final au
  messageText() {
    return GetBuilder<AuthCtrl>(
      id: "authMsgId",
      builder: (_) {
        return _.messageStr == ""
            ? Container()
            : Text(
                _.messageStr,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              );
      },
    );
  }
}
