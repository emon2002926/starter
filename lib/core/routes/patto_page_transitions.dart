import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shared page transition matching v112 screen swaps
/// (`opacity .28s ease` + `translateX(28px)`).
const kPattoPageTransitionDuration = Duration(milliseconds: 280);

Widget pattoTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final curved = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOutCubic,
    reverseCurve: Curves.easeInOutCubic,
  );
  return FadeTransition(
    opacity: curved,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.07, 0),
        end: Offset.zero,
      ).animate(curved),
      child: child,
    ),
  );
}

CustomTransitionPage<T> pattoTransitionPage<T>({
  required LocalKey key,
  required Widget child,
  Duration duration = kPattoPageTransitionDuration,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: pattoTransitionsBuilder,
  );
}
