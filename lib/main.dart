import 'package:chatapp/Providers/Auth.dart';
import 'package:chatapp/Providers/Chats.dart';
import 'package:chatapp/Screens/AuthenticatinScreen.dart';
import 'package:chatapp/Screens/ChatScreeen.dart';
import 'package:chatapp/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'dummy_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Chats>(
          create: (ctx) => Chats("", "", dummy_chats), //test
          update: (ctx, auth, chats) => Chats(
            auth.currentUser?.id,
            auth.token,
            chats?.allChats ?? [],
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, ch) => MaterialApp(
          title: 'Flutter',
          debugShowCheckedModeBanner: false,

          //Theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            buttonTheme: const ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              buttonColor: Colors.black
            ),
            textTheme: TextTheme(
              bodySmall: TextStyle(
                fontSize: 12,
              ),
              bodyMedium: TextStyle(
                fontSize: 18,
              ),
              bodyLarge: TextStyle(
                fontSize: 24,
              ),
            ),
          ),

          //Routes
          home:
              auth.isAuth() ? const HomeScreen() : const AuthenticationScreen(),
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            ChatScreen.routeName: (ctx) => const ChatScreen(),
          },
        ),
      ),
    );
  }
}
