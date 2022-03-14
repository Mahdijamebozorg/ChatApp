import 'package:flutter/material.dart';
import 'package:chatapp/Models/User.dart';

class Auth with ChangeNotifier {
  User? currentUser = User(
    name: "Mahdi",
    id: "p1",
    lastSeen: DateTime.now(),
    bio: "bio",
    username: "username",
    profileUrls: [],
  ); //teset
  String token = "";

  bool isAuth() {
    return currentUser != null;
  }
}
