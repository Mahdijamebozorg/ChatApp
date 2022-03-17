import 'package:chatapp/Providers/Auth.dart';
import 'package:chatapp/Providers/Chats.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Screens/AuthenticatinScreen.dart';
import 'package:chatapp/Screens/ChatScreeen.dart';
import 'package:chatapp/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'dummy_data.dart';

void main() {
  runApp(const MyApp());
}

const _backEndAddress = "http://firebase.google.com"; //"http://telegram.org";

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

        //Chats provider
        ChangeNotifierProxyProvider<Auth, Chats>(
          create: (ctx) => Chats("", "", dummy_chats), //test
          //we must have token in Chats to manage chats
          update: (ctx, auth, chats) => Chats(
            auth.userId,
            auth.token,
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
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: Colors.black87,
            //buttons theme
            buttonTheme: const ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              buttonColor: Colors.white,
            ),
            //text thmeme
            textTheme: Typography.whiteCupertino,
          ),

          //Routes
          routes: {
            "/": (_) => auth.isAuth()
                //program is connected and user is Auth
                ? const HomeScreen(
                    isConnecting: false,
                    backEndAddress: _backEndAddress,
                  )

                //opening program
                : FutureBuilder(
                    //wait to connect
                    future: auth.tryAutoLogin(),
                    builder: (_, snapShot) =>
                        snapShot.connectionState == ConnectionState.waiting
                            //is connecting
                            ? ChangeNotifierProvider<User>.value(
                                value: auth.currentUser!,
                                child: const HomeScreen(
                                  isConnecting: true,
                                  backEndAddress: _backEndAddress,
                                ),
                              )
                            //loged out
                            : const AuthenticationScreen(),
                  ),
            ChatScreen.routeName: (_) => ChatScreen(),
          },
        ),
      ),
    );
  }
}
