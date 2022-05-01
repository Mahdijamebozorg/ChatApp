import 'package:chatapp/Providers/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Message with ChangeNotifier {
  String _id;

  ///message text
  String _text;

  ///message sending time
  final DateTime? _sendTime;

  final String _senderId;

  ///is this message edited by user
  bool _isEdited;

  ///a list of id of users who seen this message with seen time
  Map<String, DateTime> _usersSeen;

  Message(
    this._id,
    this._text,
    this._senderId,
    this._sendTime,
    this._isEdited,
    this._usersSeen,
  );

  static Message loadFromDocument(
      DocumentSnapshot<Map<String, dynamic>> messageDocument) {
    return Message(
      messageDocument.id,
      messageDocument.data()!["text"],
      messageDocument.data()!["senderId"],
      (messageDocument.data()!["sendTime"] as Timestamp).toDate(),
      messageDocument.data()!["isEdited"],
      Map<String, DateTime>.from(messageDocument
          .data()!["usersSeen"]
          .map((key, value) => MapEntry(key, value.toDate()))),
    );
  }

  String get id {
    return _id;
  }

  String get text {
    return _text;
  }

  DateTime? get sendTime {
    return _sendTime;
  }

  String get sendTimePreview {
    return DateFormat.Hm().format(_sendTime!);
  }

  String get senderId {
    return _senderId;
  }

  bool get isEdited {
    return _isEdited;
  }

  Map<String, DateTime> get usersSeen {
    return {..._usersSeen};
  }

  Future editMessage(String messageText, String chatId) async {
    await FirebaseFirestore.instance
        .collection("PrivateChats/$chatId/Messages")
        .doc(id)
        .update({
      "text": messageText,
      "senderId": senderId,
      "sendTime": sendTime,
      "isEdited": true,
      "usersSeen": usersSeen,
    });
    _text = messageText;
    notifyListeners();
  }

  ///seen this message by current user if hasn't seen yet
  Future seenMessage(User currentUser, String chatId) async {
    if (_senderId != currentUser.id &&
        !_usersSeen.containsKey(currentUser.id)) {
      _usersSeen.putIfAbsent(
        currentUser.id,
        () => DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection("PrivateChats/$chatId/Messages")
          .doc(id)
          .update({
        "text": text,
        "senderId": senderId,
        "sendTime": sendTime,
        "isEdited": isEdited,
        "usersSeen": usersSeen,
      });
    }
  }
}
