import 'dart:io';

import 'package:chatapp/Providers/Chat.dart';
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

  static const routeName = "./home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _connectivityState = "Waiting";

  @override
  initState() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("result: $result");
      if (result == ConnectivityResult.none) {
        _connectivityState = "Waiting";
      } else {
        if (widget.isConnecting) {
          _connectivityState = "Connecting...";
        } else {
          _connectivityState = "Connected";
        }
      }
      setState(() {});
    });
    super.initState();
  }

  void appConnectionState() async {
    if (widget.isConnecting) {
      print("Connecting");
      _connectivityState = "Connecting...";
    }
    try {
      final response = await InternetAddress.lookup(widget.backEndAddress);
      print(response);
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        print("Connected");
        _connectivityState = "Connected";
      } else {
        print("Connecting");
        _connectivityState = "Connecting...";
      }
    } on SocketException catch (message) {
      print(message);
      _connectivityState = "Waiting...";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
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
            final auth = Provider.of<Auth>(context, listen: false);
            return TabBarView(
              children: [
                //groups tab
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: chats.chatsWithGroup.length,
                  itemBuilder: (context, index) => Hero(
                    tag: chats.chatsWithGroup[index].id,
                    child: ChatItem(
                      chat: chats.chatsWithGroup[index],
                      currentUser: auth.currentUser as User,
                    ),
                  ),
                ),

                //users tab
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: chats.chatsWithUser.length,
                  itemBuilder: (context, index) => ChatItem(
                    chat: chats.chatsWithUser[index],
                    currentUser: auth.currentUser as User,
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
  }
}
