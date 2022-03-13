import 'package:chatapp/Models/User.dart';
import 'package:chatapp/Providers/Auth.dart';
import 'package:chatapp/Providers/Chats.dart';
import 'package:chatapp/Widgets/AppDrawer.dart';
import 'package:chatapp/Widgets/ChatItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "./home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
                itemBuilder: (context, index) => ChatItem(
                  chat: chats.chatsWithGroup[index],
                  currentUser: auth.currentUser as User,
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
      ),
    );
  }
}
