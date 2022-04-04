import 'package:chatapp/Providers/User.dart';
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

  Future editMessage(String messageText) async {
    final response = await http.get(Uri.parse("https://text.com"));
    _text = messageText;
    notifyListeners();
  }

  ///seen this message by current user if hasn't seen yet
  Future seenMessage(User currentUser) async {
    if (_senderId != currentUser.id &&
        !_usersSeen.containsKey(currentUser.id)) {
      _usersSeen.putIfAbsent(
        currentUser.id,
        () => DateTime.now(),
      );
      return http.post(Uri.parse("https://test.com"));
    }
  }
}
