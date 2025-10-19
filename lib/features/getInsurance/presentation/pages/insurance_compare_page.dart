import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';

class InsuranceComparePage extends StatefulWidget {
  const InsuranceComparePage({super.key});

  @override
  State<InsuranceComparePage> createState() => _InsuranceComparePageState();
}

class _InsuranceComparePageState extends State<InsuranceComparePage> {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building InsuranceComparePage: $e');
      return _buildErrorWidget(context);
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: _buildBackButton(context),
      title: _buildTitle(),
      centerTitle: false,
      titleSpacing: 0,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      onPressed: () => _handleBackNavigation(context),
      icon: const Icon(
        Icons.arrow_back_ios,
        color: AppColors.white,
        size: 20.0,
      ),
    );
  }

  void _handleBackNavigation(BuildContext context) {
    try {
      NavigationService.pop(context);
    } catch (e) {
      debugPrint('Error handling back navigation: $e');
    }
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All categories.',
          style: GoogleFonts.poppins(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: AppColors.white.withOpacity(0.8),
          ),
        ),
        Text(
          'Insurance Plans',
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildComparisonTable(context),
        ],
      ),
    );
  }


  Widget _buildComparisonTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
       
      ),
      child: Column(
        children: [
          _buildTableHeader(context),
          _buildTableContent(context),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        color: AppColors.primary,
      
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildInsuranceHeader(context, 'Askari Health Insurance', 'A', const Color(0xFFFF6B35)),
          ),
          Expanded(
            flex: 2,
            child: _buildInsuranceHeader(context, 'Askari Health Insurance', 'e', const Color(0xFF4CAF50)),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceHeader(BuildContext context, String name, String logo, Color logoColor) {
    return Column(
      children: [
        _buildCompanyLogo(context, logoColor),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.014,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCompanyLogo(BuildContext context, Color logoColor) {
    final logoSize = MediaQuery.of(context).size.height * 0.08;

    return Container(
      width: logoSize,
      height: logoSize,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 12.0,
            top: 8.0,
            bottom: 8.0,
            child: Container(
              width: 8.0,
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          Positioned(
            top: 8.0,
            left: 12.0,
            right: 12.0,
            child: Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          Positioned(
            top: 16.0,
            right: 12.0,
            bottom: 8.0,
            child: Container(
              width: 8.0,
              decoration: BoxDecoration(
                color: AppColors.info,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableContent(BuildContext context) {
    return Column(
      children: [
        _buildTableRow(context, 'Premium', 'PKR 1,200', 'PKR 1,500', false, false),
        _buildTableRow(context, 'Sum insured', 'PKR 10,000k', 'PKR 15,000k', false, false),
        _buildTableRow(context, 'Deductible', 'PKR 10,000', 'PKR 15,000', false, false),
        _buildBenefitsRow(context),
      ],
    );
  }

  Widget _buildTableRow(BuildContext context, String label, String value1, String value2, bool isBeige1, bool isBeige2) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
                ),
              ),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.016,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
                vertical: MediaQuery.of(context).size.height * 0.005,
              ),
              decoration: BoxDecoration(
                color: isBeige1 ? const Color(0xFFF5F5DC) : AppColors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border(
                  right: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
                ),
              ),
              child: Text(
                value1,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.014,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
                vertical: MediaQuery.of(context).size.height * 0.005,
              ),
              decoration: BoxDecoration(
                color: isBeige2 ? const Color(0xFFF5F5DC) : AppColors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                value2,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.014,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
                    ),
                  ),
                  child: Text(
                    'Key Benefits',
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height * 0.016,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          _buildBenefitItem(context, 'Credit Facility in 200+ Hospitals all across Pakistan', true, true),
          _buildBenefitItem(context, 'No Medical Test Required', false, true),
          _buildBenefitItem(context, '14 days free look up period - option of cancelling if not satisfied', false, true),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildActionButtonsRow(context),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, String benefit, bool hasBenefit1, bool hasBenefit2) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
                ),
              ),
              child: Text(
                benefit,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.014,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
                ),
              ),
              child: Center(
                child: Icon(
                  hasBenefit1 ? Icons.check : Icons.close,
                  color: hasBenefit1 ? const Color(0xFFFF6B35) : const Color(0xFFFF6B35),
                  size: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Icon(
                hasBenefit2 ? Icons.check : Icons.close,
                color: hasBenefit2 ? AppColors.cyan : AppColors.cyan,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtonsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: AppColors.border.withOpacity(0.3), width: 1.0),
              ),
            ),
            child: Column(
              children: [
                _buildActionButton(context, 'Policy Document', const Color(0xFFF5F5DC), AppColors.textSecondary),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _buildActionButton(context, 'Claim Document', const Color(0xFFF5F5DC), AppColors.textSecondary),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                _buildActionButton(context, 'View Details', AppColors.cyan, AppColors.white),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildActionButton(context, 'Policy Document', const Color(0xFFF5F5DC), AppColors.textSecondary),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              _buildActionButton(context, 'Claim Document', const Color(0xFFF5F5DC), AppColors.textSecondary),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              _buildActionButton(context, 'View Details', AppColors.cyan, AppColors.white),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String text, Color backgroundColor, Color textColor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: MediaQuery.of(context).size.height * 0.012,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => NavigationService.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
        ),
        title: Text(
          'Insurance Plans',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Error loading comparison',
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
