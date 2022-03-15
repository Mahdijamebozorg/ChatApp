import 'package:chatapp/Models/Chat.dart';
import 'package:chatapp/Models/Message.dart';
import 'package:chatapp/Models/User.dart';

List<Chat> dummy_chats = [
  Chat(
    id: "chat1",
    users: [
      User(
        name: "Mahdi",
        id: "p1",
        lastSeen: DateTime.now(),
        bio: "",
        username: "",
        profileUrls: [],
      ),
      User(
        name: "Ali",
        id: "p2",
        lastSeen: DateTime.now(),
        bio: "",
        username: "",
        profileUrls: [],
      )
    ],
    messages: [
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
      )
    ],
    type: ChatType.user,
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Chat(
    id: "chat2",
    users: [
      User(
        name: "Mahdi",
        id: "p1",
        lastSeen: DateTime.now(),
        bio: "",
        username: "",
        profileUrls: [],
      ),
      User(
        name: "Hani",
        id: "p3",
        lastSeen: DateTime.now(),
        bio: "",
        username: "",
        profileUrls: [],
      )
    ],
    messages: [
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
    type: ChatType.user,
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Chat(
    id: "chat3",
    users: [
      User(
        name: "Mahdi",
        id: "p1",
        lastSeen: DateTime.now(),
        bio: "",
        username: "",
        profileUrls: [],
      ),
      User(
        name: "Amir",
        id: "p4",
        lastSeen: DateTime.now(),
        bio: "",
        username: "",
        profileUrls: [],
      )
    ],
    messages: [
      Message(
        text: "Hello you",
        senderId: "p4",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Message(
        text: "Hiiiiii",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      )
    ],
    type: ChatType.user,
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Chat(
    id: "chat4",
    users: [
      User(
        name: "Mahdi",
        id: "p1",
        lastSeen: DateTime.now(),
        bio: "",
        username: "",
        profileUrls: [],
      ),
      User(
        name: "Fati",
        id: "p5",
        lastSeen: DateTime.now(),
        bio: "",
        username: "",
        profileUrls: [],
      )
    ],
    messages: [
      Message(
        text: "Have a nice day!",
        senderId: "p1",
        sendTime: DateTime.now().subtract(const Duration(hours: 5)),
      )
    ],
    type: ChatType.group,
    createdDate: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
