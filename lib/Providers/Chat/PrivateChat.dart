import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future loadMessages() async {
    final messagesCollection = FirebaseFirestore.instance
        .collection("PrivateChats/$id/Messages")
        .orderBy("sendDate");

    //listen for changed messages in Messages collection
    await for (QuerySnapshot<Map<String, dynamic>> chats
        in messagesCollection.snapshots()) {
      for (var changes in chats.docChanges) {
        Message changedMessage = Message.loadFromDocument(changes.doc);

        //if message exists in app
        if (_messages.contains(changedMessage)) {
          //if removed from database
          if (!changes.doc.exists) {
            _messages.removeWhere((m) => m.id == changedMessage.id);
          }

          //if updated in database
          else {
            final index =
                _messages.indexWhere((m) => changedMessage.id == m.id);
            _messages[index] = changedMessage;
          }
        }
        //if added to database
        else {
          _messages.add(changedMessage);
        }
        notifyListeners();
      }
    }
  }

  ///takes a PrivateChat doc and makes a PrivateChat instance
  ///Future Feature:
  ///* load unsent messages froms local database
  static Future<PrivateChat> loadFromDocument(
      DocumentSnapshot<Map<String, dynamic>> doc) async {
    //users
    final List<User> users = await Chat.loadUsersInChat(doc);

    //messages
    final messages =
        (await doc.reference.collection("Messages").orderBy("sendTime").get())
            .docs
            .map((message) {
      return Message.loadFromDocument(message);
    }).toList();

    //unsent mesaages
    //will be loaded from local database
    List<Message> unsentMessages = [];

    return PrivateChat(
      doc.id,
      users,
      messages,
      unsentMessages,
      doc.data()!["createdDate"].toDate(),
    );
  }

  ///send message
  ///Future Features:
  ///* in future temp messages will be saved on device
  @override
  Future sendMessage(Message newMessage, User currentUser) async {
    if (kDebugMode) print("##### PrivateChat: sendMessage called");
    if (!canSendMessage(currentUser)) {
      throw Exception("User can't send message");
    }

    //a temp message view before sending it
    _unsentMessages.add(Message(
      newMessage.id,
      newMessage.text,
      newMessage.senderId,
      null,
      newMessage.isEdited,
      {},
    ));
    notifyListeners();

    //send message to firestore
    try {
      await FirebaseFirestore.instance
          .collection("PrivateChats/$id/Messages")
          .add({
        "text": newMessage.text,
        "senderId": currentUser.id,
        "sendDate": Timestamp.fromDate(DateTime.now()),
        "isEdited": false,
        "usersSeen": {},
      });

      //remove temp view
      _unsentMessages.removeWhere((message) => message.id == newMessage.id);
      _messages.add(newMessage);
    } on SocketException catch (message) {
      if (kDebugMode) print("##### socketException in sendMessage: $message");
    }
    notifyListeners();
  }

  //test
  // @override
  // Future uploadMessages() async {
  //   if (kDebugMode) print("##### Chat: uploadMessage called");

  //   //upload all unsentMessages
  //   for (var message in _unsentMessages) {
  //     final http.Response response;
  //     try {
  //       response = await http.post(
  //         Uri.parse("https://test.com"),
  //         headers: {},
  //         body: {},
  //       );
  //       _unsentMessages.remove(message);
  //       notifyListeners();
  //     } on SocketException catch (message) {
  //       if (kDebugMode) {
  //         print("##### socketException in uploadMessage: $message");
  //       }
  //     }
  //   }
  // }

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
    if (_users.isEmpty || _users.length == 1) return "no user found!";
    return _users.firstWhere((user) => currentUser.id != user.id).name;
  }

  @override
  String chatSubtitle(User currentUser) {
    if (_users.isEmpty || _users.length == 1) return "no user found!";

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
