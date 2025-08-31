import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final bool showUmbrellaIcon;

  const AuthBackground({
    super.key,
    required this.child,
    this.showUmbrellaIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cyan,
            AppColors.cyan,
            AppColors.cyan,
            AppColors.cyan,



AppColors.pureWhite,

AppColors.pureWhite,




          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/auth_bg.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.25),
            ),
          ),
          
         
          
          // Content
          child,
        ],
      ),
    );
  }
}
