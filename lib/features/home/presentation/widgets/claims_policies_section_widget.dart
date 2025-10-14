import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class ClaimsPoliciesSectionWidget extends StatelessWidget {
  const ClaimsPoliciesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
        child: Column(
          children: [
            // My Claims Container
            _buildInfoContainer(
              context: context,
              title: 'My Claims',
              activeCount: '03',
              backgroundColor: AppColors.cyan,
              buttonColor: AppColors.viewButton,
              onTap: () {
                debugPrint('My Claims View All tapped');
                // Handle claims navigation
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            // My Policies Container
            _buildInfoContainer(
              context: context,
              title: 'My Policies',
              activeCount: '03',
              backgroundColor: const Color(0xFFF5F5DC), // Light beige/cream color
              buttonColor: const Color(0xFFD2691E), // Golden orange/brown color
              onTap: () {
                debugPrint('My Policies View All tapped');
                // Handle policies navigation
              },
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building claims and policies section: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildInfoContainer({
    required BuildContext context,
    required String title,
    required String activeCount,
    required Color backgroundColor,
    required Color buttonColor,
    required VoidCallback onTap,
  }) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Container(
        padding: EdgeInsets.all(screenHeight * 0.025),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side - Text content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'Active $activeCount',
                  style: GoogleFonts.inter(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            // Right side - View All button
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.012,
                ),
                elevation: 0,
              ),
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  fontSize: screenHeight * 0.018,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building info container: $e');
      return const SizedBox.shrink();
    }
  }
}
