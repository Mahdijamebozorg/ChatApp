import 'package:flutter/material.dart';

//easier to implement
class SlideTransitionRoute extends MaterialPageRoute {
  SlideTransitionRoute({required WidgetBuilder builder})
      : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //don't animate on first route
    if (settings.name == '/') return child;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: child,
    );
  }
}

//has more options
class SlideTransitionRouteWithBackground extends PageRouteBuilder {
  SlideTransitionRouteWithBackground({
    required Widget Function(BuildContext, Animation, Animation) pageBuilder,
  }) : super(
          pageBuilder: pageBuilder,
          opaque: false,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: child,
    );
  }
}
