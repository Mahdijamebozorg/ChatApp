import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Screens/ChatScreeen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatelessWidget {
  final String chatId;
  final User currentUser;

  const ChatItem({
    required this.chatId,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  void selectChat(BuildContext context, String chatId, User user) {
    Navigator.of(context).pushNamed(
      ChatScreen.routeName,
      arguments: {"chatId": chatId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Chat>(
      builder: (context, chat, ch) => ListTile(
        hoverColor: Colors.white.withOpacity(0.1),
        //open chat
        onTap: () => selectChat(context, chatId, currentUser),

        //options
        onLongPress: () {},

        //user name
        title: Text(
          chat.chatTitle(currentUser),
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        //last message
        subtitle: Text(chat.messages.last.text,
            style: Theme.of(context).textTheme.bodySmall),

        //profile phot
        leading: CircleAvatar(
          backgroundImage: chat.profiles(currentUser).isEmpty
              ? const AssetImage("assets/images/user.png")
              : NetworkImage(
                  chat.profiles(currentUser)[0],
                ) as ImageProvider,
        ),
      ),
    );
  }
}
