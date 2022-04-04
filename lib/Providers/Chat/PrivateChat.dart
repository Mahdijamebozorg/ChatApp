import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import './Chat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';

class PrivateChat extends Chat {
  //chat
  final List<User> _users;
  List<Message> _messages;
  List<Message> _unsentMessages;
  final DateTime _createdDate;
  final String _id;

  PrivateChat(
    this._id,
    this._users,
    this._messages,
    this._unsentMessages,
    this._createdDate,
  ) : super(_id, _users, _messages, _unsentMessages, _createdDate);

  @override
  Future sendMessage(Message newMessage, User currentUser) async {
    if (kDebugMode) print("##### PrivateChat: sendMessage called");
    if (!canSendMessage(currentUser)) {
      throw Exception("User can't send message");
    }

    //in future temp messages will be saved on device
    //await save message...
    _unsentMessages.add(Message(
      newMessage.id,
      newMessage.text,
      newMessage.senderId,
      null,
      newMessage.isEdited,
      {},
    ));
    notifyListeners();

    final http.Response response;
    try {
      response = await http.post(
        Uri.parse("https://test.com"),
        headers: {},
        body: {},
      );
      _unsentMessages.removeWhere((message) => message.id == newMessage.id);
      _messages.add(newMessage);
    } on SocketException catch (message) {
      if (kDebugMode) print("##### socketException in sendMessage: $message");
    }
    notifyListeners();
  }

  //test
  // @override
  Future uploadMessages() async {
    if (kDebugMode) print("##### Chat: uploadMessage called");

    //upload all unsentMessages
    for (var message in _unsentMessages) {
      final http.Response response;
      try {
        response = await http.post(
          Uri.parse("https://test.com"),
          headers: {},
          body: {},
        );
        _unsentMessages.remove(message);
        notifyListeners();
      } on SocketException catch (message) {
        if (kDebugMode) {
          print("##### socketException in uploadMessage: $message");
        }
      }
    }
  }

  @override
  Future removeMessage(
      Message message, User currentUser, bool totalRemove) async {
    final http.Response response;
    try {
      response = await http.post(
        Uri.parse("https://test.com"),
        headers: {},
        body: {},
      );
    } on SocketException catch (message) {
      if (kDebugMode) print("##### socketException in removeMessage: $message");
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
    if (_users.isEmpty) return "no user found!";
    return _users.firstWhere((user) => currentUser.id != user.id).name;
  }

  @override
  String chatSubtitle(User currentUser) {
    if (_users.isEmpty) return "no user found!";

    //calcualte today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    DateTime lastSeen =
        _users.firstWhere((user) => user.id == currentUser.id).lastSeen;
    //if is not today
    if (lastSeen.isBefore(today)) {
      return intl.DateFormat.yMEd().format(lastSeen) +
          " at " +
          intl.DateFormat.Hm().format(lastSeen);
    }
    //if is today
    else {
      return intl.DateFormat.Hm().format(lastSeen);
    }
  }

  @override
  bool canSendMessage(User user) {
    //... check chat
    return true;
  }

  @override
  List<String> profiles(User currentUser) {
    if (_users.isEmpty) return ["assets/images/user.png"];
    return _users.firstWhere((user) => user.id == currentUser.id).profileUrls;
  }
}
