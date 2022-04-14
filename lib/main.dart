import 'package:chatapp/Theme/UserThemeData.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/Providers/Auth.dart';
import 'package:chatapp/Providers/Chats.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Screens/AuthenticatinScreen.dart';
import 'package:chatapp/Screens/ChatScreeen.dart';
import 'package:chatapp/Screens/HomeScreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //these providers are used in entire app so we used them here
    return MultiProvider(
      providers: [
        //Auth provider
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),

        //User
        ChangeNotifierProxyProvider<Auth, User?>(
          create: (_) => User("", "", DateTime.now(), "", "", []),
          update: (_, auth, user) => auth.currentUser == null ? null : user,
        ),

        //Chats provider
        ChangeNotifierProxyProvider<User?, Chats?>(
          create: (_) => Chats("", []),
          update: (_, user, chats) => user == null
              ? null
              : Chats(
                  user.id,
                  chats == null ? [] : chats.allChats,
                ),
        ),
      ],

      //all widget are based on auth data and update with its changes
      child: Consumer<Auth>(
        builder: (context, auth, ch) => MaterialApp(
          title: 'Chat App',
          debugShowCheckedModeBanner: false,

          //Theme
          theme: UserThemeData(context).themeData,

          //Routes
          routes: {
            "/": (_) => auth.isAuth()
                //User is Auth
                ? const HomeScreen()

                //Not
                : FutureBuilder(
                    //wait to auto login if possible
                    future: auth.tryAutoLogin(),
                    builder: (_, AsyncSnapshot<bool> snapShot) =>
                        snapShot.connectionState == ConnectionState.waiting
                            //waiting...
                            ? const CircularProgressIndicator()
                            //done
                            : snapShot.data!
                                //auto login done
                                ? const HomeScreen()
                                //auto n failed
                                : const AuthenticationScreen(),
                  ),
            ChatScreen.routeName: (_) => ChatScreen(),
            AuthenticationScreen.routeName: (_) => const AuthenticationScreen(),
          },
        ),
      ),
    );
  }
}
