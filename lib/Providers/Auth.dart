import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/Providers/User.dart';

class Auth with ChangeNotifier {
  String _userId = "";
  String _token = "";

  User? currentUser;

  //a temp user for testing
  Auth() {
    currentUser = User(
      token,
      "p1",
      "Mahdi",
      DateTime.now(),
      "bio",
      "username",
      [],
    );
  }

  ///login and get
  Future login() async {
    final response = await http.read(Uri(), headers: {});
    final data = json.decode(response);
    currentUser = User(
      token,
      data["id"],
      data["name"],
      DateTime.now(),
      data["bio"],
      data["username"],
      data["profiles"],
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
