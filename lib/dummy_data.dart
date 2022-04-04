import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Chat/PrivateChat.dart';
import 'package:chatapp/Providers/Chat/GroupChat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';

User mahdi = User("p1", "Mahdi", DateTime.now(), "", "", []);
User ali = User("p2", "Ali", DateTime.now(), "", "", []);
User hani = User("p3", "Hani", DateTime.now(), "", "", []);
Message tempMessage = Message(
  "m1",
  "salaaaaaaaam",
  "p1",
  DateTime.now().subtract(const Duration(hours: 5)),
  false,
  {},
);

List<Chat> dummy_chats = [
  PrivateChat(
    "chat1",
    [mahdi, ali],
    [tempMessage, tempMessage, tempMessage],
    [],
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
    DateTime.now().subtract(const Duration(days: 1)),
  ),
];
