import 'package:flutter/material.dart';

/// Centralized navigation service for the app
class NavigationService {
  /// Navigate to a new screen with specified transition
  static Future<T?> navigateTo<T>(
    BuildContext context,
    Widget destination, {
    TransitionType transition = TransitionType.slide,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).push<T>(
      _createRoute(
        destination,
        transition: transition,
        duration: duration,
      ),
    );
  }

  /// Navigate to a new screen and replace the current one
  static Future<T?> navigateWithReplacement<T>(
    BuildContext context,
    Widget destination, {
    TransitionType transition = TransitionType.fade,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).pushReplacement(
      _createRoute(
        destination,
        transition: transition,
        duration: duration,
      ),
    );
  }

  /// Navigate and remove all previous routes
  static Future<T?> navigateAndRemoveUntil<T>(
    BuildContext context,
    Widget destination, {
    TransitionType transition = TransitionType.fade,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      _createRoute(
        destination,
        transition: transition,
        duration: duration,
      ),
      (route) => false,
    );
  }

  /// Create a route with the specified transition
  static Route<T> _createRoute<T>(
    Widget destination, {
    TransitionType transition = TransitionType.slide,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
            
          case TransitionType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
            
          case TransitionType.scale:
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.9,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
            
          case TransitionType.slideUp:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
            
          case TransitionType.elegant:
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            return FadeTransition(
              opacity: curvedAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
        }
      },
      transitionDuration: duration,
    );
  }
}

/// Transition types for navigation animations
enum TransitionType {
  fade,
  slide,
  scale,
  slideUp,
  elegant,
}

