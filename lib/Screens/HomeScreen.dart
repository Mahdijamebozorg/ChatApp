import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Providers/Auth.dart';
import 'package:chatapp/Providers/Chats.dart';
import 'package:chatapp/Widgets/AppDrawer.dart';
import 'package:chatapp/Widgets/ChatItem.dart';

///App home screen
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

  ///checking connection state
  Future checkConnectionState(User user, Auth auth) async {
    //listen to device internet changes
    await for (ConnectivityResult result
        in Connectivity().onConnectivityChanged) {
      if (kDebugMode) print(result);

      //if internet is off
      if (result == ConnectivityResult.none) {
        _connectivityState = "Waiting...";
        setState(() {});
      }

      //if internet is on
      else {
        //state before connect
        _connectivityState = "Connecing...";
        setState(() {});

        //check connection to server
        final http.Response response;
        try {
          response = await http.get(Uri.parse(widget.backEndAddress),
              headers: {"token": auth.token});

          if (kDebugMode) print("##### status code: ${response.statusCode}");

          //first digit of status code
          switch (int.parse(response.statusCode.toString()[0])) {

            //if can connect to server
            //200-299 status code
            case 2:
              _connectivityState = "Updating...";
              setState(() {});
              await Provider.of<Chats>(context, listen: false)
                  .loadChats((bool done) {
                if (done) {
                  _connectivityState = "Connected";
                  setState(() {});
                }
              });
              break;

            //400-499 status code
            case 4:
              _connectivityState = "Client Error";
              break;

            //500-599 status code
            case 5:
              _connectivityState = "Server Error";
              break;

            //other promlems
            default:
              _connectivityState = "Connecting...";
          }
        } on SocketException catch (message) {
          if (kDebugMode) {
            print("##### socketException in connection status: $message");
          }
          _connectivityState = "Waiting...";
        }
        setState(() {});
      }
    }

    //this syntax was wrong
    // Connectivity().onConnectivityChanged.listen(
    //   (ConnectivityResult result) async {
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) print("***** State Managing:  HomeScreen Rebuilt");

    ///current user
    final user = Provider.of<User>(context, listen: false);

    ///user auth
    final auth = Provider.of<Auth>(context, listen: false);

    final Size _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
        future: checkConnectionState(user, auth),
        builder: (context, snapShot) {
          // checkConnectionState(user, auth);
          //update chat lists on updates
          return Consumer<Chats>(builder: (context, chats, ch) {
            if (kDebugMode) {
              print("***** State Managing:  ChatsItems Rebuilt");
            }
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
                        //a custom widget with new messages will be added++++
                        child: Icon(
                          Icons.group,
                        ),
                      ),
                      //groups tab
                      Tab(
                        //a custom widget with new messages will be added++++
                        child: Icon(
                          Icons.person,
                        ),
                      ),
                    ],
                  ),
                ),
                //loading chats
                body: TabBarView(
                  children: [
                    //groups tab
                    chats.groupChats.isEmpty
                        ? const Center(child: Text("No Group!"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: chats.groupChats.length,
                            itemBuilder: (context, index) =>
                                ChangeNotifierProvider<Chat>.value(
                              value: chats.groupChats[index],
                              child: ChatItem(
                                chatId: chats.groupChats[index].id,
                                currentUser: user,
                              ),
                            ),
                          ),

                    //users tab
                    chats.privateChats.isEmpty
                        ? const Center(child: Text("No Chat!"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: chats.privateChats.length,
                            itemBuilder: (context, index) =>
                                ChangeNotifierProvider<Chat>.value(
                              value: chats.privateChats[index],
                              child: ChatItem(
                                chatId: chats.privateChats[index].id,
                                currentUser: user,
                              ),
                            ),
                          ),
                  ],
                ),
                drawer: AppDrawer(_screenSize),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {},
                ),
              ),
            );
          });
        });
  }
}
