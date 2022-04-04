import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chatapp/Providers/User.dart';

class Auth with ChangeNotifier {
  String _token = "";

  User? currentUser;

  //a temp user for testing
  Auth() {
    currentUser = User(
      "P1",
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
    return currentUser!.id;
  }

  String get token {
    return _token;
  }

  bool isAuth() {
    return currentUser != null;
  }
}
