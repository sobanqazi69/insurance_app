import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            context: context,
            index: 0,
            iconPath: 'assets/icons/list_icon.svg',
            label: 'List',
            isActive: currentIndex == 0,
          ),
          _buildNavItem(
            context: context,
            index: 1,
            iconPath: 'assets/icons/home_icon.svg',
            label: 'Home',
            isActive: currentIndex == 1,
          ),
          _buildNavItem(
            context: context,
            index: 2,
            iconPath: 'assets/icons/profile_icon.svg',
            label: 'Profile',
            isActive: currentIndex == 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required String iconPath,
    required String label,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        // Add haptic feedback
        HapticFeedback.selectionClick();
        onTap(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.cyan : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: isActive ? AppColors.primary : const Color(0xFF424242),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
