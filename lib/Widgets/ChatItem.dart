import 'package:chatapp/Models/Chat.dart';
import 'package:chatapp/Models/User.dart';
import 'package:chatapp/Screens/ChatScreeen.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  final User currentUser;

  const ChatItem({
    required this.chat,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  void selectChat(BuildContext context, Chat chat, User user) {
    Navigator.of(context).pushNamed(
      ChatScreen.routeName,
      arguments: {
        "chat": chat,
        "user": user,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User otherUser = chat.users.firstWhere((user) => user.id != currentUser.id);
    return Card(
      elevation: 2,
      child: ListTile(
        //open chat
        onTap: () => selectChat(context, chat, currentUser),

        //options
        onLongPress: () {},

        //user name
        title: Text(otherUser.name),

        //last message
        subtitle: Text(chat.messages.last.text),

        //profile phot
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: GestureDetector(
            //open profile
            onTap: () {},
            //chat view
            onLongPress: () {},
            child: otherUser.profileUrls.isEmpty
                ? Image.asset("assets/images/user.png")
                : Image.network(
                    otherUser.profileUrls[0],
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
    );
  }
}
