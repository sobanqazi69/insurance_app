import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import 'filter_bottom_sheet_widget.dart';

/// A horizontal filter bar widget with multiple filter categories.
/// 
/// This widget provides:
/// - Horizontal scrollable filter categories
/// - Interactive filter buttons with icons and labels
/// - Special "Filters" button that opens the filter bottom sheet
/// - Responsive design for all screen sizes
/// 
/// Features:
/// - Clean, modern design with proper spacing
/// - Error handling with fallback UI
/// - Performance optimizations
/// - Proper focus management
/// 
/// Usage:
/// ```dart
/// const FilterBarWidget()
/// ```
class FilterBarWidget extends StatelessWidget {
  /// Creates a filter bar widget
  const FilterBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * _FilterBarConstants.horizontalMargin),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * _FilterBarConstants.horizontalPadding,
          vertical: screenHeight * _FilterBarConstants.verticalPadding,
        ),
        decoration: _buildContainerDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildFilterItems(context),
        ),
      );
    } catch (e) {
      debugPrint('Error building filter bar: $e');
      return _buildErrorWidget();
    }
  }

  /// Builds the container decoration
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(_FilterBarConstants.borderRadius),
      border: Border.all(
        color: Colors.black,
        width: _FilterBarConstants.borderWidth,
      ),
    );
  }

  /// Builds the list of filter items
  List<Widget> _buildFilterItems(BuildContext context) {
    return [
      _buildFilterItem(
        context: context,
        icon: _FilterBarConstants.carIcon,
        label: _FilterBarConstants.carLabel,
      ),
      _buildFilterItem(
        context: context,
        icon: _FilterBarConstants.familyIcon,
        label: _FilterBarConstants.familyLabel,
      ),
      _buildFilterItem(
        context: context,
        icon: _FilterBarConstants.financeIcon,
        label: _FilterBarConstants.financeLabel,
      ),
      _buildFilterItem(
        context: context,
        icon: _FilterBarConstants.healthIcon,
        label: _FilterBarConstants.healthLabel,
      ),
      _buildFilterItem(
        context: context,
        icon: _FilterBarConstants.filtersIcon,
        label: _FilterBarConstants.filtersLabel,
        onTap: () => _showFilterBottomSheet(context),
      ),
    ];
  }

  /// Builds error widget as fallback
  Widget _buildErrorWidget() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: const Center(
        child: Text('Filters unavailable'),
      ),
    );
  }

  /// Builds an individual filter item with icon and label
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
        onTap: onTap ?? () => _handleFilterTap(label),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterIcon(screenWidth, icon),
            SizedBox(height: screenHeight * _FilterBarConstants.labelSpacing),
            _buildFilterLabel(screenHeight, label),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building filter item: $e');
      return const SizedBox.shrink();
    }
  }

  /// Builds the filter icon container
  Widget _buildFilterIcon(double screenWidth, IconData icon) {
    return Container(
      width: screenWidth * _FilterBarConstants.iconSize,
      height: screenWidth * _FilterBarConstants.iconSize,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(_FilterBarConstants.iconBackgroundOpacity),
        borderRadius: BorderRadius.circular(_FilterBarConstants.iconBorderRadius),
      ),
      child: Icon(
        icon,
        color: AppColors.white,
        size: screenWidth * _FilterBarConstants.iconInnerSize,
      ),
    );
  }

  /// Builds the filter label text
  Widget _buildFilterLabel(double screenHeight, String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: screenHeight * _FilterBarConstants.labelFontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    );
  }

  /// Handles filter tap with error handling
  void _handleFilterTap(String label) {
    try {
      debugPrint('Filter tapped: $label');
      // Handle filter selection logic here
    } catch (e) {
      debugPrint('Error handling filter tap: $e');
    }
  }

  /// Shows the filter bottom sheet with proper focus management
  void _showFilterBottomSheet(BuildContext context) {
    try {
      // Unfocus any TextField before showing bottom sheet
      FocusScope.of(context).unfocus();
      
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const FilterBottomSheetWidget(),
      );
    } catch (e) {
      debugPrint('Error showing filter bottom sheet: $e');
    }
  }
}

/// Constants for the FilterBarWidget
/// 
/// This class contains all the design constants and configuration options
/// used in the filter bar to ensure consistency and maintainability.
class _FilterBarConstants {
  // Layout constants
  static const double horizontalMargin = 0.05; // 5% of screen width
  static const double horizontalPadding = 0.04; // 4% of screen width
  static const double verticalPadding = 0.02; // 2% of screen height
  static const double labelSpacing = 0.008; // 0.8% of screen height
  
  // Visual constants
  static const double borderRadius = 12.0;
  static const double borderWidth = 1.5;
  static const double iconSize = 0.12; // 12% of screen width
  static const double iconInnerSize = 0.06; // 6% of screen width
  static const double iconBorderRadius = 8.0;
  static const double iconBackgroundOpacity = 0.1;
  
  // Text constants
  static const double labelFontSize = 0.014; // 1.4% of screen height
  
  // Filter icons
  static const IconData carIcon = Icons.directions_car;
  static const IconData familyIcon = Icons.family_restroom;
  static const IconData financeIcon = Icons.account_balance;
  static const IconData healthIcon = Icons.health_and_safety;
  static const IconData filtersIcon = Icons.tune;
  
  // Filter labels
  static const String carLabel = 'Car';
  static const String familyLabel = 'Family';
  static const String financeLabel = 'Finance';
  static const String healthLabel = 'Health';
  static const String filtersLabel = 'Filters';
}
