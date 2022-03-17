import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';

enum ChatType { user, group, channel, bot }

abstract class Chat with ChangeNotifier {
  List<User> _users;
  List<Message> _messages;
  final DateTime _createdDate;
  final ChatType _type;
  final String _id;

  Chat(
    this._id,
    this._users,
    this._messages,
    this._type,
    this._createdDate,
  );

  List<User> get users {
    return [..._users];
  }

  List<Message> get messages {
    return [..._messages];
  }

  DateTime get createdDate {
    return _createdDate;
  }

  ChatType get type {
    return _type;
  }

  String get id {
    return _id;
  }

  ///name of person or group
  String chatTitle(User currentUser) {
    return "Title";
  }

  ///last seen of person or members count
  String chatSubtitle(User currentUser) {
    return "Subtitle";
  }

  ///if user can send message to this chat
  bool canSendMessage(User user) {
    return false;
  }

  Future sendMessage(Message newMessage, User currentUser) async {
    if (!canSendMessage(currentUser)) {
      throw Exception("User can't send message");
    }
    final http.Response response;
    try {
      response = await http.post(Uri.parse("https://test.com"), headers: {}, body: {});
    } on http.ClientException catch (message) {
      print(message);
    }
    _messages.add(newMessage);
    notifyListeners();
  }

  Future removeMessage(
      Message message, User currentUser, bool totalRemove) async {
    final http.Response response;
    try {
      response = await http.post(Uri.parse("https://test.com"), headers: {}, body: {});
    } on http.ClientException catch (message) {
      print(message);
    }
    if (totalRemove) {
      if (totalRemove) {
        _messages.remove(message);
      } else {
        _users.remove(currentUser);
      }
    } else {
      _users.remove(currentUser);
    }
    notifyListeners();
  }

  List<String> profiles(User currentUser) {
    return [];
  }
}
