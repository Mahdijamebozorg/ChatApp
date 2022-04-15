import 'package:chatapp/Providers/Chats.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:chatapp/Theme/UserThemeData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,

      //Theme
      theme: UserThemeData(context).themeData,

      //Routes
      routes: {
        //authentication...
        "/": (_) => StreamBuilder(
            //wait to auto login if possible
            stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
            builder: (_, AsyncSnapshot<firebase_auth.User?> userData) {
              if (kDebugMode && userData.hasData) {
                // ignore: avoid_print
                print(
                    "data: ${userData.data!}, providerData: ${userData.data!.providerData}}");
              }
              //if auth failed
              if (!userData.hasData) {
                return const AuthenticationScreen();
              }

              //if auth done
              else {
                //load userdata from server
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(userData.data!.uid)
                        .snapshots(),
                    builder: (_, userSnapshot) {
                      return !userSnapshot.hasData
                          //waiting
                          ? const CircularProgressIndicator()

                          //set data providers
                          : MultiProvider(
                              providers: [
                                //user data provider
                                ChangeNotifierProvider<User>(
                                  create: (_) =>
                                      User.loadFromDocument(userSnapshot.data!),
                                ),

                                //chats data provider
                                ChangeNotifierProvider<Chats>(
                                  create: (_) => Chats(userData.data!.uid),
                                ),
                              ],
                              child: const HomeScreen(),
                            );
                    });
              }
            }),
        ChatScreen.routeName: (_) => ChatScreen(),
        AuthenticationScreen.routeName: (_) => const AuthenticationScreen(),
      },
    );
  }
}
