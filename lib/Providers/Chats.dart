import 'package:chatapp/Providers/Chat.dart';
import 'package:flutter/material.dart';

class Chats with ChangeNotifier {
  final _token;
  final _userId;
  final List<Chat> _chats;
  Chats(this._token, this._userId, this._chats);

  List<Chat> get allChats {
    return [..._chats];
  }

  List<PrivateChat> get chatsWithUser {
    return _chats.whereType<PrivateChat>().toList();
  }

  List<GroupChat> get chatsWithGroup {
    return _chats.whereType<GroupChat>().toList();
  }

  List<BotChat> get chatsWithBot {
    return _chats.whereType<BotChat>().toList();
  }

  List<ChannelChat> get chatsWithChannel {
    return _chats.whereType<ChannelChat>().toList();
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
