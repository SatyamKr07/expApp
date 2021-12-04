import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:commentor/src/pages/bottom_bar/my_bottom_bar.dart';
import 'package:commentor/src/pages/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './my_logger.dart';

class AuthCtrl extends GetxController {
  String messageStr = "";
  bool isSigningIn = false;

  checkUser(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      feedUserData(user);
      logger.d("user isn't null");
      if (!user.emailVerified) {
        logger.d(
            "user email ${user.email} not verified, sending verification email");
        messageStr =
            "Verification link sent to this email. Click to verify then login again.";
        update(["authMsgId"]);
        try {
          await user.sendEmailVerification();
          user.reload();

          debugPrint("verification link sent");
        } catch (e) {
          logger.e(e);
          messageStr = e.toString();
          update(["authMsgId"]);
        } finally {
          Get.offAll(() => SignInScreen());
        }
      } else {
        logger.d("user email is verified. checking user exists in db");
        if (await checkUserExistsInDb() == false) {
          await createUserDb();
        } else {
          await deserializeUserInApp(user);
        }

        logger.d("User exists in db. Nav to MyBottomBar()");
        Get.offAll(() => MyBottomBar());
      }
    } else {
      logger.d("user is singout");
      Get.offAll(() => SignInScreen());
    }
  }

  deserializeUserInApp(User user) {
    usersCol.doc(user.uid).get().then(
          (value) => userCtrl.appUser = UserModel.fromJson(
            value.data() as Map<String, dynamic>,
          ),
        );
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
        feedUserData(user);
      } catch (e) {
        logger.e(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
          // logger.d('appUser is ${userController.appUser}');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              AuthCtrl.customSnackBar(
                content:
                    'The account already exists with a different credential.',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              AuthCtrl.customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthCtrl.customSnackBar(
              content: 'Error occurred using Google Sign-In. Try again.',
            ),
          );
        }
        feedUserData(user);
      }

      return user;
    }
  }

  static feedUserData(User? user) {
    final userController = Get.find<UserController>();
    userController.appUser.id = user!.uid;
    userController.appUser.email = user.email!;
    userController.appUser.displayName = user.displayName ?? "";
    userController.appUser.profilePic = user.photoURL ?? "";
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      UserModel myUser = UserModel();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthCtrl.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  createUserUsingEmail(String email, String password) async {
    logger.d("in createUserUsingEmail");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      logger.d("users created");
      if (userCredential.user != null) {
        if (!userCredential.user!.emailVerified) {
          logger.d("user email not verified, sending verification email");
          messageStr =
              "Verification link sent to this email. Click to verify then login again.";
          update(["authMsgId"]);
          await userCredential.user!.sendEmailVerification();
          debugPrint("verification link sent");
          return;
        }
        logger.d("navigating to BottomBar()");
        Get.offAll(() => MyBottomBar());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.d('The password provided is too weak.');
        messageStr = "Week password. Write strong password";
        update(["authMsgId"]);
      } else if (e.code == 'email-already-in-use') {
        logger.d('The account already exists for that email.');
      }
    } catch (e) {
      logger.e(e);
    }
  }

  singInUsingEmail(String email, String password) async {
    logger.d("in signInUsingEmail", email);
    isSigningIn = true;
    update(["loginBtnId"]);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        feedUserData(userCredential.user);
        if (!userCredential.user!.emailVerified) {
          logger.d("user email not verified, sending verification email");
          messageStr =
              "Verification link sent to this email. Click to verify then login again.";
          update(["authMsgId"]);

          await userCredential.user!.sendEmailVerification();
          debugPrint("verification link sent");
          return;
        }
        logger.d("navigating to MyBottomBar()");
        messageStr = "";
        update(["authMsgId"]);

        Get.offAll(() => MyBottomBar());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.d('No user found for that email.');

        createUserUsingEmail(email, password);
      } else if (e.code == 'wrong-password') {
        logger.d('Wrong password provided for that user.');
        messageStr = "Wrong password";
        update(["authMsgId"]);
      }
    } finally {
      isSigningIn = false;
      update(["loginBtnId"]);
    }
  }

  CollectionReference usersCol = FirebaseFirestore.instance.collection('users');
  checkUserExistsInDb() async {
    // String userId = "";
    DocumentSnapshot<Object?> userDb =
        await usersCol.doc(userCtrl.appUser.id).get();
    return userDb.exists ? true : false;
  }

  final userCtrl = Get.find<UserController>();
  createUserDb() async {
    logger.d("creating createUserDb");
    await usersCol.doc(userCtrl.appUser.id).set(userCtrl.appUser.toJson());
  }
}
