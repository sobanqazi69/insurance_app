import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';

class InsuranceCompareBottomSheet extends StatefulWidget {
  const InsuranceCompareBottomSheet({super.key});

  @override
  State<InsuranceCompareBottomSheet> createState() => _InsuranceCompareBottomSheetState();
}

class _InsuranceCompareBottomSheetState extends State<InsuranceCompareBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<bool> _selectedItems = List.generate(6, (index) => index == 0); // First item selected by default

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildSearchBar(context),
          _buildInsuranceList(context),
          _buildDoneButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add to Compare',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.022,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.width * 0.08,
              decoration: BoxDecoration(
                color: AppColors.border.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: AppColors.textSecondary,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.06,
        // decoration: BoxDecoration(
        //   color: AppColors.white,
        //   borderRadius: BorderRadius.circular(25.0),
        //   border: Border.all(color: AppColors.border, width: 1.0),
        // ),
        child: TextField(
          controller: _searchController,
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),

        
          decoration: InputDecoration(
            filled: false,
            hintText: 'Search in\nInsurance Name',
            hintStyle: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.014,
              fontWeight: FontWeight.w400,
              color: AppColors.textTertiary,
              height: 1.2,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.textSecondary,
              size: MediaQuery.of(context).size.height * 0.02,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInsuranceList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.02,
        ),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return _buildInsuranceItem(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildInsuranceItem(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.015),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColors.border, width: 1.0),
        ),
        child: Row(
          children: [
            // Insurance Logo
            Container(
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.width * 0.12,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'A',
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * 0.024,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            // Insurance Name
            Expanded(
              child: Text(
                'Alfalah Car Insurance',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.016,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            // Checkbox
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedItems[index] = !_selectedItems[index];
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.06,
                height: MediaQuery.of(context).size.width * 0.06,
                decoration: BoxDecoration(
                  color: _selectedItems[index] ? AppColors.cyan : AppColors.white,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: _selectedItems[index] ? AppColors.cyan : AppColors.border,
                    width: 1.0,
                  ),
                ),
                child: _selectedItems[index]
                    ? Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: MediaQuery.of(context).size.height * 0.016,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.06,
        child: ElevatedButton(
          onPressed: () => _handleDone(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cyan,
            foregroundColor: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            'Done',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _handleDone(BuildContext context) {
    try {
      debugPrint('Done button tapped');
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error handling done: $e');
    }
  }
}
