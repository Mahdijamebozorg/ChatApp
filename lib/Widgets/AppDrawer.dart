import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class AppDrawer extends StatelessWidget {
  final Size screenSize;
  const AppDrawer(this.screenSize, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width * (kIsWeb ? 0.25 : 0.45),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          tileMode: TileMode.clamp,
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Drawer(
          elevation: 20,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    "Profile",
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.labelMedium,
                    softWrap: false,
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onTap: () {},
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                ListTile(
                  title: const Text("Log out"),
                  leading: const Icon(Icons.logout),
                  onTap: () async =>
                      await FirebaseAuth.instance.signOut(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
