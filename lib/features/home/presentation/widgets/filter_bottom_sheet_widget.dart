import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

/// A comprehensive filter bottom sheet widget for insurance search filtering.
/// 
/// This widget provides a modal bottom sheet interface with multiple filter options:
/// - Product Type selection with pill-style buttons
/// - Sum Insured range slider with real-time value display
/// - Premium Range input fields with currency formatting
/// - Tenor selection with predefined options
/// - Insurer, Excess, and Add-ons dropdown selections
/// 
/// Features:
/// - Responsive design for all screen sizes
/// - Proper focus management and keyboard handling
/// - Error handling with fallback UI
/// - Clean separation of concerns with dedicated methods
/// 
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   backgroundColor: Colors.transparent,
///   builder: (context) => const FilterBottomSheetWidget(),
/// );
/// ```
class FilterBottomSheetWidget extends StatefulWidget {
  /// Creates a filter bottom sheet widget
  const FilterBottomSheetWidget({super.key});

  @override
  State<FilterBottomSheetWidget> createState() => _FilterBottomSheetWidgetState();
}

/// State class for the FilterBottomSheetWidget
/// 
/// Manages the state of all filter options and handles user interactions
/// with proper error handling and performance optimizations.
class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  // Controllers for premium range input fields
  final TextEditingController _minPremiumController = TextEditingController();
  final TextEditingController _maxPremiumController = TextEditingController();
  
  // Selected filter values
  String _selectedProductType = _FilterConstants.defaultProductType;
  String _selectedTenor = _FilterConstants.defaultTenor;
  RangeValues _sumInsuredRange = _FilterConstants.defaultSumInsuredRange;
  
  // Available options for filter selections
  static const List<String> _productTypes = _FilterConstants.productTypes;
  static const List<String> _tenorOptions = _FilterConstants.tenorOptions;

  @override
  void dispose() {
    _minPremiumController.dispose();
    _maxPremiumController.dispose();
    super.dispose();
  }

  /// Builds the container decoration for the bottom sheet
  BoxDecoration _buildContainerDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(_FilterConstants.borderRadius),
        topRight: Radius.circular(_FilterConstants.borderRadius),
      ),
    );
  }

  /// Builds the header section with title and close button
  Widget _buildHeader(double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenHeight * _FilterConstants.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _FilterConstants.titleText,
            style: GoogleFonts.inter(
              fontSize: screenHeight * _FilterConstants.titleFontSize,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          _buildCloseButton(screenHeight),
        ],
      ),
    );
  }

  /// Builds the close button with proper focus management
  Widget _buildCloseButton(double screenHeight) {
    return GestureDetector(
      onTap: _handleCloseTap,
      child: Container(
        width: _FilterConstants.closeButtonSize,
        height: _FilterConstants.closeButtonSize,
        decoration: const BoxDecoration(
          color: _FilterConstants.closeButtonBackground,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close,
          size: screenHeight * _FilterConstants.closeIconSize,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  /// Handles close button tap with proper focus management
  void _handleCloseTap() {
    try {
      // Unfocus any TextField before closing
      FocusScope.of(context).unfocus();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error handling close tap: $e');
    }
  }

  /// Builds the main content area with all filter sections
  Widget _buildContent(double screenHeight) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenHeight * _FilterConstants.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Type Section
            _buildProductTypeSection(context),
            SizedBox(height: screenHeight * _FilterConstants.sectionSpacing),
            
            // Sum Insured Section
            _buildSumInsuredSection(context),
            SizedBox(height: screenHeight * _FilterConstants.sectionSpacing),
            
            // Premium Range Section
            _buildPremiumRangeSection(context),
            SizedBox(height: screenHeight * _FilterConstants.sectionSpacing),
            
            // Tenor Section
            _buildTenorSection(context),
            SizedBox(height: screenHeight * _FilterConstants.sectionSpacing),
            
            // Insurer Section
            _buildInsurerSection(context),
            SizedBox(height: screenHeight * _FilterConstants.sectionSpacing),
            
            // Excess Section
            _buildExcessSection(context),
            SizedBox(height: screenHeight * _FilterConstants.sectionSpacing),
            
            // Add-ons Section
            _buildAddonsSection(context),
            SizedBox(height: screenHeight * _FilterConstants.bottomSpacing),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height * 0.9;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Container(
        height: screenHeight * _FilterConstants.containerHeight,
        decoration: _buildContainerDecoration(),
        child: Column(
          children: [
            // Header
            _buildHeader(screenHeight),
            
            // Content
            _buildContent(screenHeight),
            
            // Done Button
            _buildDoneButton(screenHeight),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building filter bottom sheet: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildProductTypeSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Type',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Wrap(
          spacing: screenHeight * 0.01,
          runSpacing: screenHeight * 0.01,
          children: _productTypes.asMap().entries.map((entry) {
            final index = entry.key;
            final product = entry.value;
            final isSelected = index == 1; // Second item is selected
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedProductType = product;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.015,
                  vertical: screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.transparent : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.cyan : AppColors.border,
                    width: 1,
                  ),
                ),
                child: Text(
                  product,
                  style: GoogleFonts.inter(
                    fontSize: screenHeight * 0.014,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSumInsuredSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sum Insured',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Row(
          children: [
            Expanded(
              child: RangeSlider(
                values: _sumInsuredRange,
                min: 0,
                max: 500,
                activeColor: AppColors.cyan,
                inactiveColor: AppColors.borderLight,
                onChanged: (RangeValues values) {
                  setState(() {
                    _sumInsuredRange = values;
                  });
                },
              ),
            ),
            SizedBox(width: screenHeight * 0.02),
            Text(
              'Total: ${_sumInsuredRange.end.round()} \$',
              style: GoogleFonts.inter(
                fontSize: screenHeight * 0.014,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPremiumRangeSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Premium Range',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cyan),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenHeight * 0.015),
                      child: Text(
                        '\$',
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.016,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _minPremiumController,
                        decoration: const InputDecoration(
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.016,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: screenHeight * 0.015),
                      child: Text(
                        'USD',
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.014,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: screenHeight * 0.01),
            Text(
              '-',
              style: GoogleFonts.inter(
                fontSize: screenHeight * 0.018,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: screenHeight * 0.01),
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cyan),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenHeight * 0.015),
                      child: Text(
                        '\$',
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.016,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _maxPremiumController,
                        decoration: const InputDecoration(
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.016,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: screenHeight * 0.015),
                      child: Text(
                        'USD',
                        style: GoogleFonts.inter(
                          fontSize: screenHeight * 0.014,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTenorSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tenor',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Wrap(
          spacing: screenHeight * 0.01,
          children: _tenorOptions.map((tenor) {
            final isSelected = tenor == _selectedTenor;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTenor = tenor;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.015,
                  vertical: screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.transparent : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.cyan : AppColors.border,
                    width: 1,
                  ),
                ),
                child: Text(
                  tenor,
                  style: GoogleFonts.inter(
                    fontSize: screenHeight * 0.014,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInsurerSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insurer',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.cyan),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Name',
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.016,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                  size: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExcessSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Excess',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.cyan),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Excess',
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.016,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                  size: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddonsSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add-ons',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.cyan),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Add-Ons',
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.016,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                  size: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the done button with proper focus management
  Widget _buildDoneButton(double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenHeight * _FilterConstants.horizontalPadding),
      child: Container(
        width: double.infinity,
        height: _FilterConstants.buttonHeight,
        decoration: BoxDecoration(
          color: AppColors.cyan,
          borderRadius: BorderRadius.circular(_FilterConstants.borderRadius * 0.6), // 12px
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(_FilterConstants.borderRadius * 0.6),
            onTap: _handleDoneTap,
            child: Center(
              child: Text(
                _FilterConstants.doneButtonText,
                style: GoogleFonts.inter(
                  fontSize: screenHeight * _FilterConstants.buttonFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Handles done button tap with proper focus management
  void _handleDoneTap() {
    try {
      // Unfocus any TextField before closing
      FocusScope.of(context).unfocus();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error handling done tap: $e');
    }
  }
}

/// Constants for the FilterBottomSheetWidget
/// 
/// This class contains all the design constants, default values, and
/// configuration options used in the filter bottom sheet to ensure
/// consistency and maintainability.
class _FilterConstants {
  // Default values
  static const String defaultProductType = 'Product one';
  static const String defaultTenor = '2 Year';
  static const RangeValues defaultSumInsuredRange = RangeValues(0, 500);
  
  // Product type options
  static const List<String> productTypes = [
    'Product one',
    'Product one',
    'Product one',
    'Product one',
    'Product one',
    'Product one',
  ];
  
  // Tenor options
  static const List<String> tenorOptions = [
    '1 Year',
    '2 Year',
    '3 Year',
    '4 Year',
    '5 Year',
  ];
  
  // UI Constants
  static const double containerHeight = 0.9; // 90% of screen height
  static const double borderRadius = 20.0;
  static const double sectionSpacing = 0.03; // 3% of screen height
  static const double bottomSpacing = 0.04; // 4% of screen height
  static const double horizontalPadding = 0.025; // 2.5% of screen height
  
  // Text sizes
  static const double titleFontSize = 0.022; // 2.2% of screen height
  static const double labelFontSize = 0.018; // 1.8% of screen height
  static const double buttonFontSize = 0.018; // 1.8% of screen height
  static const double inputFontSize = 0.016; // 1.6% of screen height
  static const double smallFontSize = 0.014; // 1.4% of screen height
  
  // Spacing
  static const double labelSpacing = 0.015; // 1.5% of screen height
  static const double buttonSpacing = 0.01; // 1% of screen height
  static const double inputSpacing = 0.01; // 1% of screen height
  
  // Dimensions
  static const double inputHeight = 48.0;
  static const double buttonHeight = 48.0;
  static const double closeButtonSize = 32.0;
  static const double closeIconSize = 0.02; // 2% of screen height
  
  // Colors
  static const Color closeButtonBackground = Color(0xFFF1F5F9);
  
  // Text
  static const String titleText = 'Filters';
  static const String doneButtonText = 'Done';
  static const String productTypeLabel = 'Product Type';
  static const String sumInsuredLabel = 'Sum Insured';
  static const String premiumRangeLabel = 'Premium Range';
  static const String tenorLabel = 'Tenor';
  static const String insurerLabel = 'Insurer';
  static const String excessLabel = 'Excess';
  static const String addonsLabel = 'Add-ons';
  
  // Placeholders
  static const String insurerPlaceholder = 'Name';
  static const String excessPlaceholder = 'Excess';
  static const String addonsPlaceholder = 'Add-Ons';
  static const String currencySymbol = '\$';
  static const String currencyCode = 'USD';
  static const String rangeSeparator = '-';
  static const String totalPrefix = 'Total: ';
  static const String totalSuffix = ' \$';
}
