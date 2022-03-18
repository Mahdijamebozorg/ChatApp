import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Chat/PrivateChat.dart';
import 'package:chatapp/Providers/Chat/GroupChat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';

User mahdi =
    User("tempToken", "p1", "Mahdi", DateTime.now(), false, "", "", []);
User ali = User("tempToken", "p2", "Ali", DateTime.now(), true, "", "", []);
User hani = User("tempToken", "p3", "Hani", DateTime.now(), false, "", "", []);
Message tempMessage = Message(
  "m1",
  "salaaaaaaaam",
  "p1",
  DateTime.now().subtract(const Duration(hours: 5)),
  false,
  {
    "p2": DateTime.now().subtract(const Duration(hours: 4)),
  },
);

List<Chat> dummy_chats = [
  PrivateChat(
    "chat1",
    [mahdi, ali],
    [tempMessage, tempMessage, tempMessage],
    [],
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
    [tempMessage, tempMessage, tempMessage],
    [],
    ChatType.user,
    DateTime.now().subtract(const Duration(days: 1)),
  ),
];
