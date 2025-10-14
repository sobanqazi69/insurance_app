import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  const FilterBottomSheetWidget({super.key});

  @override
  State<FilterBottomSheetWidget> createState() => _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  
  String _selectedCategory = 'All';
  String _selectedSortBy = 'Relevance';
  String _selectedSortOrder = 'Ascending';

  final List<String> _categories = [
    'All',
    'Car Insurance',
    'Health Insurance',
    'Life Insurance',
    'Travel Insurance',
    'Home Insurance',
  ];

  final List<String> _sortOptions = [
    'Relevance',
    'Price',
    'Rating',
    'Popularity',
  ];

  final List<String> _sortOrders = [
    'Ascending',
    'Descending',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Container(
        height: screenHeight * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.015),
              width: screenWidth * 0.15,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.024,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: screenHeight * 0.025,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Field
                    _buildSearchField(context),
                    SizedBox(height: screenHeight * 0.025),
                    
                    // Category Section
                    _buildCategorySection(context),
                    SizedBox(height: screenHeight * 0.025),
                    
                    // Price Range Section
                    _buildPriceRangeSection(context),
                    SizedBox(height: screenHeight * 0.025),
                    
                    // Sort By Section
                    _buildSortBySection(context),
                    SizedBox(height: screenHeight * 0.025),
                    
                    // Sort Order Section
                    _buildSortOrderSection(context),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              ),
            ),
            
            // Bottom Buttons
            _buildBottomButtons(context),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building filter bottom sheet: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildSearchField(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        CustomTextField(
          hintText: 'Search insurance...',
          controller: _searchController,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: screenHeight * 0.02,
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Wrap(
          spacing: screenHeight * 0.01,
          runSpacing: screenHeight * 0.01,
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.015,
                  vertical: screenHeight * 0.008,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 1,
                  ),
                ),
                child: Text(
                  category,
                  style: GoogleFonts.inter(
                    fontSize: screenHeight * 0.014,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hintText: 'Min Price',
                controller: _minPriceController,
                keyboardType: TextInputType.number,
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: AppColors.textSecondary,
                  size: screenHeight * 0.02,
                ),
              ),
            ),
            SizedBox(width: screenHeight * 0.015),
            Expanded(
              child: CustomTextField(
                hintText: 'Max Price',
                controller: _maxPriceController,
                keyboardType: TextInputType.number,
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: AppColors.textSecondary,
                  size: screenHeight * 0.02,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSortBySection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort By',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSortBy,
              isExpanded: true,
              items: _sortOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.016,
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedSortBy = newValue;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSortOrderSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort Order',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSortOrder,
              isExpanded: true,
              items: _sortOrders.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.016,
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedSortOrder = newValue;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.025),
      child: Row(
        children: [
            Expanded(
              child: CustomButton(
                text: 'Clear All',
                isOutlined: true,
                backgroundColor: AppColors.border,
                textColor: AppColors.textPrimary,
                onPressed: () {
                  _clearAllFilters();
                },
              ),
            ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: CustomButton(
              text: 'Apply Filters',
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
              onPressed: () {
                _applyFilters();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _clearAllFilters() {
    setState(() {
      _searchController.clear();
      _minPriceController.clear();
      _maxPriceController.clear();
      _selectedCategory = 'All';
      _selectedSortBy = 'Relevance';
      _selectedSortOrder = 'Ascending';
    });
  }

  void _applyFilters() {
    // Handle filter application
    debugPrint('Applied filters:');
    debugPrint('Search: ${_searchController.text}');
    debugPrint('Category: $_selectedCategory');
    debugPrint('Min Price: ${_minPriceController.text}');
    debugPrint('Max Price: ${_maxPriceController.text}');
    debugPrint('Sort By: $_selectedSortBy');
    debugPrint('Sort Order: $_selectedSortOrder');
    
    Navigator.pop(context);
  }
}
