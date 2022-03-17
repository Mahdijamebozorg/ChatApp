import 'dart:io';

import 'package:http/http.dart' as http;

import './Chat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';

class PrivateChat extends Chat {
  //chat
  final List<User> _users;
  List<Message> _messages;
  final DateTime _createdDate;
  final ChatType _type;
  final String _id;

  PrivateChat(
    this._id,
    this._users,
    this._messages,
    this._type,
    this._createdDate,
  ) : super(_id, _users, _messages, _type, _createdDate);

  @override
  Future sendMessage(Message newMessage, User currentUser) async {
    if (!canSendMessage(currentUser)) {
      throw Exception("User can't send message");
    }
    final http.Response response;
    try {
      response =
          await http.post(Uri.parse("https://test.com"), headers: {}, body: {});
    } on SocketException catch (message) {
      print(message);
    }
    _messages.add(newMessage);
    notifyListeners();
  }

  @override
  Future removeMessage(
      Message message, User currentUser, bool totalRemove) async {
    final http.Response response;
    try {
      response =
          await http.post(Uri.parse("https://test.com"), headers: {}, body: {});
    } on SocketException catch (message) {
      print(message);
    }
    if (totalRemove) {
      _messages.remove(message);
    } else {
      _users.remove(currentUser);
    }
    notifyListeners();
  }

  @override
  String chatTitle(User currentUser) {
    return _users.firstWhere((user) => currentUser.id != user.id).name;
  }

  @override
  String chatSubtitle(User currentUser) {
    return _users
        .firstWhere((user) => user.id == currentUser.id)
        .lastSeen
        .toString();
  }

  @override
  bool canSendMessage(User user) {
    //... check chat
    return true;
  }

  @override
  List<String> profiles(User currentUser) {
    return _users.firstWhere((user) => user.id == currentUser.id).profileUrls;
  }
}
