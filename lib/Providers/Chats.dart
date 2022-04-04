import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Chat/PrivateChat.dart';
import 'package:chatapp/Providers/Chat/GroupChat.dart';
import 'package:chatapp/Providers/Chat/ChannelChat.dart';
import 'package:chatapp/Providers/Chat/BotChat.dart';
import 'package:http/retry.dart';

class Chats with ChangeNotifier {
  final String _token;
  final String _userId;
  final List<Chat> _chats;
  Chats(this._token, this._userId, this._chats);

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

  Future<List<User>> loadUsersInChat(
      QueryDocumentSnapshot<Map<String, dynamic>> chat,
      {String token = ""}) async {
    //users in chat
    List<User> users = [];
    for (String id in chat.data()["users"].keys) {
      final user =
          await FirebaseFirestore.instance.collection("Users").doc(id).get();
      if (user.data() != null) {
        users.add(User(
          user.id,
          user.data()!["name"],
          user.data()!["lastSeen"].toDate(),
          user.data()!["bio"],
          user.data()!["username"],
          Map<String, String>.from(user.data()!["profileUrls"]).values.toList(),
        ));
      }
    }
    return users;
  }

  ///loading chat from server
  Future loadChats(/*Authentication data*/) async {
    //initial fireBase
    if (!kIsWeb && Firebase.apps.isEmpty) {
      await Firebase.initializeApp().then((value) {
        if (kDebugMode) {
          print("##### App initialized in loadChats: ${value.name}");
        }
      });
    }
    if (kDebugMode) print("##### loading chats...");

    final data = FirebaseFirestore.instance.collection("PrivateChats");

    //load user privateChats and listen to them
    data
        .where("users.$_userId", isEqualTo: true)
        .snapshots()
        .listen((privateChats) async {
      for (var privateChat in privateChats.docs) {
        if (kDebugMode) print("##### privateChat: ${privateChat.data()}");
        //load messages from local dataBase
        List<Message> unsentMessages = []; //= dbHelper.fetchData(table)...

        //messages collection
        final messages = (await privateChat.reference
                .collection("Messages")
                .orderBy("sendTime")
                .get())
            .docs;

        //users in chat
        final List<User> users = await loadUsersInChat(privateChat);

        _chats.clear();
        //inserting chats
        _chats.add(PrivateChat(
          privateChat.id,
          //users
          users,
          //messages
          messages.map((message) {
            if (kDebugMode) print("##### message: ${message.data()}");
            return Message(
              message.id,
              message.data()["text"],
              message.data()["senderId"],
              (message.data()["sendTime"] as Timestamp).toDate(),
              message.data()["isEdited"],
              Map<String, DateTime>.from(message
                  .data()["usersSeen"]
                  .map((key, value) => MapEntry(key, value.toDate()))),
            );
          }).toList(),
          //local messages
          unsentMessages,
          //created date
          privateChat.data()["createdDate"].toDate(),
        ));
      }
      notifyListeners();
    });

    //access fireStore and get chats which user is in them and listen to them
    // FirebaseFirestore.instance
    //     .collection("Chats")
    //     .where("Users.$_userId", isEqualTo: true)
    //     .snapshots()
    //     .listen((userChats) {
    //   //categorize chats and add them
    //   if (kDebugMode) print("##### ${userChats.docs}");

    //   for (var chat in userChats.docs) {
    //     if (kDebugMode) print("##### ${chat.data()}");
    // if (chat["Type"] == private) {
    //   _chats.add(PrivateChat(
    //     chat.id,
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()["createdDate"],
    //   ));
    // } else if (chat["Type"] == group) {
    //   _chats.add(GroupChat(
    //     chat.id,
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //   ));
    // } else if (chat["Type"] == channel) {
    //   _chats.add(GroupChat(
    //     chat.id,
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //   ));
    // } else if (chat["Type"] == bot) {
    //   _chats.add(GroupChat(
    //     chat.id,
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //     chat.data()[""],
    //   ));
    // }
    // notifyListeners();
    //   }
    // });
  }

  ///updating chat from server
  Future updateChat(Chat chat /*Authentication data*/) async {
    //send data to server
  }
}
