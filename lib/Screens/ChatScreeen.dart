import 'package:chatapp/Models/Chat.dart';
import 'package:chatapp/Models/Message.dart';
import 'package:chatapp/Models/User.dart';
import 'package:chatapp/Widgets/ChatInput.dart';
import 'package:chatapp/Widgets/ChatMessages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double inputFieldHeight = 50;

class ChatScreen extends StatefulWidget {
  static const routeName = "/chatScreen";

  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var routeArg;
  bool _dataLoaded = false;

  @override
  void didChangeDependencies() {
    if (_dataLoaded == false) {
      var temp = ModalRoute.of(context)!.settings.arguments;
      if (temp != null) {
        routeArg = temp as Map<String?, dynamic>;
      }
      _dataLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final _viewInsets = MediaQuery.of(context).viewInsets;
    final Chat chat = routeArg?["chat"];
    final User currentUser = routeArg?["user"];
    final User otherUser =
        chat.users.firstWhere((user) => user.id != currentUser.id);
    final AppBar _appBar;

    // final Size _screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, value, child) => Scaffold(
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
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //name
                            Text(
                              otherUser.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            //last seen
                            Text(
                              (otherUser.lastSeen).toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  //buttons
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
        body: chat.messages.isNotEmpty
            ? Column(
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
                      addMessage: () {},
                    ),
                  ),
                ],
              )
            : const Text("No chat yet!"),
      ),
    );
  }
}
