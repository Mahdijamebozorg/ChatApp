import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Providers/Auth.dart';
import 'package:chatapp/Providers/Chats.dart';
import 'package:chatapp/Widgets/AppDrawer.dart';
import 'package:chatapp/Widgets/ChatItem.dart';

class HomeScreen extends StatefulWidget {
  final bool isConnecting;
  final String backEndAddress;
  const HomeScreen({
    required this.isConnecting,
    required this.backEndAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _connectivityState = "Waiting...";

  Future checkConnectionState(User user, Auth auth) async {
    //listen to device internet changes
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        print(result);

        //if internet is off
        if (result == ConnectivityResult.none) {
          _connectivityState = "Waiting...";
          if (user.isOnline) await user.toggleOnline();
          setState(() {});
        }

        //if internet is on
        else {
          //state before connect
          _connectivityState = "Connecing...";
          setState(() {});

          //check connection to server
          final response = await http.get(Uri.parse(widget.backEndAddress),
              headers: {"token": auth.token});

          print("status code: ${response.statusCode}");

          //first digit of status code
          switch (int.parse(response.statusCode.toString()[0])) {

            //if can connect to server
            //200-299 status code
            case 2:
              _connectivityState = "Connected";
              //become online
              if (!user.isOnline) await user.toggleOnline();
              break;

            //400-499 status code
            case 4:
              _connectivityState = "Client Error";
              //become offline
              if (user.isOnline) await user.toggleOnline();
              break;

            //500-599 status code
            case 5:
              _connectivityState = "Server Error";
              //become offline
              if (user.isOnline) await user.toggleOnline();
              break;

            //other promlems
            default:
              _connectivityState = "Connecting...";
              //become offline
              if (user.isOnline) await user.toggleOnline();
          }
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final Size _screenSize = MediaQuery.of(context).size;
    print("State Managing:  HomeScreen Rebuilt");
    return FutureBuilder(
      future: checkConnectionState(user, auth),
      builder: (_, snapShot) {
        return DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(_connectivityState),
              actions: [
                //search button
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                //more button
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
              //tabBar bottom of appBar
              bottom: const TabBar(
                tabs: [
                  //users tab
                  Tab(
                    child: Icon(
                      Icons.group,
                    ),
                  ),
                  //groups tab
                  Tab(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ],
              ),
            ),
            body: Consumer<Chats>(
              builder: (context, chats, child) {
                print("State Managing:  ChatsItems Rebuilt");
                return TabBarView(
                  children: [
                    //groups tab
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: chats.chatsWithGroup.length,
                      itemBuilder: (context, index) => Hero(
                        tag: chats.chatsWithGroup[index].id,
                        child: ChangeNotifierProvider<Chat>.value(
                          value: chats.chatsWithGroup[index],
                          child: ChatItem(
                            chatId: chats.chatsWithGroup[index].id,
                            currentUser: user,
                          ),
                        ),
                      ),
                    ),

                    //users tab
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: chats.chatsWithUser.length,
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider<Chat>.value(
                        value: chats.chatsWithUser[index],
                        child: ChatItem(
                          chatId: chats.chatsWithUser[index].id,
                          currentUser: user,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            drawer: AppDrawer(_screenSize),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
