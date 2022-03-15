import 'package:chatapp/Models/Chat.dart';
import 'package:chatapp/Models/Message.dart';
import 'package:chatapp/Models/User.dart';
import 'package:chatapp/Widgets/ChatInput.dart';
import 'package:flutter/material.dart';

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
    final Chat chat = routeArg?["chat"];
    final User currentUser = routeArg?["user"];
    final User otherUser =
        chat.users.firstWhere((user) => user.id != currentUser.id);

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
                      margin: EdgeInsets.only(left: 50),
                      child: CircleAvatar(
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
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: chat.messages.length,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) => Align(
                alignment: currentUser.id == chat.messages[index].senderId
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: (chat.messages[index].senderId == currentUser.id
                      ? Colors.blue[700]
                      : Colors.grey.shade700),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          chat.messages[index].text,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 2,
                        child: Text(
                          //test
                          "22:53",
                          // chat.messages[index].sendTime.hour.toString() ??
                          //     "TimeError",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Positioned(
                        left: 2,
                        bottom: 2,
                        child: chat.messages[index].senderId == currentUser.id
                            ? Icon(
                                chat.messages[index].usersSeen.isNotEmpty
                                    ? Icons.keyboard_double_arrow_left_sharp
                                    : Icons.arrow_back_ios_new,
                                size: 10,
                              )
                            : Container(),
                      )
                    ],
                  ),
                ),
              ),
            )
          : const Text("No chat yet!"),
      bottomSheet: ChatInputs(),
    );
  }
}
