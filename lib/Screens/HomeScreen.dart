import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        if (kDebugMode)print(result);

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

            if (kDebugMode)print("##### status code: ${response.statusCode}");

            //first digit of status code
            switch (int.parse(response.statusCode.toString()[0])) {

              //if can connect to server
              //200-299 status code
              case 2:
                _connectivityState = "Connected";
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
            if (kDebugMode) print("##### socketException in connection status: $message");
            _connectivityState = "Waiting...";
          }
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode)print("##### State Managing:  HomeScreen Rebuilt");

    ///current user
    final user = Provider.of<User>(context, listen: false);

    ///user auth
    final auth = Provider.of<Auth>(context, listen: false);

    final Size _screenSize = MediaQuery.of(context).size;

    //checking connection state
    checkConnectionState(user, auth);
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
        //loading chats
        body: FutureBuilder(
            future: Provider.of<Chats>(context, listen: false).loadChats(),
            builder: (context, snapShot) {
              return Consumer<Chats>(
                builder: (context, chats, ch) {
                  if (kDebugMode) print("##### State Managing:  ChatsItems Rebuilt");
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
              );
            }),
        drawer: AppDrawer(_screenSize),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}
