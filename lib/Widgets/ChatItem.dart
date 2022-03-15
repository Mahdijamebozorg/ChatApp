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
    return ListTile(
      hoverColor: Colors.white.withOpacity(0.1),
      //open chat
      onTap: () => selectChat(context, chat, currentUser),

      //options
      onLongPress: () {},

      //user name
      title: Text(
        otherUser.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),

      //last message
      subtitle: Text(chat.messages.last.text,
          style: Theme.of(context).textTheme.bodySmall),

      //profile phot
      leading: CircleAvatar(
        backgroundImage: otherUser.profileUrls.isEmpty
            ? const AssetImage("assets/images/user.png")
            : NetworkImage(
                otherUser.profileUrls[0],
              ) as ImageProvider,
      ),
    );
  }
}
