import 'package:chatapp/Models/Chat.dart';
import 'package:chatapp/Models/User.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  final User currentUser;
  const ChatItem({required this.chat, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(chat.users.where((element) => false)),
      ),
    );
  }
}
