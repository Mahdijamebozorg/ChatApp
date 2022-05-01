import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Widgets/ChatInput.dart';
import 'package:chatapp/Widgets/ChatMessages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double inputFieldHeight = 45;

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = "/chatScreen";

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) print("##### State Managing:  ChatScreen Rebuilt");

    //providers data
    final User currentUser = Provider.of<User>(context, listen: false);

    return Consumer<Chat>(
      builder: (context, chat, child) => Scaffold(
        //appBar
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
                        child: CircleAvatar(
                          backgroundImage: chat.profiles(currentUser).isEmpty
                              ? const AssetImage("assets/images/user.png")
                              : NetworkImage(
                                  chat.profiles(currentUser)[0],
                                ) as ImageProvider,
                        ),
                      ),
                      //datails
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 15),
                        child: Column(
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
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            )
                          ],
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
                      PopupMenuButton(
                        itemBuilder: (context) => [],
                        child: Icon(
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
        body: chat.messages.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //messages
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: chat.messages.length,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider<Message>.value(
                        value: chat.messages[index],
                        child: Align(
                          //alignment
                          alignment:
                              currentUser.id == chat.messages[index].senderId
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                          //shape and color
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color:
                                (chat.messages[index].senderId == currentUser.id
                                    ? Colors.blue[700]
                                    : Colors.grey.shade700),
                            child: ChatMessages(
                              currentUser: currentUser,
                            ),
                          ),
                        ),
                      ),
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
              )
            : const Text("No chat yet!"),
      ),
    );
  }
}
