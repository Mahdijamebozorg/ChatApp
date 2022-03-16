import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/Models/User.dart';
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
  Future<String> appConnectionState() async {
    if (widget.isConnecting) {
      return "Connecting...";
    }
    try {
      final response = await InternetAddress.lookup(widget.backEndAddress);
      print(response);
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        return "Connected";
      } else {
        return "Connecting...";
      }
    } on SocketException catch (message) {
      print(message);
      return "Waiting...";
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
          title: FutureBuilder(
            future: appConnectionState(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Text("Connecting...")
                    : Text(snapshot.data as String),
          ),
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
        body: Consumer2<Auth, Chats>(
          builder: (context, auth, chats, child) => TabBarView(
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
          ),
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
