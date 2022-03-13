import 'package:chatapp/Models/Message.dart';
import 'package:chatapp/Models/User.dart';

enum ChatType { user, group, channel, bot }

class Chat {
  List<User> users;
  List<Message> messages;
  final DateTime createdDate;
  final ChatType type;

  Chat({
    required this.users,
    required this.messages,
    required this.type,
    required this.createdDate,
  });
}
