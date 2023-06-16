import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'home_calender.dart';
import 'login_screen.dart';

class FirebaseService {
  bool islogin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ignore: body_might_complete_normally_nullable
  Future<String?> signInwithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
      deciderout(context);
    } on FirebaseAuthException catch (e) {
      log('${e.message}');
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  deciderout(context) {
    Get.to(() => Home());
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => Home()),
    //     (Route<dynamic> route) => false);
  }

  Future<void> signOutFromGoogle(context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    Get.offAll(() => const LoginScreen());
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false);
  }
}
