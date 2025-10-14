import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class InsuranceCard extends StatelessWidget {
  final String companyName;
  final String premiumAmount;
  final String monthlyAmount;
  final String workshopCount;
  final VoidCallback? onCompare;
  final VoidCallback? onView;

  const InsuranceCard({
    super.key,
    required this.companyName,
    required this.premiumAmount,
    required this.monthlyAmount,
    required this.workshopCount,
    this.onCompare,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    try {
      final screenWidth = MediaQuery.of(context).size.width;
      final cardWidth = screenWidth * 0.85;
      
      return Container(
        width: cardWidth,
        margin: const EdgeInsets.only(right: 16),
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
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildInfoSection(),
              const SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building InsuranceCard: $e');
      final screenWidth = MediaQuery.of(context).size.width;
      final cardWidth = screenWidth * 0.85;
      return Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        child: const Center(
          child: Text('Error loading card'),
        ),
      );
    }
  }

  Widget _buildHeader() {
    try {
      return Row(
        children: [
          _buildCompanyIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName.split(' ').take(2).join(' '),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.iconDark,
                  ),
                ),
                if (companyName.split(' ').length > 2)
                  Text(
                    companyName.split(' ').skip(2).join(' '),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.iconDark,
                    ),
                  ),
              ],
            ),
          ),
          _buildPremiumTag(),
        ],
      );
    } catch (e) {
      debugPrint('Error building header: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildCompanyIcon() {
    try {
      return Container(
        width: 40,
        height: 40,
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
              bottom: 20,
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
              top: 20,
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
                height: 8,
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

  Widget _buildPremiumTag() {
    try {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            Text(
              'Premium',
              style: GoogleFonts.poppins(
                fontSize: 12,
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

  Widget _buildInfoSection() {
    try {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardInfoBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildInfoItem(monthlyAmount, 'Monthly'),
            ),
            Expanded(
              child: _buildInfoItem(workshopCount, 'Workshop'),
            ),
            Expanded(
              child: _buildInfoItem(workshopCount, 'Workshop'),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building info section: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildInfoItem(String value, String label) {
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.iconDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
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

  Widget _buildActionButtons() {
    try {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCompareButton(),
          _buildViewButton(),
        ],
      );
    } catch (e) {
      debugPrint('Error building action buttons: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildCompareButton() {
    try {
      return OutlinedButton(
        onPressed: onCompare,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.compareButton, width: 1.5),
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          minimumSize: const Size(100, 40),
        ),
        child: Text(
          'Compare',
          style: GoogleFonts.inter(
            fontSize: 14,
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

  Widget _buildViewButton() {
    try {
      return ElevatedButton(
        onPressed: onView,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          minimumSize: const Size(100, 40),
          elevation: 0,
        ),
        child: Text(
          'View',
          style: GoogleFonts.inter(
            fontSize: 14,
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
