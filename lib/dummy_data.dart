import 'package:chatapp/Models/Chat.dart';
import 'package:chatapp/Models/Message.dart';
import 'package:chatapp/Models/User.dart';

List<Chat> dummy_chats = [
  Chat(
    users: [User(name: "Mahdi", id: "p1"), User(name: "Ali", id: "p2")],
    messages: [
      Message(
        text: "Hello world",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      )
    ],
    type: ChatType.user,
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Chat(
    users: [User(name: "Mahdi", id: "p1"), User(name: "Hani", id: "p3")],
    messages: [
      Message(
        text: "Salaaaaam",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      )
    ],
    type: ChatType.user,
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Chat(
    users: [User(name: "Mahdi", id: "p1"), User(name: "Amir", id: "p4")],
    messages: [
      Message(
        text: "Hiiiiii",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      )
    ],
    type: ChatType.group,
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Chat(
    users: [User(name: "Mahdi", id: "p1"), User(name: "Fati", id: "p5")],
    messages: [
      Message(
        text: "Have a nice day!",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      )
    ],
    type: ChatType.group,
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
