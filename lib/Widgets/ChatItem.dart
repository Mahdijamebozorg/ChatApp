import 'package:chatapp/Models/Chat.dart';
import 'package:chatapp/Models/User.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  final User currentUser;

  const ChatItem({
    required this.chat,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User otherUser = chat.users.firstWhere((user) => user.id != currentUser.id);
    return Card(
      elevation: 2,
      child: ListTile(
        onLongPress: () {},
        title: Text(otherUser.name),
        subtitle: Text(chat.messages.last.text),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            otherUser.profileUrls?[0] ?? "assets/images/user.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
