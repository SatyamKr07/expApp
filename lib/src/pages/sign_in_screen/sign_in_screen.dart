import '../../central/services/auth_ctrl.dart';
import '../../central/shared/dimensions.dart';
import 'google_signin_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final authCtrl = Get.find<AuthCtrl>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1F24),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              GoogleSignInButton(text: "Register with GMail"),
              vSizedBox3,
              Center(
                child: Text(
                  "Or register with email...",
                  style: TextStyle(
                    color: Color(0xff5C7A9E),
                  ),
                ),
              ),
              vSizedBox3,
              TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: '*Full Name',
                ),
                onChanged: (val) {
                  authCtrl.signinFullNameTextController.text = val;
                  // email = val;
                },
              ),
              vSizedBox3,
              TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email_sharp),
                  hintText: '*Email',
                ),
                onChanged: (val) {
                  authCtrl.signinEmailTextController.text = val;
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
                  authCtrl.signinPasswordTextController.text = val;
                  // password = val;
                },
              ),
              vSizedBox3,
              GetBuilder<AuthCtrl>(
                  id: "SIGN_IN_BTN",
                  builder: (_) {
                    return _.isSigningIn
                        ? Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue))
                        : SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: const Text("Register",
                                      style: TextStyle(fontSize: 16)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  primary: Colors.red,
                                ),
                                onPressed: () {
                                  authCtrl.createUserWithEmailPassword();
                                  // Authentication authentication = Authentication();

                                  // authCtrl.singInUsingEmail(email, password);
                                }),
                          );
                  }),
              InkWell(
                onTap: () {
                  Get.back();
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
                            text: 'Already a User ? ',
                            // style: DefaultTextStyle.of(context).style,
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'Login',
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
            ],
          ),
        ),
      ]),
    );
  }
}
