import 'package:chatapp/Models/Chat.dart';
import 'package:flutter/material.dart';

class Chats with ChangeNotifier {
  final userId;
  final token;
  final List<Chat> _chats;
  Chats(this.userId, this.token, this._chats);

  List<Chat> get allChats {
    return [..._chats];
  }

  List<Chat> get chatsWithUser {
    return _chats.where((chat) => chat.type == ChatType.user).toList();
  }

  List<Chat> get chatsWithGroup {
    return _chats.where((chat) => chat.type == ChatType.group).toList();
  }

  List<Chat> get chatsWithBot {
    return _chats.where((chat) => chat.type == ChatType.bot).toList();
  }

  List<Chat> get chatsWithChannel {
    return _chats.where((chat) => chat.type == ChatType.channel).toList();
  }

  ///adding chat
  Future addChat(Chat chat /*Authentication data*/) async {
    //send data to server
    _chats.insert(0, chat);
  }

  ///removing chat
  Future removeChat(Chat chat,
      {bool bidirectional = false} /*Authentication data*/) async {
    //send data to server
    _chats.remove(chat);
  }

  ///loading chat from server
  Future loadChats(/*Authentication data*/) async {
    //fetch data from server
    //_chats = ...
  }

  ///updating chat from server
  Future updateChat(Chat chat /*Authentication data*/) async {
    //send data to server
  }
}
