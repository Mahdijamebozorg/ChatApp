import 'package:flutter/material.dart';

class UserThemeData {
  final BuildContext context;
  ThemeData? themeData;
  UserThemeData(this.context) {
    final themeData = ThemeData(
      primarySwatch: Colors.indigo,

      scaffoldBackgroundColor: Colors.black87,

      brightness: Brightness.dark,
      //buttons theme
      buttonTheme: ButtonTheme.of(context).copyWith(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        buttonColor: Theme.of(context).primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),

      //text thmeme
      textTheme: Typography.whiteCupertino,
    );
  }
}
