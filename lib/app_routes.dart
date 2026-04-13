import 'package:flutter/material.dart';

PageRoute<T> atlasPageRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    // opaque: true — no black barrier is painted between pages.
    // Flutter calls transitionsBuilder for every animated route on the stack,
    // so the outgoing page fades out via its own secondaryAnimation automatically.
    opaque: true,
    pageBuilder: (_, __, ___) => page,
    transitionDuration: const Duration(milliseconds: 550),
    reverseTransitionDuration: const Duration(milliseconds: 420),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Incoming page: fade in + subtle upward drift
      final fadeIn = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      final slideIn = Tween<Offset>(
        begin: const Offset(0.0, 0.035),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      // Outgoing page: fades out as the new page arrives
      final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeInCubic,
        ),
      );

      return FadeTransition(
        opacity: fadeOut,
        child: FadeTransition(
          opacity: fadeIn,
          child: SlideTransition(position: slideIn, child: child),
        ),
      );
    },
  );
}
