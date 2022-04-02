import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Chat/PrivateChat.dart';
import 'package:chatapp/Providers/Chat/GroupChat.dart';
import 'package:chatapp/Providers/Chat/ChannelChat.dart';
import 'package:chatapp/Providers/Chat/BotChat.dart';

class Chats with ChangeNotifier {
  final String _token;
  final String _userId;
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
    //initial fireBase
    if (kDebugMode) print("##### initialing fireBase in loadChats...");

    if (!kIsWeb && Firebase.apps.isEmpty) {
      await Firebase.initializeApp().then((value) {
        if (kDebugMode) {
          print("##### App initialized in loadChats: ${value.name}");
        }
      });
    }
    if (kDebugMode) print("##### loading chats...");

    //access fireStore and get chats which user is in them and listen to them
    FirebaseFirestore.instance
        .collection("Chats")
        .where("Users.+ $_userId", isEqualTo: true)
        .snapshots()
        .listen((userChats) {
      //categorize chats and add them
      for (var chat in userChats.docs) {
        if (chat["Type.private"] == true) {
          _chats.add(PrivateChat(
            chat.id,
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()["createdDate"],
          ));
        } else if (chat["Type.group"] == true) {
          _chats.add(GroupChat(
            chat.id,
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
          ));
        } else if (chat["Type.channel"] == true) {
          _chats.add(GroupChat(
            chat.id,
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
          ));
        } else if (chat["Type.bot"] == true) {
          _chats.add(GroupChat(
            chat.id,
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
            chat.data()[""],
          ));
        }
        notifyListeners();
      }
    });
  }

  ///updating chat from server
  Future updateChat(Chat chat /*Authentication data*/) async {
    //send data to server
  }
}
