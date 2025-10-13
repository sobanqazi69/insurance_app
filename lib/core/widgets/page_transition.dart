import 'package:flutter/material.dart';

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
  final Duration duration;

  PageTransition({
    required this.child,
    this.type = PageTransitionType.slideFromRight,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (type) {
              case PageTransitionType.slideFromRight:
                return _slideFromRight(animation, child);
              case PageTransitionType.slideFromLeft:
                return _slideFromLeft(animation, child);
              case PageTransitionType.fadeIn:
                return _fadeIn(animation, child);
              case PageTransitionType.scaleIn:
                return _scaleIn(animation, child);
              case PageTransitionType.slideUp:
                return _slideUp(animation, child);
            }
          },
        );

  static Widget _slideFromRight(Animation<double> animation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget _slideFromLeft(Animation<double> animation, Widget child) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget _fadeIn(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget _scaleIn(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  static Widget _slideUp(Animation<double> animation, Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

enum PageTransitionType {
  slideFromRight,
  slideFromLeft,
  fadeIn,
  scaleIn,
  slideUp,
}
