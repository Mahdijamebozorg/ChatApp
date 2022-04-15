import 'package:chatapp/Providers/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Chat/PrivateChat.dart';
import 'package:chatapp/Providers/Chat/GroupChat.dart';
import 'package:chatapp/Providers/Chat/ChannelChat.dart';
import 'package:chatapp/Providers/Chat/BotChat.dart';

class Chats with ChangeNotifier {
  final String _userId;
  Chats(this._userId);

  List<Chat> _chats = [];

  List<Chat> get allChats {
    return [..._chats];
  }

  List<PrivateChat> get privateChats {
    return _chats.whereType<PrivateChat>().toList();
  }

  List<GroupChat> get groupChats {
    return _chats.whereType<GroupChat>().toList();
  }

  List<BotChat> get botChats {
    return _chats.whereType<BotChat>().toList();
  }

  List<ChannelChat> get channelChats {
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

  Future updateChat(Chat chat) async {}

//------------------------------------------------------------------------------------------------------------

  ///loading chat from server
  Future loadChats(
    Function done,
    /*Authentication data*/
  ) async {
    //initial fireBase
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp().then((value) {
        if (kDebugMode) {
          print("***** App initialized in loadChats: ${value.name}");
        }
      });
    }

    await loadPrivateChats();
    // listenToPrivateChats();
  }

//------------------------------------------------------------------------------------------------------------

  ///loads private chats
  ///
  ///Future Feature:
  ///* offline mode
  Future loadPrivateChats() async {
    if (kDebugMode) print("***** loading privateChats...");

    final userPrivateChatsCollection = await FirebaseFirestore.instance
        .collection("PrivateChats")
        .orderBy("createdDate")
        .where("users.$_userId", isEqualTo: true)
        .get();

    for (var chatDoc in userPrivateChatsCollection.docs) {
      final PrivateChat chat = await PrivateChat.loadFromDocument(chatDoc);
      if (!_chats.contains(chat)) {
        _chats.add(chat);
      }
    }
  }

  //------------------------------------------------------------------------------------------------------------

  ///updates changed chats from server
  ///
  ///Future Feature:
  ///* handle unsent messages
  Stream listenToPrivateChats() async* {
    final userPrivateChatsCollection = FirebaseFirestore.instance
        .collection("PrivateChats")
        .orderBy("createdDate")
        .where("users.$_userId", isEqualTo: true);

    //load user privateChats and listen to them
    await for (QuerySnapshot<Map<String, dynamic>> privateChats
        in userPrivateChatsCollection.snapshots()) {
      //look for changes
      for (var docChanges in privateChats.docChanges) {
        //load messages from local dataBase
        List<Message> unsentMessages = []; //= dbHelper.fetchData(table)...

        final changedChat = await PrivateChat.loadFromDocument(docChanges.doc);

        //if chat is already loaded
        if (_chats.contains(changedChat)) {
          //if chat removed from database
          if (!docChanges.doc.exists) {
            _chats.removeWhere((c) => c.id == changedChat.id);
          }
          //if chat updated from database
          else {
            final index = _chats.lastIndexWhere((c) => c.id == changedChat.id);
            _chats[index] = changedChat;
          }
        }
        //if chat added to database
        else {
          _chats.add(changedChat);
        }

        notifyListeners();
      }
    }
  }

  //------------------------------------------------------------------------------------------------------------
}
