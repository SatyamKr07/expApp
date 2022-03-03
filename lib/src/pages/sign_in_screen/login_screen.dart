import '../../central/services/auth_ctrl.dart';
import '../../central/shared/dimensions.dart';
import 'sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'google_signin_btn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authCtrl = Get.find<AuthCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1C1E),
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
                  SizedBox(height: 100),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              emailPasswordTextField(),
              const SizedBox(height: 32),
              Center(child: Text("Or Login with...")),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GoogleSignInButton(text: "Login with Gmail"),
              ),
              vSizedBox2,
              InkWell(
                onTap: () {
                  Get.to(() => SignInScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Color(0xff22242B),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'New to Commentor ? ',
                            // style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Register',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff722FF8),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
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

  emailPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email_sharp),
              hintText: '*Email',
            ),
            onChanged: (val) {
              authCtrl.loginEmailTextController.text = val;
            },
          ),
          vSizedBox3,
          TextField(
            obscuringCharacter: "*",
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: '*Password',
            ),
            onChanged: (val) {
              authCtrl.loginPasswordTextController.text = val;
            },
          ),
          SizedBox(height: 20),
          messageText(),
          SizedBox(height: 20),
          GetBuilder<AuthCtrl>(
              id: "LOGIN_BTN",
              builder: (_) {
                return _.isSigningIn
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.blue))
                    : SizedBox(
                        width: Get.width,
                        child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const Text("Login",
                                  style: TextStyle(fontSize: 16)),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              authCtrl.loginWithEmailPassword();
                              // Authentication authentication = Authentication();

                              // authCtrl.singInUsingEmail(email, password);
                            }),
                      );
              }),
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
