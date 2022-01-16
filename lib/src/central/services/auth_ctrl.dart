import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentor/src/controllers/user_controller.dart';
import 'package:commentor/src/models/user_model.dart';
import 'package:commentor/src/pages/bottom_bar/my_bottom_bar.dart';
import 'package:commentor/src/pages/sign_in_screen/login_screen.dart';
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
  final userCtrl = Get.find<UserController>();

  ///for sign up page
  TextEditingController signinEmailTextController = TextEditingController();
  TextEditingController signinPasswordTextController = TextEditingController();
  TextEditingController signinFullNameTextController = TextEditingController();

  ///for login page
  TextEditingController loginEmailTextController = TextEditingController();
  TextEditingController loginPasswordTextController = TextEditingController();

  checkUser(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      feedUserData(user);
      logger.d("user isn't null");

      logger.d("user email is verified. checking user exists in db");
      if (await checkUserExistsInDb() == false) {
        await createUserDb();
      } else {
        await deserializeUserInApp(user);
      }

      logger.d("User exists in db. Nav to MyBottomBar()");
      Get.offAll(() => MyBottomBar());
    } else {
      logger.d("user is singout");
      Get.offAll(() => LoginScreen());
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
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
      }

      return user;
    }
  }

  feedUserData(User? user) {
    final userController = Get.find<UserController>();

    userController.appUser.id = user!.uid;
    userController.appUser.email = user.email!;
    userController.appUser.displayName =
        user.displayName ?? signinFullNameTextController.text;
    userController.appUser.profilePic = user.photoURL ?? "";
  }

  deserializeUserInApp(User user) async {
    await usersCol.doc(user.uid).get().then(
          (value) => userCtrl.appUser = UserModel.fromJson(
            value.data() as Map<String, dynamic>,
          ),
        );
    userCtrl.appUser.followingList.addIf(
      !userCtrl.appUser.followingList.contains(userCtrl.appUser.id),
      userCtrl.appUser.id,
    );
    userCtrl.appUser.followersList.addIf(
      !userCtrl.appUser.followersList.contains(userCtrl.appUser.id),
      userCtrl.appUser.id,
    );
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      UserModel myUser =
          UserModel(followersList: [], followingList: [], storiesList: []);
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

  // createUserUsingEmail(String email, String password) async {
  //   logger.d("in createUserUsingEmail");
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  // logger.d("users created");
  // if (userCredential.user != null) {
  //   if (!userCredential.user!.emailVerified) {
  //     logger.d("user email not verified, sending verification email");
  //     messageStr =
  //         "Verification link sent to this email. Click to verify then login again.";
  //     update(["authMsgId"]);
  //     await userCredential.user!.sendEmailVerification();
  //     debugPrint("verification link sent");
  //     return;
  //   }
  //   logger.d("navigating to BottomBar()");
  //   // feedUserData(userCredential.user);
  //   // await createUserDb();
  //   Get.offAll(() => MyBottomBar());
  // }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       logger.d('The password provided is too weak.');
  //       messageStr = "Week password. Write strong password";
  //       update(["authMsgId"]);
  //     } else if (e.code == 'email-already-in-use') {
  //       logger.d('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }

  // singInUsingEmail(String email, String password) async {
  //   logger.d("in signInUsingEmail", email);
  //   isSigningIn = true;
  //   update(["loginBtnId"]);
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);

  //     if (userCredential.user != null) {
  //       feedUserData(userCredential.user);

  //       if (!userCredential.user!.emailVerified) {
  //         logger.d("user email not verified, sending verification email");
  //         messageStr =
  //             "Verification link sent to this email. Click to verify then login again.";
  //         update(["authMsgId"]);

  //         await userCredential.user!.sendEmailVerification();
  //         debugPrint("verification link sent");
  //         return;
  //       }
  //       await createUserDb();
  //       logger.d("navigating to MyBottomBar()");
  //       messageStr = "";
  //       update(["authMsgId"]);

  //       Get.offAll(() => MyBottomBar());
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       logger.d('No user found for that email.');

  //       createUserUsingEmail(email, password);
  //     } else if (e.code == 'wrong-password') {
  //       logger.d('Wrong password provided for that user.');
  //       messageStr = "Wrong password";
  //       update(["authMsgId"]);
  //     }
  //   } finally {
  // isSigningIn = false;
  // update(["loginBtnId"]);
  //   }
  // }

  createUserWithEmailPassword() async {
    if (signinEmailTextController.text == "" ||
        signinPasswordTextController.text == "" ||
        signinFullNameTextController.text == "") {
      Get.snackbar("Opps", "All *marked fields are required");
      return;
    }
    isSigningIn = true;
    update(["SIGN_IN_BTN"]);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signinEmailTextController.text,
        password: signinPasswordTextController.text,
      );
      logger.d("users created");
      if (userCredential.user != null) {
        logger.d("navigating to BottomBar()");
        feedUserData(userCredential.user);
        await createUserDb();
        await deserializeUserInApp(userCredential.user!);
        Get.offAll(() => MyBottomBar());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Opps", 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Opps", 'The account already exists for that email.');
      }
    } catch (e) {
      logger.d(e);
      Get.snackbar("Opps", e.toString());
    } finally {
      isSigningIn = false;
      update(["SIGN_IN_BTN"]);
    }
  }

  loginWithEmailPassword() async {
    if (loginEmailTextController.text == "" ||
        loginPasswordTextController.text == "") {
      Get.snackbar("Opps", "All *marked fields are required");
      return;
    }
    isSigningIn = true;
    update(["LOGIN_BTN"]);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginEmailTextController.text,
              password: loginPasswordTextController.text);
      if (userCredential.user != null) {
        logger.d("navigating to BottomBar()");
        // feedUserData(userCredential.user);
        await deserializeUserInApp(userCredential.user!);
        Get.offAll(() => MyBottomBar());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Have you registered?', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Opps!', 'Wrong password');
      }
    } finally {
      isSigningIn = false;
      update(["LOGIN_BTN"]);
    }
  }

  CollectionReference usersCol = FirebaseFirestore.instance.collection('users');
  checkUserExistsInDb() async {
    // String userId = "";
    DocumentSnapshot<Object?> userDb =
        await usersCol.doc(userCtrl.appUser.id).get();
    return userDb.exists ? true : false;
  }

  createUserDb() async {
    logger.d("creating createUserDb");
    userCtrl.appUser.followingList.addIf(
      !userCtrl.appUser.followingList.contains(userCtrl.appUser.id),
      userCtrl.appUser.id,
    );
    await usersCol.doc(userCtrl.appUser.id).set(userCtrl.appUser.toJson());
  }
}
