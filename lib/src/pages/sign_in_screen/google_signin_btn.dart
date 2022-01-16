import 'package:commentor/src/central/services/auth_ctrl.dart';
import 'package:commentor/src/central/shared/dimensions.dart';
import 'package:commentor/src/pages/bottom_bar/my_bottom_bar.dart';
import 'package:commentor/src/pages/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;
  AuthCtrl authentication = AuthCtrl();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: _isSigningIn
          ? Center(
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : Column(
              children: [
                Text("Or, login with..."),
                vSizedBox2,
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.email,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff212228),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        side: BorderSide(color: Color(0xffEB1047)),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _isSigningIn = true;
                      });

                      User? user =
                          await AuthCtrl.signInWithGoogle(context: context);

                      setState(() {
                        _isSigningIn = false;
                      });

                      if (user != null) {
                        if (await authentication.checkUserExistsInDb() ==
                            false) {
                          await authentication.createUserDb();
                        }
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(builder: (context) => Home()),
                        // );
                        Get.offAll(() => MyBottomBar());
                      }
                    },
                    label: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Login with GMail',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
