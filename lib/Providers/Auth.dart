import 'package:chatapp/Providers/User.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  User? _currntUser;
  String _token = "";

  ///login and get
  Future login() async {
    //send http request to login
    final response = await http.get(Uri(), headers: {});
    final data = json.decode(response.body);

    //initial current user
    _currntUser = User(
      data["id"],
      data["name"],
      data["lastSeen"].toDate(),
      data["bio"],
      data["username"],
      Map<String, String>.from(data["profileUrls"]).values.toList(),
    );
    _token = data["token"];

    //save login data on device
    final shp = await SharedPreferences.getInstance();
    final userData = json.encode({
      "token": data["token"],
      "id": data["id"],
      "username": data["usename"],

      //password will be replace by sms validation
      "password": data[""],
    });
    await shp.setString("UserData", userData);

    notifyListeners();
  }

  ///auto login by data saved on device.
  ///
  ///Future Feature:
  ///* offline login
  ///*
  Future<bool> tryAutoLogin() async {
    try {
      //read login data from device
      final shp = await SharedPreferences.getInstance();
      //check for data
      if (!shp.containsKey("UserData")) return false;
      final userData =
          Map<String, Object>.from(json.decode(shp.getString("UserData")!));

      //send http request to read user data
      final response = await http.get(Uri.parse(""), headers: {});
      final data = json.decode(response.body);
      _currntUser = User(
        data["id"],
        data["name"],
        data["lastSeen"].toDate(),
        data["bio"],
        data["username"],
        Map<String, String>.from(data["profileUrls"]).values.toList(),
      );
      _token = data["token"];
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) print("##### $e");
      return false;
    }
  }

  Future logout() async {
    //final response = await http.logout()...

    //remove login data from device
    final shp = await SharedPreferences.getInstance();
    await shp.remove("UserData");
    notifyListeners();
  }

  User? get currentUser {
    return _currntUser;
  }

  String get token {
    return _token;
  }

  bool isAuth() {
    return _currntUser == null ? false : true;
  }
}
