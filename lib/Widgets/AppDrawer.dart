import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class AppDrawer extends StatelessWidget {
  final Size screenSize;
  const AppDrawer(this.screenSize);

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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlue,
                ],
              ),
            ),
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    "Profile",
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.bodyText2,
                    softWrap: false,
                  ),
                  leading: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
