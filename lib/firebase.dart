import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sutt_task2/database.dart';
import 'package:sutt_task2/login.dart';
import 'home_page.dart';

User? user;

final FirebaseAuth fb_auth = FirebaseAuth.instance;

Future<void> login(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? account = await googleSignIn.signIn();
  if (account != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await account.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential credential =
        await fb_auth.signInWithCredential(authCredential); // error handling
    user = credential.user;
    updateName();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const Screen1();
        },
      ),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginPage();
        },
      ),
    );
  }
}
