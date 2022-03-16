import 'package:chatapp/Providers/Chat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';

List<Chat> dummy_chats = [
  PrivateChat(
    "chat1",
    [
      User(
        "tempToken",
        "p1",
        "Mahdi",
        DateTime.now(),
        "",
        "",
        [],
      ),
      User(
        "tempToken",
        "p2",
        "Ali",
        DateTime.now(),
        "",
        "",
        [],
      )
    ],
    [
      Message(
        text: "salaaaaaaaam",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
        usersSeen: {
          "p2": DateTime.now().subtract(const Duration(hours: 4)),
        },
      ),
      Message(
        text: "hiiiiiiiii",
        senderId: "p2",
        sendTime: DateTime.now().subtract(const Duration(hours: 4)),
        usersSeen: {"p1": DateTime.now().subtract(const Duration(hours: 4))},
      ),
      Message(
        text: "Khoooobiiiii",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 3)),
        usersSeen: {},
      ),
      Message(
        text: "Khoooobiiiii",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 3)),
        usersSeen: {},
      ),
      Message(
        text: "Khoooobiiiii",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 3)),
        usersSeen: {},
      ),
      Message(
        text: "Khoooobiiiii",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 3)),
        usersSeen: {},
      ),
      Message(
        text: "Khoooobiiiii",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 3)),
        usersSeen: {},
      ),
      Message(
        text: "Khoooobiiiii",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 3)),
        usersSeen: {},
      ),
    ],
    ChatType.user,
    DateTime.now().subtract(const Duration(days: 1)),
  ),
  GroupChat(
    "chat2",
    [
      User(
        "tempToken",
        "p1",
        "Mahdi",
        DateTime.now(),
        "",
        "",
        [],
      ),
      User(
        "tempToken",
        "p3",
        "Hani",
        DateTime.now(),
        "",
        "",
        [],
      )
    ],
    [
      User(
        "_token",
        "p1",
        "Mahdi",
        DateTime.now(),
        "",
        "",
        [],
      ),
    ],
    "Chat Name",
    [
      Message(
        text: "Hello you",
        senderId: "p3",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Message(
        text: "Salaaaaam",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      )
    ],
    ChatType.user,
    DateTime.now().subtract(const Duration(days: 1)),
  ),
];
