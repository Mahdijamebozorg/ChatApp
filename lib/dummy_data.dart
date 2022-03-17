import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Chat/PrivateChat.dart';
import 'package:chatapp/Providers/Chat/GroupChat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';

User mahdi =
    User("tempToken", "p1", "Mahdi", DateTime.now(), false, "", "", []);
User ali = User("tempToken", "p2", "Ali", DateTime.now(), true, "", "", []);
User hani = User("tempToken", "p3", "Hani", DateTime.now(), false, "", "", []);

List<Chat> dummy_chats = [
  PrivateChat(
    "chat1",
    [mahdi, ali],
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
    [mahdi, hani, ali],
    [
      mahdi,
    ],
    "Chat Name",
    [],
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
