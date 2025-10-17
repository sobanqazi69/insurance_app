import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../../shared/models/insurance_model.dart';
import '../../features/home/presentation/pages/product_details_page.dart';

/// A reusable insurance card widget that displays insurance product information.
/// 
/// This widget provides:
/// - Company logo and name display
/// - Premium and payment information
/// - Interactive action buttons (Compare and View)
/// - Navigation to product details page
/// - Responsive design for all screen sizes
/// 
/// Features:
/// - Clean, professional design
/// - Proper error handling with fallback UI
/// - Smooth navigation integration
/// - Data model integration
/// 
/// Usage:
/// ```dart
/// InsuranceCard(
///   insurance: insuranceModel,
///   onCompare: () => handleCompare(),
/// )
/// ```
class InsuranceCard extends StatelessWidget {
  /// The insurance model containing all product details
  final InsuranceModel insurance;
  
  /// Callback triggered when compare button is tapped
  final VoidCallback? onCompare;
  
  /// Callback triggered when view button is tapped (optional, defaults to navigation)
  final VoidCallback? onView;

  /// Creates an insurance card widget
  const InsuranceCard({
    super.key,
    required this.insurance,
    this.onCompare,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    try {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final cardWidth = screenWidth * 0.85;
      final cardHeight = screenHeight * 0.35;
      final padding = screenHeight * 0.025;
      
      return Container(
        width: cardWidth,
        height: cardHeight,
        margin: EdgeInsets.only(right: screenWidth * 0.04),
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
              _buildHeader(context),
              SizedBox(height: padding),
              _buildInfoSection(context),
              SizedBox(height: padding),
              _buildActionButtons(context),
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

  Widget _buildHeader(BuildContext context) {
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
                  insurance.companyName.split(' ').take(2).join(' '),
                  style: GoogleFonts.inter(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.w600,
                    color: AppColors.iconDark,
                  ),
                ),
                if (insurance.companyName.split(' ').length > 2)
                  Text(
                    insurance.companyName.split(' ').skip(2).join(' '),
                    style: GoogleFonts.inter(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.w600,
                      color: AppColors.iconDark,
                    ),
                  ),
              ],
            ),
          ),
          _buildPremiumTag(context),
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
      final iconSize = screenHeight * 0.05;
      
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

  Widget _buildPremiumTag(BuildContext context) {
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
              insurance.premiumAmount,
              style: GoogleFonts.poppins(
                fontSize: screenHeight * 0.018,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            Text(
              'Premium',
              style: GoogleFonts.poppins(
                fontSize: screenHeight * 0.014,
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

  Widget _buildInfoSection(BuildContext context) {
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      
      return Container(
        padding: EdgeInsets.all(screenHeight * 0.015),
        decoration: BoxDecoration(
          color: AppColors.cardInfoBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildInfoItem(context, insurance.monthlyAmount, 'Monthly'),
            ),
            Expanded(
              child: _buildInfoItem(context, insurance.workshopCount, 'Workshop'),
            ),
            Expanded(
              child: _buildInfoItem(context, insurance.workshopCount, 'Workshop'),
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
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.w700,
              color: AppColors.iconDark,
            ),
          ),
          SizedBox(height: screenHeight * 0.002),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: screenHeight * 0.014,
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
        onPressed: onCompare,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.compareButton, width: 1.5),
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.015,
          ),
          minimumSize: Size(screenWidth * 0.25, screenHeight * 0.05),
        ),
        child: Text(
          'Compare',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.017,
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
        onPressed: () => _handleViewTap(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.015,
          ),
          minimumSize: Size(screenWidth * 0.25, screenHeight * 0.05),
          elevation: 0,
        ),
        child: Text(
          'View',
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.017,
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

  /// Handles view button tap with navigation to product details page
  void _handleViewTap(BuildContext context) {
    try {
      if (onView != null) {
        // Use custom callback if provided
        onView!();
      } else {
        // Default navigation to product details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(insurance: insurance),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error handling view tap: $e');
    }
  }
}
