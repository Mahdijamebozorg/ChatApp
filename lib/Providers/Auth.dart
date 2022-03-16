import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/Models/User.dart';

class Auth with ChangeNotifier {
  //a temp user for testing
  User? currentUser = User(
    name: "Mahdi",
    id: "p1",
    lastSeen: DateTime.now(),
    bio: "bio",
    username: "username",
    profileUrls: [],
  );

  String _userId = "";
  String _token = "";

  ///login and get
  Future login() async {
    final response = await http.read(Uri(), headers: {});
    final data = json.decode(response);
    currentUser = User(
      id: data["id"],
      name: data["name"],
      username: data["username"],
      bio: data["bio"],
      lastSeen: DateTime.now(),
      profileUrls: data["profiles"],
    );
    notifyListeners();
  }

  Future tryAutoLogin() async {
    //
    notifyListeners();
  }

  Future logout() async {
    //final response = await http.logout()...
    notifyListeners();
  }

  String get userId {
    return _userId;
  }

  String get token {
    return _token;
  }

  bool isAuth() {
    return currentUser != null;
  }
}
