import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chatapp/Widgets/AuthForm.dart';
import 'package:chatapp/Models/ConnectivityState.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = "/AuthenticationScreen";
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  ConnectivityState _connectivityState = ConnectivityState.waiting;

  Future<bool> _submitAuthForm(
    String email,
    String name,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    firebaseAuth.UserCredential res;

    try {
      if (isLogin) {
        res =
            await firebaseAuth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore.instance.collection("User").doc(res.user!.uid);
      } else {
        res = await firebaseAuth.FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //create a table with user id
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(res.user!.uid)
            .set({
          "name": name,
          "username": "",
          "bio": "",
          "lastSeen": Timestamp.fromDate(DateTime.now()),
          "profileUrls": {},
        }).then((value) {
          if (kDebugMode) print("***** Data created for ${res.user!.uid}");
        });
      }
      return true;
    }
    //firebase exceptins
    on PlatformException catch (e) {
      String errorMessage =
          e.message == null ? "Authentication failed!" : e.message!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Theme.of(context).errorColor,
          content: Text(errorMessage),
        ),
      );
      return false;
    }
    //other exceptions
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Theme.of(context).errorColor,
          content: Text(e.toString()),
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Future Features:
      ///*connection status will be added
      appBar: AppBar(
        title: Text(getConnectivityState(_connectivityState)),
      ),
      body: AuthForm(_submitAuthForm),
    );
  }
}
