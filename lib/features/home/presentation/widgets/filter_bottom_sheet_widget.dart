import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/core/widgets/custom_text_field.dart';
import '../../../../core/constants/colors.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  const FilterBottomSheetWidget({super.key});

  @override
  State<FilterBottomSheetWidget> createState() => _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  final TextEditingController _minPremiumController = TextEditingController();
  final TextEditingController _maxPremiumController = TextEditingController();
  
  String _selectedProductType = 'Product one';
  String _selectedTenor = '2 Year';
  RangeValues _sumInsuredRange = const RangeValues(0, 500);
  
  final List<String> _productTypes = [
    'Product one',
    'Product one',
    'Product one',
    'Product one',
    'Product one',
    'Product one',
  ];

  final List<String> _tenorOptions = [
    '1 Year',
    '2 Year',
    '3 Year',
    '4 Year',
    '5 Year',
  ];

  @override
  void dispose() {
    _minPremiumController.dispose();
    _maxPremiumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Container(
        height: screenHeight * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.022,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.borderLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: screenHeight * 0.02,
                        color: AppColors.textPrimary,
                      ),
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
                    // Product Type Section
                    _buildProductTypeSection(context),
                    SizedBox(height: screenHeight * 0.03),
                    
                    // Sum Insured Section
                    _buildSumInsuredSection(context),
                    SizedBox(height: screenHeight * 0.03),
                    
                    // Premium Range Section
                    _buildPremiumRangeSection(context),
                    SizedBox(height: screenHeight * 0.03),
                    
                    // Tenor Section
                    _buildTenorSection(context),
                    SizedBox(height: screenHeight * 0.03),
                    
                    // Insurer Section
                    _buildInsurerSection(context),
                    SizedBox(height: screenHeight * 0.03),
                    
                    // Excess Section
                    _buildExcessSection(context),
                    SizedBox(height: screenHeight * 0.03),
                    
                    // Add-ons Section
                    _buildAddonsSection(context),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              ),
            ),
            
            // Done Button
            _buildDoneButton(context),
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

  Widget _buildDoneButton(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.025),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.cyan,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                'Done',
                style: GoogleFonts.inter(
                  fontSize: screenHeight * 0.018,
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


}
