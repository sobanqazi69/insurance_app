import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/models/insurance_model.dart';

class VerticalInsuranceCardsWidget extends StatelessWidget {
  const VerticalInsuranceCardsWidget({super.key});

  // Sample insurance data
  static const List<InsuranceModel> _sampleInsuranceData = [
    InsuranceModel(
      id: '1',
      companyName: 'Alfalah Car Insurance',
      premiumAmount: 'Rs. 5 Lac',
      monthlyAmount: 'Rs. 2500',
      workshopCount: '225',
    ),
    InsuranceModel(
      id: '2',
      companyName: 'Jubilee General Insurance',
      premiumAmount: 'Rs. 3 Lac',
      monthlyAmount: 'Rs. 1800',
      workshopCount: '180',
    ),
    InsuranceModel(
      id: '3',
      companyName: 'EFU General Insurance',
      premiumAmount: 'Rs. 4 Lac',
      monthlyAmount: 'Rs. 2200',
      workshopCount: '200',
    ),
    InsuranceModel(
      id: '4',
      companyName: 'Adamjee Insurance',
      premiumAmount: 'Rs. 6 Lac',
      monthlyAmount: 'Rs. 3000',
      workshopCount: '250',
    ),
    InsuranceModel(
      id: '5',
      companyName: 'Takaful Insurance',
      premiumAmount: 'Rs. 4.5 Lac',
      monthlyAmount: 'Rs. 2400',
      workshopCount: '190',
    ),
    InsuranceModel(
      id: '6',
      companyName: 'Pak Qatar Insurance',
      premiumAmount: 'Rs. 3.5 Lac',
      monthlyAmount: 'Rs. 2000',
      workshopCount: '170',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              'Search Results',
              style: GoogleFonts.inter(
                fontSize: screenHeight * 0.022,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Vertical ListView
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              itemCount: _sampleInsuranceData.length,
              itemBuilder: (context, index) {
                try {
                  final insurance = _sampleInsuranceData[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: _buildVerticalInsuranceCard(
                      context: context,
                      companyName: insurance.companyName,
                      premiumAmount: insurance.premiumAmount,
                      monthlyAmount: insurance.monthlyAmount,
                      workshopCount: insurance.workshopCount,
                    ),
                  );
                } catch (e) {
                  debugPrint('Error building insurance card at index $index: $e');
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      );
    } catch (e) {
      debugPrint('Error building vertical insurance cards: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildVerticalInsuranceCard({
    required BuildContext context,
    required String companyName,
    required String premiumAmount,
    required String monthlyAmount,
    required String workshopCount,
  }) {
    try {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final cardWidth = screenWidth * 0.9; // Use 90% width for vertical cards
      final cardHeight = screenHeight * 0.25; // Smaller height for vertical layout
      final padding = screenHeight * 0.02;
      
      return Container(
        width: cardWidth,
        height: cardHeight,
        // No margin for vertical cards - padding is handled by ListView
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: padding,
            left: padding,
            right: padding,
            bottom: padding * 0.25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, companyName, premiumAmount),
              SizedBox(height: padding),
              _buildInfoSection(context, monthlyAmount, workshopCount),
              SizedBox(height: padding),
              _buildActionButtons(context),
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building vertical insurance card: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildHeader(BuildContext context, String companyName, String premiumAmount) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Row(
        children: [
          _buildCompanyIcon(context),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName.split(' ').take(2).join(' '),
                  style: GoogleFonts.inter(
                    fontSize: screenHeight * 0.018,
                    fontWeight: FontWeight.w600,
                    color: AppColors.iconDark,
                  ),
                ),
                if (companyName.split(' ').length > 2)
                  Text(
                    companyName.split(' ').skip(2).join(' '),
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.018,
                      fontWeight: FontWeight.w600,
                      color: AppColors.iconDark,
                    ),
                  ),
              ],
            ),
          ),
          _buildPremiumTag(context, premiumAmount),
        ],
      );
    } catch (e) {
      debugPrint('Error building header: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildCompanyIcon(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final iconSize = screenHeight * 0.04;
      
      return Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Stack(
          children: [
            // Dark part of the icon
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: iconSize * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.iconDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
            // Green part of the icon
            Positioned(
              top: iconSize * 0.5,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.iconGreen,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
            // Center gap
            Center(
              child: Container(
                width: 2,
                height: iconSize * 0.2,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building company icon: $e');
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.iconDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.business,
          color: AppColors.white,
          size: 20,
        ),
      );
    }
  }

  Widget _buildPremiumTag(BuildContext context, String premiumAmount) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenHeight * 0.005,
        ),
        decoration: BoxDecoration(
          color: AppColors.premiumTag,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              premiumAmount,
              style: GoogleFonts.poppins(
                fontSize: screenHeight * 0.016,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            Text(
              'Premium',
              style: GoogleFonts.poppins(
                fontSize: screenHeight * 0.012,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building premium tag: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildInfoSection(BuildContext context, String monthlyAmount, String workshopCount) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      
      return Container(
        padding: EdgeInsets.all(screenHeight * 0.012),
        decoration: BoxDecoration(
          color: AppColors.cardInfoBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildInfoItem(context, monthlyAmount, 'Monthly'),
            ),
            Expanded(
              child: _buildInfoItem(context, workshopCount, 'Workshop'),
            ),
            Expanded(
              child: _buildInfoItem(context, workshopCount, 'Workshop'),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building info section: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildInfoItem(BuildContext context, String value, String label) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: screenHeight * 0.018,
              fontWeight: FontWeight.w700,
              color: AppColors.iconDark,
            ),
          ),
          SizedBox(height: screenHeight * 0.002),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: screenHeight * 0.012,
              fontWeight: FontWeight.w400,
              color: AppColors.iconDark,
            ),
          ),
        ],
      );
    } catch (e) {
      debugPrint('Error building info item: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    try {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCompareButton(context),
          _buildViewButton(context),
        ],
      );
    } catch (e) {
      debugPrint('Error building action buttons: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildCompareButton(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return OutlinedButton(
        onPressed: () {
          debugPrint('Compare tapped');
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.compareButton, width: 1.5),
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.012,
          ),
          minimumSize: Size(screenWidth * 0.22, screenHeight * 0.04),
        ),
        child: Text(
          'Compare',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.015,
            fontWeight: FontWeight.w600,
            color: AppColors.compareButton,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building compare button: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildViewButton(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      
      return ElevatedButton(
        onPressed: () {
          debugPrint('View tapped');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.012,
          ),
          minimumSize: Size(screenWidth * 0.22, screenHeight * 0.04),
          elevation: 0,
        ),
        child: Text(
          'View',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.015,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building view button: $e');
      return const SizedBox.shrink();
    }
  }
}
