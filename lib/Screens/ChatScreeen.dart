import 'package:chatapp/Providers/Auth.dart';
import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Providers/Chats.dart';
import 'package:chatapp/Widgets/ChatInput.dart';
import 'package:chatapp/Widgets/ChatMessages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double inputFieldHeight = 45;

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static const routeName = "/chatScreen";

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map?;
    final String chatId = routeArg!["chatId"];
    final User currentUser = Provider.of<Auth>(context).currentUser!;
    final tempChatData = Provider.of<Chats>(context, listen: false)
        .allChats
        .firstWhere((chat) => chat.id == chatId);

    // final Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //app bar
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //user
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 50),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/user.png",
                        ), //test
                      ),
                    ),
                    //datails
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 15),
                      child: ChangeNotifierProvider<Chat>.value(
                        value: tempChatData,
                        //chat data
                        child: Consumer<Chat>(
                          builder: (context, chat, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //name
                              Text(
                                chat.chatTitle(currentUser),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              //last seen
                              Text(
                                chat.chatSubtitle(currentUser),
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //options
                Row(
                  children: [
                    //search button
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                    ),
                    //more button
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

      //body
      body: tempChatData.messages.isNotEmpty
          ? ChangeNotifierProvider<Chat>.value(
              value: tempChatData,
              child: Consumer<Chat>(
                  builder: (context, chat, child) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //messages
                          Expanded(
                            child: ChatMessages(
                              chat: chat,
                              currentUser: currentUser,
                            ),
                          ),

                          //inputs
                          Container(
                            constraints: const BoxConstraints(
                              minHeight: inputFieldHeight,
                              maxHeight: inputFieldHeight * 4,
                            ),
                            child: ChatInputs(
                              currentUser: currentUser,
                            ),
                          ),
                        ],
                      )),
            )
          : const Text("No chat yet!"),
    );
  }
}
