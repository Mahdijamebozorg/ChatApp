import 'package:flutter/material.dart';

class SlideTransitionRoute extends MaterialPageRoute {
  SlideTransitionRoute({required WidgetBuilder builder})
      : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //don't animate on first route
    if (settings.name == '/') {
      return child;
    }
    return SlideTransition(
      child: child,
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
    );
  }
}
