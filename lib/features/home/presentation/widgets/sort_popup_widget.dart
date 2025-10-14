import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class SortPopupWidget extends StatelessWidget {
  final VoidCallback onClose;
  final String selectedSort;
  final Function(String) onSortSelected;

  const SortPopupWidget({
    super.key,
    required this.onClose,
    required this.selectedSort,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    try {
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Container(
        width: screenWidth * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(context),
            // Divider
            Container(
              height: 1,
              color: AppColors.borderLight,
            ),
            // Sort Options
            _buildSortOptions(context),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building sort popup: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildHeader(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sorter',
            style: GoogleFonts.inter(
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: Icon(
              Icons.close,
              size: screenHeight * 0.025,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOptions(BuildContext context) {
    final sortOptions = [
      {
        'id': 'newest',
        'title': 'Newest',
        'icon': Icons.swap_vert,
      },
      {
        'id': 'price_low_high',
        'title': 'Price (Low to high)',
        'icon': Icons.keyboard_arrow_up,
      },
      {
        'id': 'price_high_low',
        'title': 'Price (High to Low)',
        'icon': Icons.keyboard_arrow_down,
      },
      {
        'id': 'popular',
        'title': 'Popular',
        'icon': Icons.casino,
      },
    ];

    return Column(
      children: sortOptions.map((option) {
        final isSelected = selectedSort == option['id'];
        return _buildSortOption(
          context: context,
          title: option['title'] as String,
          icon: option['icon'] as IconData,
          isSelected: isSelected,
          onTap: () {
            onSortSelected(option['id'] as String);
            onClose();
          },
        );
      }).toList(),
    );
  }

  Widget _buildSortOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenHeight * 0.02,
          vertical: screenHeight * 0.015,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cyan.withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: screenHeight * 0.03,
              height: screenHeight * 0.03,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.cyan : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                icon,
                size: screenHeight * 0.018,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
            SizedBox(width: screenHeight * 0.015),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: screenHeight * 0.016,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
