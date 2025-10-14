import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import 'filter_bottom_sheet_widget.dart';

class FilterBarWidget extends StatelessWidget {
  const FilterBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterItem(
              context: context,
              icon: Icons.directions_car,
              label: 'Car',
            ),
            _buildFilterItem(
              context: context,
              icon: Icons.family_restroom,
              label: 'Family',
            ),
            _buildFilterItem(
              context: context,
              icon: Icons.account_balance,
              label: 'Finance',
            ),
            _buildFilterItem(
              context: context,
              icon: Icons.health_and_safety,
              label: 'Health',
            ),
            _buildFilterItem(
              context: context,
              icon: Icons.tune,
              label: 'Filters',
              onTap: () {
                _showFilterBottomSheet(context);
              },
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building filter bar: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildFilterItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return GestureDetector(
        onTap: onTap ?? () {
          debugPrint('Filter tapped: $label');
          // Handle filter selection
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.white,
                size: screenWidth * 0.06,
              ),
            ),
            SizedBox(height: screenHeight * 0.008),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: screenHeight * 0.014,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building filter item: $e');
      return const SizedBox.shrink();
    }
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheetWidget(),
    );
  }
}
