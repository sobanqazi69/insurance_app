import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/page_transition.dart';

class NavigationService {
  // Haptic feedback types
  static void _lightHaptic() {
    HapticFeedback.lightImpact();
  }


  static void _heavyHaptic() {
    HapticFeedback.heavyImpact();
  }

  static void _selectionHaptic() {
    HapticFeedback.selectionClick();
  }

  // Navigation with haptic feedback and smooth transitions
  static void goTo(BuildContext context, String route, {
    bool useHeavyHaptic = false,
    bool useSelectionHaptic = false,
  }) {
    try {
      // Add haptic feedback
      if (useHeavyHaptic) {
        _heavyHaptic();
      } else if (useSelectionHaptic) {
        _selectionHaptic();
      } else {
        _lightHaptic();
      }

      // Navigate with smooth transition
      context.go(route);
    } catch (e) {
      debugPrint('Navigation error: $e');
      // Fallback navigation without haptic
      context.go(route);
    }
  }

  // Push navigation with haptic feedback and custom transitions
  static void pushTo(BuildContext context, Widget page, {
    bool useHeavyHaptic = false,
    bool useSelectionHaptic = false,
    PageTransitionType transitionType = PageTransitionType.slideFromRight,
  }) {
    try {
      // Add haptic feedback
      if (useHeavyHaptic) {
        _heavyHaptic();
      } else if (useSelectionHaptic) {
        _selectionHaptic();
      } else {
        _lightHaptic();
      }

      // Navigate with smooth transition
      Navigator.of(context).push(
        PageTransition(
          child: page,
          type: transitionType,
        ),
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      // Fallback navigation without haptic
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  // Pop navigation with haptic feedback
  static void pop(BuildContext context, {
    bool useSelectionHaptic = false,
  }) {
    try {
      // Add haptic feedback
      if (useSelectionHaptic) {
        _selectionHaptic();
      } else {
        _lightHaptic();
      }

      // Navigate back
      context.pop();
    } catch (e) {
      debugPrint('Navigation error: $e');
      // Fallback navigation without haptic
      context.pop();
    }
  }

  // Replace navigation with haptic feedback
  static void replaceWith(BuildContext context, String route, {
    bool useHeavyHaptic = false,
    bool useSelectionHaptic = false,
  }) {
    try {
      // Add haptic feedback
      if (useHeavyHaptic) {
        _heavyHaptic();
      } else if (useSelectionHaptic) {
        _selectionHaptic();
      } else {
        _lightHaptic();
      }

      // Navigate with replacement
      context.pushReplacement(route);
    } catch (e) {
      debugPrint('Navigation error: $e');
      // Fallback navigation without haptic
      context.pushReplacement(route);
    }
  }

  // Specific navigation methods for common routes
  static void goToHome(BuildContext context) {
    goTo(context, '/home', useHeavyHaptic: true);
  }

  static void goToLogin(BuildContext context) {
    goTo(context, '/login', useSelectionHaptic: true);
  }

  static void goToRegister(BuildContext context) {
    goTo(context, '/register', useSelectionHaptic: true);
  }

  static void goToRegister2(BuildContext context) {
    goTo(context, '/register-2', useSelectionHaptic: true);
  }

  static void goToOtp(BuildContext context) {
    goTo(context, '/otp', useSelectionHaptic: true);
  }

  static void goToSuccess(BuildContext context) {
    goTo(context, '/success', useHeavyHaptic: true);
  }
}
