import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  final String _id;
  String _name;
  DateTime _lastSeen;
  String _username;
  String _bio;
  List<String> _profileUrls;

  User(
    this._id,
    this._name,
    this._lastSeen,
    this._bio,
    this._username,
    this._profileUrls,
  );

  ///change user name
  Future changeName(String newName) async {
    final http.Response response = await http.post(Uri(), headers: {});
    _name = newName;
    notifyListeners();
  }

  ///change user name
  Future changeBio(String newBio) async {
    final http.Response response = await http.post(Uri(), headers: {});
    _bio = newBio;
    notifyListeners();
  }

  ///change user username
  Future changeusername(String newUsername) async {
    final http.Response response = await http.post(Uri(), headers: {});
    _username = newUsername;
    notifyListeners();
  }

  ///add user profile
  Future addProfile(String newProfile) async {
    final http.Response response = await http.post(Uri(), headers: {});
    _profileUrls.add(newProfile);
    notifyListeners();
  }

  ///remove user profile
  Future removeProfile(String oldProfile) async {
    final http.Response response = await http.post(Uri(), headers: {});
    _profileUrls.remove(oldProfile);
    notifyListeners();
  }

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  DateTime get lastSeen {
    return _lastSeen;
  }

  String get username {
    return _username;
  }

  String get bio {
    return _bio;
  }

  List<String> get profileUrls {
    return [..._profileUrls];
  }
}
