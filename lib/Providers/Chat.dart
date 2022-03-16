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
    final response = await http.post(Uri(), headers: {}, body: {});
    _messages.add(newMessage);
    notifyListeners();
  }

  Future removeMessage(
      Message message, User currentUser, bool totalRemove) async {
    final response = await http.post(Uri(), headers: {}, body: {});
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
}

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
    final response = await http.post(Uri(), headers: {}, body: {});
    _messages.add(newMessage);
    notifyListeners();
  }

  @override
  Future removeMessage(
      Message message, User currentUser, bool totalRemove) async {
    final response = await http.post(Uri(), headers: {}, body: {});
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
}

class GroupChat extends Chat {
  //chat
  List<User> _users;
  List<Message> _messages;
  String _chatName;
  final DateTime _createdDate;
  final ChatType _type;
  final String _id;

  List<User> _admins;

  GroupChat(
    this._id,
    this._users,
    this._admins,
    this._chatName,
    this._messages,
    this._type,
    this._createdDate,
  ) : super(_id, _users, _messages, _type, _createdDate);

  @override
  Future sendMessage(Message newMessage, User currentUser) async {
    if (!canSendMessage(currentUser)) {
      throw Exception("User can't send message");
    }
    final response = await http.post(Uri(), headers: {}, body: {});
    _messages.add(newMessage);
    notifyListeners();
  }

  @override
  Future removeMessage(
      Message message, User currentUser, bool totalRemove) async {
    final response = await http.post(Uri(), headers: {}, body: {});
    if (totalRemove && _admins.contains(currentUser)) {
      _messages.remove(message);
    } else {
      _users.remove(currentUser);
    }
    notifyListeners();
  }

  @override
  String chatTitle(User currentUser) {
    return _chatName;
  }

  @override
  String chatSubtitle(User currentUser) {
    return _users.length.toString();
  }

  ///if user can send message to this chat
  @override
  bool canSendMessage(User user) {
    //... check chat
    return true;
  }
}

class ChannelChat extends Chat {
  //chat
  List<User> _users;
  List<Message> _messages;
  String _chatName;
  final DateTime _createdDate;
  final ChatType _type;
  final String _id;

  List<User> _admins;

  ChannelChat(
    this._id,
    this._users,
    this._admins,
    this._chatName,
    this._messages,
    this._type,
    this._createdDate,
  ) : super(_id, _users, _messages, _type, _createdDate);

  @override
  Future sendMessage(Message newMessage, User currentUser) async {
    if (!canSendMessage(currentUser)) {
      throw Exception("User can't send message");
    }
    final response = await http.post(Uri(), headers: {}, body: {});
    _messages.add(newMessage);
    notifyListeners();
  }

  @override
  Future removeMessage(
      Message message, User currentUser, bool totalRemove) async {
    final response = await http.post(Uri(), headers: {}, body: {});
    if (totalRemove && _admins.contains(currentUser)) {
      _messages.remove(message);
    } else {
      _users.remove(currentUser);
    }
    notifyListeners();
  }

  @override
  String chatTitle(User currentUser) {
    return _chatName;
  }

  @override
  String chatSubtitle(User currentUser) {
    return _users.length.toString();
  }

  ///if user is admin in this chat
  @override
  bool canSendMessage(User user) {
    if (_admins.contains(user)) return true;
    return false;
  }
}

class BotChat extends Chat {
  //chat
  List<User> _users;
  List<Message> _messages;
  final DateTime _createdDate;
  final ChatType _type;
  final String _id;

  BotChat(
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
    final response = await http.post(Uri(), headers: {}, body: {});
    _messages.add(newMessage);
    notifyListeners();
  }

  @override
  Future removeMessage(
      Message message, User currentUser, bool totalRemove) async {
    final response = await http.post(Uri(), headers: {}, body: {});
    if (totalRemove) {
      _messages.remove(message);
    } else {
      _users.remove(currentUser);
    }
    notifyListeners();
  }

  //not compeleted
  @override
  String chatTitle(User currentUser) {
    return "bot name";
  }

  @override
  String chatSubtitle(User currentUser) {
    return "Bot";
  }

  ///if user can send message to this chat
  @override
  bool canSendMessage(User user) {
    //... check chat
    return true;
  }
}
