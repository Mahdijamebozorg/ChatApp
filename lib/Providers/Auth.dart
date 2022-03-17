import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      false,
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
      false,
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
