import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

/// A custom search bar widget with integrated search and filter functionality.
/// 
/// This widget provides a clean, accessible search interface with:
/// - Search input field with custom styling
/// - Integrated search icon with tap handling
/// - Filter button with active state indication
/// - Proper focus management and keyboard handling
/// 
/// Usage:
/// ```dart
/// CustomSearchBar(
///   controller: searchController,
///   onChanged: (value) => handleSearch(value),
///   onFilterTap: () => showFilterOptions(),
///   isFilterActive: hasActiveFilters,
/// )
/// ```
class CustomSearchBar extends StatelessWidget {
  /// Callback triggered when search icon is tapped
  final VoidCallback? onSearchTap;
  
  /// Callback triggered when filter button is tapped
  final VoidCallback? onFilterTap;
  
  /// Callback triggered when search bar container is tapped
  final VoidCallback? onTap;
  
  /// Controller for the search text input
  final TextEditingController? controller;
  
  /// Callback triggered when search text changes
  final ValueChanged<String>? onChanged;
  
  /// Whether the filter is currently active (affects button styling)
  final bool isFilterActive;

  /// Creates a custom search bar widget
  const CustomSearchBar({
    super.key,
    this.onSearchTap,
    this.onFilterTap,
    this.onTap,
    this.controller,
    this.onChanged,
    this.isFilterActive = false,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return GestureDetector(
        onTap: _handleContainerTap,
        child: Container(
          height: _SearchBarConstants.containerHeight,
          decoration: _buildContainerDecoration(),
          child: Padding(
            padding: _SearchBarConstants.horizontalPadding,
            child: Row(
              children: [
                _buildSearchIcon(),
                _SearchBarConstants.iconSpacing,
                _buildTextField(),
                _SearchBarConstants.iconSpacing,
                _buildFilterButton(),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building CustomSearchBar: $e');
      return _buildErrorWidget();
    }
  }

  /// Handles container tap with haptic feedback and error handling
  void _handleContainerTap() {
    try {
      HapticFeedback.selectionClick();
      onTap?.call();
    } catch (e) {
      debugPrint('Error handling container tap: $e');
    }
  }

  /// Builds the container decoration with transparent background and border
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_SearchBarConstants.borderRadius),
      border: Border.all(
        color: AppColors.primary,
        width: _SearchBarConstants.borderWidth,
      ),
    );
  }

  /// Builds the search icon with tap handling
  Widget _buildSearchIcon() {
    return GestureDetector(
      onTap: _handleSearchTap,
      child: Container(
        width: _SearchBarConstants.iconSize,
        height: _SearchBarConstants.iconSize,
        decoration: BoxDecoration(
          color: _SearchBarConstants.iconBackgroundColor,
          borderRadius: BorderRadius.circular(_SearchBarConstants.iconBorderRadius),
        ),
        child: const Icon(
          Icons.search,
          size: _SearchBarConstants.searchIconSize,
          color: AppColors.primary,
        ),
      ),
    );
  }

  /// Handles search icon tap with haptic feedback and error handling
  void _handleSearchTap() {
    try {
      HapticFeedback.selectionClick();
      onSearchTap?.call();
    } catch (e) {
      debugPrint('Error handling search tap: $e');
    }
  }

  /// Builds the text input field with proper styling
  Widget _buildTextField() {
    return Expanded(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: _buildInputDecoration(),
        style: _buildTextStyle(),
      ),
    );
  }

  /// Builds the input decoration with transparent background
  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      hintText: _SearchBarConstants.hintText,
      hintStyle: _buildHintStyle(),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.zero,
    );
  }

  /// Builds the hint text style
  TextStyle _buildHintStyle() {
    return GoogleFonts.inter(
      fontSize: _SearchBarConstants.fontSize,
      fontWeight: FontWeight.w400,
      color: _SearchBarConstants.hintTextColor,
    );
  }

  /// Builds the main text style
  TextStyle _buildTextStyle() {
    return GoogleFonts.inter(
      fontSize: _SearchBarConstants.fontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    );
  }

  /// Builds the filter button with active state styling
  Widget _buildFilterButton() {
    return GestureDetector(
      onTap: _handleFilterTap,
      child: Container(
        padding: _SearchBarConstants.filterButtonPadding,
        decoration: BoxDecoration(
          color: isFilterActive 
              ? AppColors.cyan 
              : _SearchBarConstants.iconBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          _SearchBarConstants.sortIconPath,
          width: _SearchBarConstants.filterIconSize,
          height: _SearchBarConstants.filterIconSize,
          colorFilter: ColorFilter.mode(
            isFilterActive ? Colors.white : AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  /// Handles filter button tap with haptic feedback and error handling
  void _handleFilterTap() {
    try {
      HapticFeedback.selectionClick();
      onFilterTap?.call();
    } catch (e) {
      debugPrint('Error handling filter tap: $e');
    }
  }

  /// Builds error widget as fallback
  Widget _buildErrorWidget() {
    return Container(
      height: _SearchBarConstants.containerHeight,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(_SearchBarConstants.borderRadius),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: const Center(
        child: Text('Search unavailable'),
      ),
    );
  }
}

/// Constants for the CustomSearchBar widget
/// 
/// This class contains all the design constants used in the CustomSearchBar
/// to ensure consistency and maintainability.
class _SearchBarConstants {
  // Dimensions
  static const double containerHeight = 56.0;
  static const double borderRadius = 28.0;
  static const double borderWidth = 1.0;
  static const double iconSize = 32.0;
  static const double iconBorderRadius = 16.0;
  static const double searchIconSize = 18.0;
  static const double filterIconSize = 10.0;
  
  // Spacing
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 16);
  static const SizedBox iconSpacing = SizedBox(width: 12);
  static const EdgeInsets filterButtonPadding = EdgeInsets.all(12);
  
  // Colors
  static const Color iconBackgroundColor = Color(0xFFF5F5F5);
  static const Color hintTextColor = Color(0xFF9E9E9E);
  
  // Text
  static const String hintText = 'Search Insurance...';
  static const String sortIconPath = 'assets/icons/sort_icon.svg';
  static const double fontSize = 14.0;
}
