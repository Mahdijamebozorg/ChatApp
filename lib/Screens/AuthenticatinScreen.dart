import 'package:chatapp/Widgets/AuthForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = "/AuthenticationScreen";
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  Future<bool> _submitAuthForm(
    String email,
    String name,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    UserCredential res;

    try {
      if (isLogin) {
        res = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
          backgroundColor: Theme.of(context).errorColor,
          content: Text(errorMessage),
        ),
      );
      return false;
    }
    //other exceptions
    catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Future Features:
      ///*connection status will be added
      appBar: AppBar(
        title: Text("Status"),
      ),
      body: AuthForm(_submitAuthForm),
    );
  }
}
