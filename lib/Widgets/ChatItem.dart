import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Screens/ChatScreeen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///chat item preview in chats screen
class ChatItem extends StatelessWidget {
  final String chatId;
  final User currentUser;

  const ChatItem({
    required this.chatId,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  ///select a chat and provide chat data for it
  void selectChat(BuildContext context, Chat chat) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<Chat>.value(
          value: chat,
          child: ChatScreen(),
        ),
      ),
    );
  }

  ///remove message white spaces
  String removeWhiteSpaces(String text) {
    String temp = "";
    String lastChar = '';
    for (var char in text.characters) {
      //if is end of line and last char wasn't space, add a space
      if (char == '\n') {
        if (lastChar != ' ') temp += ' ';
      }
      //if there is one space, don't add other spaces
      else if (char != ' ' || lastChar != ' ') {
        temp += char;
        lastChar = char;
      }
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Chat>(
      builder: (context, chat, ch) => ListTile(
        hoverColor: Colors.white.withOpacity(0.1),
        //open chat
        onTap: () => selectChat(context, chat),

        //options
        onLongPress: () {},

        //user name
        title: Text(
          removeWhiteSpaces(chat.chatTitle(currentUser)),
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        //last message
        subtitle: Text(
            chat.messages.isEmpty
                //draft message
                ? ""
                : removeWhiteSpaces(chat.messages.last.text),
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
